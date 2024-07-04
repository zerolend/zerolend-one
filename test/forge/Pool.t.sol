// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {PoolFactoryTest, Pool} from './Core.t.sol';
import {IPool} from './../../contracts/interfaces/IPool.sol';

import {DataTypes} from './../../contracts/core/pool/configuration/DataTypes.sol';

import {PoolConfigurator} from './../../contracts/core/pool/manager/PoolConfigurator.sol';
import {MintableERC20} from './../../contracts/mocks/tokens/MintableERC20.sol';
import {MockAggregator} from './../../contracts/mocks/tests/MockAggregator.sol';
import {DefaultReserveInterestRateStrategy} from './../../contracts/core/pool/DefaultReserveInterestRateStrategy.sol';

contract PoolSetup is PoolFactoryTest {
  DataTypes.InitPoolParams internal inputParams;
  DataTypes.InitReserveConfig internal basicConfig;
  DataTypes.InitReserveConfig[] configurations;

  Pool public pool;

  event Supply(address indexed reserve, bytes32 indexed pos, uint256 amount);
  event Withdraw(address indexed reserve, bytes32 indexed pos, address indexed to, uint256 amount);

  function setUp() public {
    config_factory();
    DataTypes.InitReserveConfig memory basicConfigLocal = DataTypes.InitReserveConfig({
      ltv: 7500,
      liquidationThreshold: 8000,
      liquidationBonus: 10500,
      decimals: 18,
      frozen: false,
      borrowable: true,
      borrowCap: 0,
      supplyCap: 0
    });

    address[] memory assets = new address[](3);
    assets[0] = address(tokenA);
    assets[1] = address(tokenB);
    assets[2] = address(tokenC);

    address[] memory rateStrategyAddresses = new address[](3);
    rateStrategyAddresses[0] = address(irStrategy);
    rateStrategyAddresses[1] = address(irStrategy);
    rateStrategyAddresses[2] = address(irStrategy);

    address[] memory sources = new address[](3);
    sources[0] = address(oracleA);
    sources[1] = address(oracleB);
    sources[2] = address(oracleC);

    DataTypes.InitReserveConfig[] memory configurationLocal = new DataTypes.InitReserveConfig[](3);
    configurationLocal[0] = basicConfigLocal;
    configurationLocal[1] = basicConfigLocal;
    configurationLocal[2] = basicConfigLocal;

    DataTypes.InitPoolParams memory inputParamsLocal = DataTypes.InitPoolParams({
      hook: address(0),
      assets: assets,
      rateStrategyAddresses: rateStrategyAddresses,
      sources: sources,
      configurations: configurationLocal
    });

    poolFactory.createPool(inputParamsLocal);

    IPool poolAddr = poolFactory.pools(0);

    pool = Pool(address(poolAddr));
  }

  function testPoolFactoryLength() external view {
    assertEq(poolFactory.poolsLength(), 1);
  }

  function testReserveList() external view {
    address[] memory reserveList = pool.getReservesList();
    assertEq(reserveList[0], address(tokenA));
    assertEq(reserveList[1], address(tokenB));
    assertEq(reserveList[2], address(tokenC));
  }

  /// ------------Supply------------
  function testSupplyAmountZero() external {
    vm.expectRevert(bytes('INVALID_AMOUNT'));
    pool.supplySimple(address(tokenA), 0, 0);
  }

  function testSupplyEventEmit() external {
    uint256 index = 0;
    address user = owner;
    uint256 supplyAmount = 50 ether;
    bytes32 pos = keccak256(abi.encodePacked(user, 'index', index));

    vm.startPrank(owner);

    tokenA.mint(150 ether);
    tokenA.approve(address(pool), supplyAmount);

    vm.expectEmit(true, true, false, true);

    emit Supply(address(tokenA), pos, supplyAmount);

    pool.supplySimple(address(tokenA), supplyAmount, index);

    vm.stopPrank();
  }

  function testFailSupplyZeroAssetAddress() external {
    pool.supplySimple(address(0), 50 ether, 0);
  }

  function testPoolSupply() external {
    uint256 supplyAmount = 50 ether;
    uint256 mintAmount = 150 ether;
    uint256 index = 1;
    vm.startPrank(owner);
    tokenA.mint(mintAmount);
    tokenA.approve(address(pool), supplyAmount);
    pool.supplySimple(address(tokenA), supplyAmount, index);
    assertEq(tokenA.balanceOf(address(pool)), supplyAmount);
    assertEq(tokenA.balanceOf(owner), mintAmount - supplyAmount);

    assertEq(pool.getTotalSupplyRaw(address(tokenA)).supplyShares, supplyAmount);
    assertEq(pool.getTotalSupplyRaw(address(tokenA)).debtShares, 0);
    assertEq(pool.getBalanceRaw(address(tokenA), owner, index).debtShares, 0);
    assertEq(pool.getBalanceRaw(address(tokenA), owner, index).supplyShares, supplyAmount);

    vm.stopPrank();
  }

  /// ------------Withdraw------------
  function testWithdrawAmountZero() external {
    vm.expectRevert(bytes('INVALID_AMOUNT'));
    pool.withdrawSimple(address(tokenA), 0, 0);
  }

  function testFailWithdrawZeroAssetAddress() external {
    pool.withdrawSimple(address(0), 50 ether, 0);
  }

  function testWithdrawEventEmit() external {
    uint256 supplyAmount = 50 ether;
    uint256 mintAmount = 150 ether;
    uint256 withdrawAmount = 50 ether;
    address user = owner;
    uint256 index = 1;
    bytes32 pos = keccak256(abi.encodePacked(user, 'index', index));

    vm.startPrank(owner);
    tokenA.mint(mintAmount);
    tokenA.approve(address(pool), supplyAmount);

    vm.expectEmit(true, true, false, true);
    emit Supply(address(tokenA), pos, supplyAmount);
    pool.supplySimple(address(tokenA), supplyAmount, index);

    assertEq(tokenA.balanceOf(address(pool)), supplyAmount);
    assertEq(tokenA.balanceOf(owner), mintAmount - supplyAmount);

    vm.expectEmit(true, true, true, true);
    emit Withdraw(address(tokenA), pos, owner, withdrawAmount);

    pool.withdrawSimple(address(tokenA), withdrawAmount, index);
    vm.stopPrank();
  }

  function testPoolWithdraw() external {
    uint256 supplyAmount = 50 ether;
    uint256 mintAmount = 150 ether;
    uint256 withdrawAmount = 30 ether;
    uint256 index = 1;

    vm.startPrank(owner);
    tokenA.mint(mintAmount);
    tokenA.approve(address(pool), supplyAmount);

    pool.supplySimple(address(tokenA), supplyAmount, index);

    assertEq(tokenA.balanceOf(address(pool)), supplyAmount, 'Pool Balance Supply');
    assertEq(tokenA.balanceOf(owner), mintAmount - supplyAmount, 'Owner Balance Supply');
    assertEq(pool.getTotalSupplyRaw(address(tokenA)).supplyShares, supplyAmount);
    assertEq(pool.getBalanceRaw(address(tokenA), owner, index).supplyShares, supplyAmount);

    pool.withdrawSimple(address(tokenA), withdrawAmount, index);
    assertEq(tokenA.balanceOf(address(pool)), supplyAmount - withdrawAmount, 'Pool Balance Withdraw');
    assertEq(tokenA.balanceOf(owner), (mintAmount - supplyAmount) + withdrawAmount, 'Owner Balance Withdraw');
    assertEq(pool.getTotalSupplyRaw(address(tokenA)).supplyShares, supplyAmount - withdrawAmount);
    assertEq(pool.getBalanceRaw(address(tokenA), owner, index).supplyShares, supplyAmount - withdrawAmount);
  }
}
