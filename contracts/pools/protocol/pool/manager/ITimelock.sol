// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (governance/TimelockController.sol)

pragma solidity ^0.8.20;

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
interface ITimelock {
  enum OperationState {
    Unset,
    Waiting,
    Ready,
    Done
  }

  /**
   * @dev Mismatch between the parameters length for an operation call.
   */
  error TimelockInvalidOperationLength(uint256 targets, uint256 payloads, uint256 values);

  /**
   * @dev The schedule operation doesn't meet the minimum delay.
   */
  error TimelockInsufficientDelay(uint256 delay, uint256 minDelay);

  /**
   * @dev The current state of an operation is not as required.
   * The `expectedStates` is a bitmap with the bits enabled for each OperationState enum position
   * counting from right to left.
   *
   * See {_encodeStateBitmap}.
   */
  error TimelockUnexpectedOperationState(bytes32 operationId, bytes32 expectedStates);

  /**
   * @dev The predecessor to an operation not yet done.
   */
  error TimelockUnexecutedPredecessor(bytes32 predecessorId);

  /**
   * @dev The caller account is not authorized.
   */
  error TimelockUnauthorizedCaller(address caller);

  /**
   * @dev Emitted when a call is scheduled as part of operation `id`.
   */
  event CallScheduled(
    bytes32 indexed id,
    uint256 indexed index,
    address target,
    uint256 value,
    bytes data,
    bytes32 predecessor,
    uint256 delay
  );

  /**
   * @dev Emitted when a call is performed as part of operation `id`.
   */
  event CallExecuted(
    bytes32 indexed id,
    uint256 indexed index,
    address target,
    uint256 value,
    bytes data
  );

  /**
   * @dev Emitted when new proposal is scheduled with non-zero salt.
   */
  event CallSalt(bytes32 indexed id, bytes32 salt);

  /**
   * @dev Emitted when operation `id` is cancelled.
   */
  event Cancelled(bytes32 indexed id);

  /**
   * @dev Emitted when the minimum delay for future operations is modified.
   */
  event MinDelayChange(uint256 oldDuration, uint256 newDuration);
}
