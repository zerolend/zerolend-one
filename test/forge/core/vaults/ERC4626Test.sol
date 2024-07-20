// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

// import {IERC20Errors} from '../../lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol';
// import {IERC20Errors} from '@openzeppelin/contracts/interfaces/draft-IERC6093.sol';
import {IFlashLoanSimpleReceiver} from '../../../../contracts/interfaces/IFlashLoanSimpleReceiver.sol';
import {Math} from '@openzeppelin/contracts/utils/math/Math.sol';

import './helpers/IntegrationVaultTest.sol';

contract ERC4626Test is IntegrationVaultTest, IFlashLoanSimpleReceiver {
  function setUp() public {
    _setUpVault();
    _setCap(allMarkets[0], CAP);
    _sortSupplyQueueIdleLast();
  }

  function testDecimals(uint8 decimals) public {
    vm.mockCall(address(loanToken), abi.encodeWithSignature('decimals()'), abi.encode(decimals));
    assertEq(vault.decimals(), Math.max(18, decimals), 'decimals');
  }

  // function testMint(uint256 assets) public {
  //   assets = bound(assets, MIN_TEST_ASSETS, MAX_TEST_ASSETS);

  //   uint256 shares = vault.convertToShares(assets);

  //   loanToken.setBalance(supplier, assets);

  //   vm.expectEmit();
  //   emit EventsLib.UpdateLastTotalAssets(vault.totalAssets() + assets);
  //   vm.prank(supplier);
  //   uint256 deposited = vault.mint(shares, onBehalf);

  //   assertGt(deposited, 0, 'deposited');
  //   assertEq(loanToken.balanceOf(address(vault)), 0, 'balanceOf(vault)');
  //   assertEq(vault.balanceOf(onBehalf), shares, 'balanceOf(onBehalf)');
  //   assertEq(morpho.expectedSupplyAssets(allMarkets[0], address(vault)), assets, 'expectedSupplyAssets(vault)');
  // }

  // function testDeposit(uint256 assets) public {
  //   assets = bound(assets, MIN_TEST_ASSETS, MAX_TEST_ASSETS);

  //   loanToken.setBalance(supplier, assets);

  //   vm.expectEmit();
  //   emit EventsLib.UpdateLastTotalAssets(vault.totalAssets() + assets);
  //   vm.prank(supplier);
  //   uint256 shares = vault.deposit(assets, onBehalf);

  //   assertGt(shares, 0, 'shares');
  //   assertEq(loanToken.balanceOf(address(vault)), 0, 'balanceOf(vault)');
  //   assertEq(vault.balanceOf(onBehalf), shares, 'balanceOf(onBehalf)');
  //   assertEq(morpho.expectedSupplyAssets(allMarkets[0], address(vault)), assets, 'expectedSupplyAssets(vault)');
  // }

  // function testRedeem(uint256 deposited, uint256 redeemed) public {
  //   deposited = bound(deposited, MIN_TEST_ASSETS, MAX_TEST_ASSETS);

  //   loanToken.setBalance(supplier, deposited);

  //   vm.prank(supplier);
  //   uint256 shares = vault.deposit(deposited, onBehalf);

  //   redeemed = bound(redeemed, 0, shares);

  //   vm.expectEmit();
  //   emit EventsLib.UpdateLastTotalAssets(vault.totalAssets() - vault.convertToAssets(redeemed));
  //   vm.prank(onBehalf);
  //   vault.redeem(redeemed, receiver, onBehalf);

  //   assertEq(loanToken.balanceOf(address(vault)), 0, 'balanceOf(vault)');
  //   assertEq(vault.balanceOf(onBehalf), shares - redeemed, 'balanceOf(onBehalf)');
  // }

  // function testWithdraw(uint256 deposited, uint256 withdrawn) public {
  //   deposited = bound(deposited, MIN_TEST_ASSETS, MAX_TEST_ASSETS);
  //   withdrawn = bound(withdrawn, 0, deposited);

  //   loanToken.setBalance(supplier, deposited);

  //   vm.prank(supplier);
  //   uint256 shares = vault.deposit(deposited, onBehalf);

  //   vm.expectEmit();
  //   emit EventsLib.UpdateLastTotalAssets(vault.totalAssets() - withdrawn);
  //   vm.prank(onBehalf);
  //   uint256 redeemed = vault.withdraw(withdrawn, receiver, onBehalf);

  //   assertEq(loanToken.balanceOf(address(vault)), 0, 'balanceOf(vault)');
  //   assertEq(vault.balanceOf(onBehalf), shares - redeemed, 'balanceOf(onBehalf)');
  // }

  // function testWithdrawIdle(uint256 deposited, uint256 withdrawn) public {
  //   deposited = bound(deposited, MIN_TEST_ASSETS, MAX_TEST_ASSETS);
  //   withdrawn = bound(withdrawn, 0, deposited);

  //   _setCap(allMarkets[0], 0);

  //   loanToken.setBalance(supplier, deposited);

  //   vm.prank(supplier);
  //   uint256 shares = vault.deposit(deposited, onBehalf);

  //   vm.expectEmit();
  //   emit EventsLib.UpdateLastTotalAssets(vault.totalAssets() - withdrawn);
  //   vm.prank(onBehalf);
  //   uint256 redeemed = vault.withdraw(withdrawn, receiver, onBehalf);

  //   assertEq(loanToken.balanceOf(address(vault)), 0, 'balanceOf(vault)');
  //   assertEq(vault.balanceOf(onBehalf), shares - redeemed, 'balanceOf(onBehalf)');
  //   assertEq(_idle(), deposited - withdrawn, 'idle');
  // }

  // function testRedeemTooMuch(uint256 deposited) public {
  //   deposited = bound(deposited, MIN_TEST_ASSETS, MAX_TEST_ASSETS);

  //   loanToken.setBalance(supplier, deposited * 2);

  //   vm.startPrank(supplier);
  //   uint256 shares = vault.deposit(deposited, supplier);
  //   vault.deposit(deposited, onBehalf);
  //   vm.stopPrank();

  //   vm.prank(supplier);
  //   vm.expectRevert(abi.encodeWithSelector(IERC20Errors.ERC20InsufficientBalance.selector, supplier, shares, shares + 1));
  //   vault.redeem(shares + 1, receiver, supplier);
  // }

  // function testWithdrawAll(uint256 assets) public {
  //   assets = bound(assets, MIN_TEST_ASSETS, MAX_TEST_ASSETS);

  //   loanToken.setBalance(supplier, assets);

  //   vm.prank(supplier);
  //   uint256 minted = vault.deposit(assets, onBehalf);

  //   assertEq(vault.maxWithdraw(onBehalf), assets, 'maxWithdraw(onBehalf)');

  //   vm.prank(onBehalf);
  //   uint256 shares = vault.withdraw(assets, receiver, onBehalf);

  //   assertEq(shares, minted, 'shares');
  //   assertEq(vault.balanceOf(onBehalf), 0, 'balanceOf(onBehalf)');
  //   assertEq(loanToken.balanceOf(receiver), assets, 'loanToken.balanceOf(receiver)');
  //   assertEq(morpho.expectedSupplyAssets(allMarkets[0], address(vault)), 0, 'expectedSupplyAssets(vault)');
  // }

  // function testRedeemAll(uint256 deposited) public {
  //   deposited = bound(deposited, MIN_TEST_ASSETS, MAX_TEST_ASSETS);

  //   loanToken.setBalance(supplier, deposited);

  //   vm.prank(supplier);
  //   uint256 minted = vault.deposit(deposited, onBehalf);

  //   assertEq(vault.maxRedeem(onBehalf), minted, 'maxRedeem(onBehalf)');

  //   vm.prank(onBehalf);
  //   uint256 assets = vault.redeem(minted, receiver, onBehalf);

  //   assertEq(assets, deposited, 'assets');
  //   assertEq(vault.balanceOf(onBehalf), 0, 'balanceOf(onBehalf)');
  //   assertEq(loanToken.balanceOf(receiver), deposited, 'loanToken.balanceOf(receiver)');
  //   assertEq(morpho.expectedSupplyAssets(allMarkets[0], address(vault)), 0, 'expectedSupplyAssets(vault)');
  // }

  // function testRedeemNotDeposited(uint256 deposited) public {
  //   deposited = bound(deposited, MIN_TEST_ASSETS, MAX_TEST_ASSETS);

  //   loanToken.setBalance(supplier, deposited);

  //   vm.prank(supplier);
  //   uint256 shares = vault.deposit(deposited, onBehalf);

  //   vm.prank(supplier);
  //   vm.expectRevert(abi.encodeWithSelector(IERC20Errors.ERC20InsufficientBalance.selector, supplier, 0, shares));
  //   vault.redeem(shares, supplier, supplier);
  // }

  // function testRedeemNotApproved(uint256 deposited) public {
  //   deposited = bound(deposited, MIN_TEST_ASSETS, MAX_TEST_ASSETS);

  //   loanToken.setBalance(supplier, deposited);

  //   vm.prank(supplier);
  //   uint256 shares = vault.deposit(deposited, onBehalf);

  //   vm.prank(receiver);
  //   vm.expectRevert(abi.encodeWithSelector(IERC20Errors.ERC20InsufficientAllowance.selector, receiver, 0, shares));
  //   vault.redeem(shares, receiver, onBehalf);
  // }

  // function testWithdrawNotApproved(uint256 assets) public {
  //   assets = bound(assets, MIN_TEST_ASSETS, MAX_TEST_ASSETS);

  //   loanToken.setBalance(supplier, assets);

  //   vm.prank(supplier);
  //   vault.deposit(assets, onBehalf);

  //   uint256 shares = vault.previewWithdraw(assets);
  //   vm.prank(receiver);
  //   vm.expectRevert(abi.encodeWithSelector(IERC20Errors.ERC20InsufficientAllowance.selector, receiver, 0, shares));
  //   vault.withdraw(assets, receiver, onBehalf);
  // }

  // function testTransferFrom(uint256 deposited, uint256 toTransfer) public {
  //   deposited = bound(deposited, MIN_TEST_ASSETS, MAX_TEST_ASSETS);

  //   loanToken.setBalance(supplier, deposited);

  //   vm.prank(supplier);
  //   uint256 shares = vault.deposit(deposited, onBehalf);

  //   toTransfer = bound(toTransfer, 0, shares);

  //   vm.prank(onBehalf);
  //   vault.approve(supplier, toTransfer);

  //   vm.prank(supplier);
  //   vault.transferFrom(onBehalf, receiver, toTransfer);

  //   assertEq(vault.balanceOf(onBehalf), shares - toTransfer, 'balanceOf(onBehalf)');
  //   assertEq(vault.balanceOf(receiver), toTransfer, 'balanceOf(receiver)');
  //   assertEq(vault.balanceOf(supplier), 0, 'balanceOf(supplier)');
  // }

  // function testTransferFromNotApproved(uint256 deposited, uint256 amount) public {
  //   deposited = bound(deposited, MIN_TEST_ASSETS, MAX_TEST_ASSETS);

  //   loanToken.setBalance(supplier, deposited);

  //   vm.prank(supplier);
  //   uint256 shares = vault.deposit(deposited, onBehalf);

  //   amount = bound(amount, 0, shares);

  //   vm.prank(supplier);
  //   vm.expectRevert(abi.encodeWithSelector(IERC20Errors.ERC20InsufficientAllowance.selector, supplier, 0, shares));
  //   vault.transferFrom(onBehalf, receiver, shares);
  // }

  // function testWithdrawMoreThanBalanceButLessThanTotalAssets(uint256 deposited, uint256 assets) public {
  //   deposited = bound(deposited, MIN_TEST_ASSETS, MAX_TEST_ASSETS);

  //   loanToken.setBalance(supplier, deposited);

  //   vm.startPrank(supplier);
  //   uint256 shares = vault.deposit(deposited / 2, onBehalf);
  //   vault.deposit(deposited / 2, supplier);
  //   vm.stopPrank();

  //   assets = bound(assets, deposited / 2 + 1, vault.totalAssets());

  //   uint256 sharesBurnt = vault.previewWithdraw(assets);
  //   vm.expectRevert(abi.encodeWithSelector(IERC20Errors.ERC20InsufficientBalance.selector, onBehalf, shares, sharesBurnt));
  //   vm.prank(onBehalf);
  //   vault.withdraw(assets, receiver, onBehalf);
  // }

  // function testWithdrawMoreThanTotalAssets(uint256 deposited, uint256 assets) public {
  //   deposited = bound(deposited, MIN_TEST_ASSETS, MAX_TEST_ASSETS);

  //   loanToken.setBalance(supplier, deposited);

  //   vm.prank(supplier);
  //   vault.deposit(deposited, onBehalf);

  //   assets = bound(assets, deposited + 1, type(uint256).max / (deposited + 1));

  //   vm.prank(onBehalf);
  //   vm.expectRevert(ErrorsLib.NotEnoughLiquidity.selector);
  //   vault.withdraw(assets, receiver, onBehalf);
  // }

  // function testWithdrawMoreThanBalanceAndLiquidity(uint256 deposited, uint256 assets) public {
  //   deposited = bound(deposited, MIN_TEST_ASSETS, MAX_TEST_ASSETS);

  //   loanToken.setBalance(supplier, deposited);

  //   vm.prank(supplier);
  //   vault.deposit(deposited, onBehalf);

  //   assets = bound(assets, deposited + 1, type(uint256).max / (deposited + 1));

  //   collateralToken.setBalance(borrower, type(uint128).max);

  //   // Borrow liquidity.
  //   vm.startPrank(borrower);
  //   morpho.supplyCollateral(allMarkets[0], type(uint128).max, borrower, hex'');
  //   morpho.borrow(allMarkets[0], 1, 0, borrower, borrower);

  //   vm.startPrank(onBehalf);
  //   vm.expectRevert(ErrorsLib.NotEnoughLiquidity.selector);
  //   vault.withdraw(assets, receiver, onBehalf);
  // }

  // function testTransfer(uint256 deposited, uint256 toTransfer) public {
  //   deposited = bound(deposited, MIN_TEST_ASSETS, MAX_TEST_ASSETS);

  //   loanToken.setBalance(supplier, deposited);

  //   vm.prank(supplier);
  //   uint256 minted = vault.deposit(deposited, onBehalf);

  //   toTransfer = bound(toTransfer, 0, minted);

  //   vm.prank(onBehalf);
  //   vault.transfer(receiver, toTransfer);

  //   assertEq(vault.balanceOf(supplier), 0, 'balanceOf(supplier)');
  //   assertEq(vault.balanceOf(onBehalf), minted - toTransfer, 'balanceOf(onBehalf)');
  //   assertEq(vault.balanceOf(receiver), toTransfer, 'balanceOf(receiver)');
  // }

  // function testMaxWithdraw(uint256 depositedAssets, uint256 borrowedAssets) public {
  //   depositedAssets = bound(depositedAssets, MIN_TEST_ASSETS, MAX_TEST_ASSETS);
  //   borrowedAssets = bound(borrowedAssets, MIN_TEST_ASSETS, depositedAssets);

  //   loanToken.setBalance(supplier, depositedAssets);

  //   vm.prank(supplier);
  //   vault.deposit(depositedAssets, onBehalf);

  //   collateralToken.setBalance(borrower, type(uint128).max);

  //   vm.startPrank(borrower);
  //   morpho.supplyCollateral(allMarkets[0], type(uint128).max, borrower, hex'');
  //   morpho.borrow(allMarkets[0], borrowedAssets, 0, borrower, borrower);

  //   assertEq(vault.maxWithdraw(onBehalf), depositedAssets - borrowedAssets, 'maxWithdraw(onBehalf)');
  // }

  // function testMaxWithdrawFlashLoan(uint256 supplied, uint256 deposited) public {
  //   supplied = bound(supplied, MIN_TEST_ASSETS, MAX_TEST_ASSETS);
  //   deposited = bound(deposited, MIN_TEST_ASSETS, MAX_TEST_ASSETS);

  //   loanToken.setBalance(supplier, supplied);

  //   vm.prank(supplier);
  //   morpho.supply(allMarkets[0], supplied, 0, onBehalf, hex'');

  //   loanToken.setBalance(supplier, deposited);

  //   vm.prank(supplier);
  //   vault.deposit(deposited, onBehalf);

  //   assertGt(vault.maxWithdraw(onBehalf), 0);

  //   loanToken.approve(address(morpho), type(uint256).max);
  //   morpho.flashLoan(address(loanToken), loanToken.balanceOf(address(morpho)), hex'');
  // }

  // function testMaxDeposit() public {
  //   _setCap(allMarkets[0], 1 ether);

  //   Id[] memory supplyQueue = new Id[](1);
  //   supplyQueue[0] = allMarkets[0].id();

  //   vm.prank(allocator);
  //   vault.setSupplyQueue(supplyQueue);

  //   loanToken.setBalance(supplier, 1 ether);
  //   collateralToken.setBalance(borrower, 2 ether);

  //   vm.prank(supplier);
  //   morpho.supply(allMarkets[0], 1 ether, 0, supplier, hex'');

  //   vm.startPrank(borrower);
  //   morpho.supplyCollateral(allMarkets[0], 2 ether, borrower, hex'');
  //   morpho.borrow(allMarkets[0], 1 ether, 0, borrower, borrower);
  //   vm.stopPrank();

  //   _forward(1_000);

  //   loanToken.setBalance(supplier, 1 ether);

  //   vm.prank(supplier);
  //   vault.deposit(1 ether, onBehalf);

  //   assertEq(vault.maxDeposit(supplier), 0);
  // }

  function executeOperation(address, uint256, uint256, address, bytes calldata) external view returns (bool) {
    assertEq(vault.maxWithdraw(onBehalf), 0);
    return true;
  }
}
