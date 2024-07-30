// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {Pool} from '../../../../contracts/core/pool/Pool.sol';

import {MintableERC20} from '../../../../contracts/mocks/MintableERC20.sol';
import {Test} from '../../../../lib/forge-std/src/Test.sol';
import {DataTypes} from 'contracts/core/pool/configuration/DataTypes.sol';
import {NFTPositionManager} from 'contracts/core/positions/NFTPositionManager.sol';
import {INFTPositionManager} from 'contracts/interfaces/INFTPositionManager.sol';
import {NFTErrorsLib} from 'contracts/interfaces/errors/NFTErrorsLib.sol';
import {NFTEventsLib} from 'contracts/interfaces/events/NFTEventsLib.sol';

import {console} from 'lib/forge-std/src/console.sol';
import {DeployNFTPositionManager} from 'test/forge/core/positions/deploynftpositionmanager.t.sol';

contract NFTPostionManagerTest is DeployNFTPositionManager {
  address alice = address(1);
  address bob = address(2);

  function setUp() public {
    _setUpPool();
    _setup();
  }

  function testNFTPositionManagerNFTName() external view {
    assertEq(nftPositionManager.name(), 'ZeroLend One Position');
  }

  function testNFTPositionManagerNFTSymbol() external view {
    assertEq(nftPositionManager.symbol(), 'ZL-POS-ONE');
  }

  function testShouldRevertIfNotDeployedFactory() external {
    vm.expectRevert(bytes('not a pool'));
    nftPositionManager.mint(address(0));
  }

  function testShouldRevertSupplyInvalidAddress() external {
    DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
    INFTPositionManager.AssetOperationParams memory params = INFTPositionManager.AssetOperationParams(address(0), address(0), 0, 0, data);
    vm.startPrank(alice);
    vm.expectRevert(NFTErrorsLib.ZeroAddressNotAllowed.selector);
    nftPositionManager.supply(params);
    vm.stopPrank();
  }

  function testShouldRevertSupplyInvalidAmount() external {
    DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
    INFTPositionManager.AssetOperationParams memory params = INFTPositionManager.AssetOperationParams(address(tokenA), alice, 0, 0, data);
    vm.startPrank(alice);
    vm.expectRevert(NFTErrorsLib.ZeroValueNotAllowed.selector);
    nftPositionManager.supply(params);
    vm.stopPrank();
  }

  function testShouldSupplyAlice() public {
    uint256 mintAmount = 100 ether;
    uint256 supplyAmount = 50 ether;
    uint256 tokenId = 1;

    DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
    INFTPositionManager.AssetOperationParams memory params =
      INFTPositionManager.AssetOperationParams(address(tokenA), alice, supplyAmount, tokenId, data);

    _mintAndApprove(alice, tokenA, mintAmount, address(nftPositionManager));

    vm.startPrank(alice);
    nftPositionManager.mint(address(pool));
    vm.expectEmit(true, true, true, true);
    emit NFTEventsLib.Supply(address(tokenA), 1, supplyAmount);
    nftPositionManager.supply(params);

    INFTPositionManager.Position memory position = nftPositionManager.positions(1);

    assertEq(position.pool, address(pool));
    assertEq(position.operator, address(0));

    vm.stopPrank();
  }

  function testShouldSupplyETHAlice() public {
    uint256 supplyAmount = 50 ether;
    uint256 tokenId = 1;

    DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
    INFTPositionManager.AssetOperationParams memory params =
      INFTPositionManager.AssetOperationParams(address(0), alice, supplyAmount, tokenId, data);

    console.log('Manager Balance Before ETH', address(nftPositionManager).balance);

    vm.deal(alice, 1000 ether);

    vm.startPrank(alice);

    nftPositionManager.mint(address(pool));
    vm.expectEmit(true, true, true, true);
    emit NFTEventsLib.Supply(address(wethToken), 1, supplyAmount);

    nftPositionManager.supplyETH{value: supplyAmount}(params);

    INFTPositionManager.Position memory position = nftPositionManager.positions(1);

    assertEq(position.pool, address(pool));
    assertEq(position.operator, address(0));

    console.log('Manager Balance AfterSupply ETH', address(nftPositionManager).balance);

    vm.stopPrank();
  }

  function testShouldRevertWithdrawInvalidAddress() external {
    testShouldSupplyAlice();
    DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
    INFTPositionManager.AssetOperationParams memory params = INFTPositionManager.AssetOperationParams(address(0), alice, 10 ether, 1, data);

    vm.startPrank(alice);
    vm.expectRevert(NFTErrorsLib.ZeroAddressNotAllowed.selector);
    nftPositionManager.withdraw(params);
    vm.stopPrank();
  }

  function testShouldRevertWithdrawInvalidAmount() external {
    testShouldSupplyAlice();
    DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
    INFTPositionManager.AssetOperationParams memory params = INFTPositionManager.AssetOperationParams(address(tokenA), alice, 0, 1, data);

    vm.startPrank(alice);
    vm.expectRevert(NFTErrorsLib.ZeroValueNotAllowed.selector);
    nftPositionManager.withdraw(params);
    vm.stopPrank();
  }

  function testShouldRevertCallerNotOwner() external {
    testShouldSupplyAlice();
    DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
    INFTPositionManager.AssetOperationParams memory params =
      INFTPositionManager.AssetOperationParams(address(tokenA), alice, 10 ether, 1, data);

    vm.startPrank(bob);
    vm.expectRevert(NFTErrorsLib.NotTokenIdOwner.selector);
    nftPositionManager.withdraw(params);
    vm.stopPrank();
  }

  function testShouldWithdraw() external {
    testShouldSupplyAlice();
    DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
    INFTPositionManager.AssetOperationParams memory params =
      INFTPositionManager.AssetOperationParams(address(tokenA), alice, 10 ether, 1, data);

    vm.startPrank(alice);
    vm.expectEmit(true, true, true, true);
    emit NFTEventsLib.Withdraw(address(tokenA), 10 ether, 1);
    nftPositionManager.withdraw(params);
    vm.stopPrank();
  }

  // TODO:
  // function testShouldWithdrawETH() external {
  //   testShouldSupplyETHAlice();
  //   DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
  //   INFTPositionManager.AssetOperationParams memory params = INFTPositionManager.AssetOperationParams(
  //     address(wethToken),
  //     alice,
  //     10 ether,
  //     1,
  //     data
  //   );

  //   console.log('Manager Balance ETH', address(nftPositionManager).balance);

  //   vm.startPrank(alice);
  //   vm.expectEmit(true, true, true, true);
  //   emit NFTEventsLib.Withdraw(address(wethToken), 10 ether, 1);
  //   nftPositionManager.withdrawETH(params);
  //   console.log('Manager Balance After Withdraw ETH', address(nftPositionManager).balance);
  //   vm.stopPrank();
  // }

  function testShouldRevertTokenIdNotExist() external {
    vm.expectRevert(bytes('ERC721: invalid token ID'));
    nftPositionManager.getApproved(1);
  }

  function testOperatorAddressTokenIdExist() external {
    uint256 supplyAmount = 10 ether;
    uint256 mintAmount = 100 ether;

    tokenA.mint(bob, mintAmount);

    DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
    INFTPositionManager.AssetOperationParams memory params =
      INFTPositionManager.AssetOperationParams(address(tokenA), bob, supplyAmount, 0, data);

    vm.startPrank(bob);
    tokenA.approve(address(nftPositionManager), supplyAmount);
    nftPositionManager.mint(address(pool));
    nftPositionManager.supply(params);

    nftPositionManager.approve(alice, 1);
    vm.stopPrank();

    vm.startPrank(bob);
    address operator = nftPositionManager.getApproved(1);
    assertEq(operator, alice);
    vm.stopPrank();
  }

  function testRevertBorrowInvalidAddress() external {
    testShouldSupplyAlice();
    DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
    INFTPositionManager.AssetOperationParams memory params = INFTPositionManager.AssetOperationParams(address(0), alice, 10 ether, 1, data);

    vm.startPrank(alice);
    vm.expectRevert(NFTErrorsLib.ZeroAddressNotAllowed.selector);
    nftPositionManager.borrow(params);
    vm.stopPrank();
  }

  function testRevertBorrowInvalidAmount() external {
    testShouldSupplyAlice();
    DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
    INFTPositionManager.AssetOperationParams memory params = INFTPositionManager.AssetOperationParams(address(tokenA), alice, 0, 1, data);

    vm.startPrank(alice);
    vm.expectRevert(NFTErrorsLib.ZeroValueNotAllowed.selector);
    nftPositionManager.borrow(params);
    vm.stopPrank();
  }

  function testRevertBorrowCallerNotOwner() external {
    testShouldSupplyAlice();
    DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
    INFTPositionManager.AssetOperationParams memory params =
      INFTPositionManager.AssetOperationParams(address(tokenA), alice, 10 ether, 1, data);

    vm.startPrank(bob);
    vm.expectRevert(NFTErrorsLib.NotTokenIdOwner.selector);
    nftPositionManager.withdraw(params);
    vm.stopPrank();
  }

  function testShouldBorrow() external {
    testShouldSupplyAlice();
    DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
    INFTPositionManager.AssetOperationParams memory params =
      INFTPositionManager.AssetOperationParams(address(tokenA), alice, 30 ether, 1, data);

    vm.startPrank(alice);
    nftPositionManager.borrow(params);
    assertEq(tokenA.balanceOf(address(pool)), 20 ether, 'Pool Revert');
    assertEq(tokenA.balanceOf(alice), 80 ether, 'Alice Revert');
    vm.stopPrank();
  }

  //TODO:
  // function testShouldBorrowETH() external {
  //   testShouldSupplyETHAlice();
  //   DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
  //   INFTPositionManager.AssetOperationParams memory params = INFTPositionManager.AssetOperationParams(
  //     address(wethToken),
  //     alice,
  //     30 ether,
  //     1,
  //     data
  //   );

  //   vm.startPrank(alice);
  //   nftPositionManager.borrowETH(params);
  //   assertEq(tokenA.balanceOf(address(pool)), 20 ether, 'Pool Revert');
  //   assertEq(tokenA.balanceOf(alice), 80 ether, 'Alice Revert');
  //   vm.stopPrank();
  // }

  function testRevertRepayInvalidAddress() external {
    testShouldSupplyAlice();
    DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
    INFTPositionManager.AssetOperationParams memory params = INFTPositionManager.AssetOperationParams(address(0), alice, 10 ether, 1, data);

    vm.startPrank(alice);
    vm.expectRevert(NFTErrorsLib.ZeroAddressNotAllowed.selector);
    nftPositionManager.borrow(params);
    vm.stopPrank();
  }

  function testRevertRepayInvalidAmount() external {
    testShouldSupplyAlice();
    DataTypes.ExtraData memory data = DataTypes.ExtraData(bytes(''), bytes(''));
    INFTPositionManager.AssetOperationParams memory params = INFTPositionManager.AssetOperationParams(address(tokenA), alice, 0, 1, data);

    vm.startPrank(alice);
    vm.expectRevert(NFTErrorsLib.ZeroValueNotAllowed.selector);
    nftPositionManager.borrow(params);
    vm.stopPrank();
  }

  function testShouldRevertNonAdmin() external {
    vm.startPrank(bob);
    vm.expectRevert();
    nftPositionManager.sweep(address(tokenA));
  }

  function testShouldRevertNonAdminETH() external {
    vm.startPrank(bob);
    vm.expectRevert();
    nftPositionManager.sweep(address(0));
  }
}
