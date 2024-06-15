// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (governance/TimelockController.sol)

// TODO: take inspiration from morpho's metamorpho

pragma solidity 0.8.19;

import {AccessControlEnumerable} from '@openzeppelin/contracts/access/AccessControlEnumerable.sol';
import {ERC721Holder} from '@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol';
import {ERC1155Receiver, ERC1155Holder} from '@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol';
import {Address} from '@openzeppelin/contracts/utils/Address.sol';
import {ITimelock} from '../../../interfaces/ITimelock.sol';

/**
 * @dev Contract module which acts as a timelocked controller. When set as the
 * owner of an `Ownable` smart contract, it enforces a timelock on all
 * `onlyOwner` maintenance operations. This gives time for users of the
 * controlled contract to exit before a potentially dangerous maintenance
 * operation is applied.
 *
 * By default, this contract is self administered, meaning administration tasks
 * have to go through the timelock process. The proposer (resp executor) role
 * is in charge of proposing (resp executing) operations. A common use case is
 * to position this {TimelockController} as the owner of a smart contract, with
 * a multisig or a DAO as the sole proposer.
 */
contract TimelockedActions is ITimelock, AccessControlEnumerable, ERC721Holder, ERC1155Holder {
  uint256 internal constant _DONE_TIMESTAMP = uint256(1);
  mapping(bytes32 id => uint256) private _timestamps;
  uint256 private _minDelay;

  /**
   * @dev Initializes the contract with the following parameters:
   *
   * - `minDelay`: initial minimum delay in seconds for operations
   * - `proposers`: accounts to be granted proposer and canceller roles
   * - `executors`: accounts to be granted executor role
   * - `admin`: optional account to be granted admin role; disable with zero address
   *
   * IMPORTANT: The optional admin can aid with initial configuration of roles after deployment
   * without being subject to delay, but this role should be subsequently renounced in favor of
   * administration through timelocked proposals. Previous versions of this contract would assign
   * this admin to the deployer automatically and should be renounced as well.
   */
  constructor(uint256 minDelay) {
    _minDelay = minDelay;
  }

  /**
   * @dev Contract might receive/hold ETH as part of the maintenance process.
   */
  receive() external payable {}

  /**
   * @dev See {IERC165-supportsInterface}.
   */
  function supportsInterface(
    bytes4 interfaceId
  ) public view virtual override(AccessControlEnumerable, ERC1155Receiver) returns (bool) {
    return super.supportsInterface(interfaceId);
  }

  /**
   * @dev Returns whether an id corresponds to a registered operation. This
   * includes both Waiting, Ready, and Done operations.
   */
  function isOperation(bytes32 id) public view returns (bool) {
    return getOperationState(id) != OperationState.Unset;
  }

  /**
   * @dev Returns whether an operation is pending or not. Note that a "pending" operation may also be "ready".
   */
  function isOperationPending(bytes32 id) public view returns (bool) {
    OperationState state = getOperationState(id);
    return state == OperationState.Waiting || state == OperationState.Ready;
  }

  /**
   * @dev Returns whether an operation is ready for execution. Note that a "ready" operation is also "pending".
   */
  function isOperationReady(bytes32 id) public view returns (bool) {
    return getOperationState(id) == OperationState.Ready;
  }

  /**
   * @dev Returns whether an operation is done or not.
   */
  function isOperationDone(bytes32 id) public view returns (bool) {
    return getOperationState(id) == OperationState.Done;
  }

  /**
   * @dev Returns the timestamp at which an operation becomes ready (0 for
   * unset operations, 1 for done operations).
   */
  function getTimestamp(bytes32 id) public view virtual returns (uint256) {
    return _timestamps[id];
  }

  /**
   * @dev Returns operation state.
   */
  function getOperationState(bytes32 id) public view virtual returns (OperationState) {
    uint256 timestamp = getTimestamp(id);
    if (timestamp == 0) return OperationState.Unset;
    else if (timestamp == _DONE_TIMESTAMP) return OperationState.Done;
    else if (timestamp > block.timestamp) return OperationState.Waiting;
    return OperationState.Ready;
  }

  /**
   * @dev Returns the minimum delay in seconds for an operation to become valid.
   *
   * This value can be changed by executing an operation that calls `updateDelay`.
   */
  function getMinDelay() public view virtual returns (uint256) {
    return _minDelay;
  }

  /**
   * @dev Returns the identifier of an operation containing a single
   * transaction.
   */
  function hashOperation(
    address target,
    uint256 value,
    bytes calldata data,
    bytes32 salt
  ) public pure virtual returns (bytes32) {
    return keccak256(abi.encode(target, value, data, salt));
  }

  /**
   * @dev Schedule an operation containing a single transaction.
   *
   * Emits {CallSalt} if salt is nonzero, and {CallScheduled}.
   *
   * Requirements:
   *
   * - the caller must have the 'proposer' role.
   */
  function schedule(
    address target,
    uint256 value,
    bytes calldata data,
    bytes32 salt,
    uint256 delay
  ) internal virtual {
    bytes32 id = hashOperation(target, value, data, salt);
    _scheduleOp(id, delay);
    emit CallScheduled(id, 0, target, value, data, salt, delay);
  }

  /**
   * @dev Schedule an operation that is to become valid after a given delay.
   */
  function _scheduleOp(bytes32 id, uint256 delay) private {
    if (isOperation(id)) {
      revert TimelockUnexpectedOperationState(id, _encodeStateBitmap(OperationState.Unset));
    }
    uint256 minDelay = getMinDelay();
    if (delay < minDelay) {
      revert TimelockInsufficientDelay(delay, minDelay);
    }
    _timestamps[id] = block.timestamp + delay;
  }

  /**
   * @dev Cancel an operation.
   *
   * Requirements:
   *
   * - the caller must have the 'canceller' role.
   */
  function cancel(bytes32 id) internal {
    if (!isOperationPending(id)) {
      revert TimelockUnexpectedOperationState(
        id,
        _encodeStateBitmap(OperationState.Waiting) | _encodeStateBitmap(OperationState.Ready)
      );
    }
    delete _timestamps[id];

    emit Cancelled(id);
  }

  /**
   * @dev Execute an (ready) operation containing a single transaction.
   *
   * Emits a {CallExecuted} event.
   *
   * Requirements:
   *
   * - the caller must have the 'executor' role.
   */
  // This function can reenter, but it doesn't pose a risk because _afterCall checks that the proposal is pending,
  // thus any modifications to the operation during reentrancy should be caught.
  // slither-disable-next-line reentrancy-eth
  function execute(
    address target,
    uint256 value,
    bytes calldata payload,
    bytes32 salt
  ) public payable virtual {
    bytes32 id = hashOperation(target, value, payload, salt);
    _beforeCall(id);
    _execute(target, value, payload);
    emit CallExecuted(id, 0, target, value, salt, payload);
    _afterCall(id);
  }

  /**
   * @dev Execute an operation's call.
   */
  function _execute(address target, uint256 value, bytes calldata data) internal virtual {
    (bool success, bytes memory returndata) = target.call{value: value}(data);
    Address.verifyCallResult(success, returndata, 'call failed');
  }

  /**
   * @dev Checks before execution of an operation's calls.
   */
  function _beforeCall(bytes32 id) private view {
    if (!isOperationReady(id)) {
      revert TimelockUnexpectedOperationState(id, _encodeStateBitmap(OperationState.Ready));
    }
  }

  /**
   * @dev Checks after execution of an operation's calls.
   */
  function _afterCall(bytes32 id) private {
    if (!isOperationReady(id)) {
      revert TimelockUnexpectedOperationState(id, _encodeStateBitmap(OperationState.Ready));
    }
    _timestamps[id] = _DONE_TIMESTAMP;
  }

  /**
   * @dev Encodes a `OperationState` into a `bytes32` representation where each bit enabled corresponds to
   * the underlying position in the `OperationState` enum. For example:
   *
   * 0x000...1000
   *   ^^^^^^----- ...
   *         ^---- Done
   *          ^--- Ready
   *           ^-- Waiting
   *            ^- Unset
   */
  function _encodeStateBitmap(OperationState operationState) internal pure returns (bytes32) {
    return bytes32(1 << uint8(operationState));
  }
}
