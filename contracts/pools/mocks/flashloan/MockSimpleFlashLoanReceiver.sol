// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {SafeMath} from '@openzeppelin/contracts/utils/math/SafeMath.sol';
import {IERC20} from '@openzeppelin/contracts/interfaces/IERC20.sol';
import {SafeERC20} from '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import {IPoolAddressesProvider} from '../../interfaces/IPoolAddressesProvider.sol';
import {FlashLoanSimpleReceiverBase} from '../../../pools/protocol/FlashLoanSimpleReceiverBase.sol';
import {MintableERC20} from '../tokens/MintableERC20.sol';

contract MockFlashLoanSimpleReceiver is FlashLoanSimpleReceiverBase {
  using SafeERC20 for IERC20;
  using SafeMath for uint256;

  event ExecutedWithFail(address asset, uint256 amount, uint256 premium);
  event ExecutedWithSuccess(address asset, uint256 amount, uint256 premium);

  bool internal _failExecution;
  uint256 internal _amountToApprove;
  bool internal _simulateEOA;

  constructor(IPoolAddressesProvider provider) FlashLoanSimpleReceiverBase(provider) {}

  function setFailExecutionTransfer(bool fail) public {
    _failExecution = fail;
  }

  function setAmountToApprove(uint256 amountToApprove) public {
    _amountToApprove = amountToApprove;
  }

  function setSimulateEOA(bool flag) public {
    _simulateEOA = flag;
  }

  function getAmountToApprove() public view returns (uint256) {
    return _amountToApprove;
  }

  function simulateEOA() public view returns (bool) {
    return _simulateEOA;
  }

  function executeOperation(
    address asset,
    uint256 amount,
    uint256 premium,
    address, // initiator
    bytes memory // params
  ) public override returns (bool) {
    if (_failExecution) {
      emit ExecutedWithFail(asset, amount, premium);
      return !_simulateEOA;
    }

    //mint to this contract the specific amount
    MintableERC20 token = MintableERC20(asset);

    //check the contract has the specified balance
    require(amount <= IERC20(asset).balanceOf(address(this)), 'Invalid balance for the contract');

    uint256 amountToReturn = (_amountToApprove != 0) ? _amountToApprove : amount.add(premium);
    //execution does not fail - mint tokens and return them to the _destination

    token.mint(premium);

    IERC20(asset).approve(address(POOL), amountToReturn);

    emit ExecutedWithSuccess(asset, amount, premium);

    return true;
  }
}
