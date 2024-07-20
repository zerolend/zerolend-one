// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {Pool} from '../../../../contracts/core/pool/Pool.sol';

import {PoolFactory} from '../../../../contracts/core/pool/PoolFactory.sol';
import {PoolConfigurator} from '../../../../contracts/core/pool/manager/PoolConfigurator.sol';
import {PoolErrorsLib} from '../../../../contracts/interfaces/errors/PoolErrorsLib.sol';
import {PoolEventsLib} from '../../../../contracts/interfaces/events/PoolEventsLib.sol';

import {DefaultReserveInterestRateStrategy} from '../../../../contracts/periphery/ir/DefaultReserveInterestRateStrategy.sol';

import {MintableERC20} from '../../../../contracts/mocks/MintableERC20.sol';
import {MockAggregator} from '../../../../contracts/mocks/MockAggregator.sol';
import {Test} from '../../../../lib/forge-std/src/Test.sol';

abstract contract CorePoolTests is Test {
  PoolFactory public poolFactory;
  Pool public poolImplementation;
  PoolConfigurator public configurator;

  DefaultReserveInterestRateStrategy public irStrategy;

  MintableERC20 public tokenA;
  MintableERC20 public tokenB;
  MintableERC20 public tokenC;

  MockAggregator public oracleA;
  MockAggregator public oracleB;
  MockAggregator public oracleC;

  address public owner;
  address public whale;
  address public ant;
  address public governance;

  function _setUpCorePool() internal {
    owner = address(this);
    whale = address(1);
    ant = address(2);
    governance = address(3);

    poolImplementation = new Pool();

    poolFactory = new PoolFactory(address(poolImplementation));
    configurator = new PoolConfigurator(address(poolFactory));

    poolFactory.setConfigurator(address(configurator));

    // create dummy tokens
    tokenA = new MintableERC20('TOKEN A', 'TOKENA');
    tokenB = new MintableERC20('TOKEN B', 'TOKENB');
    tokenC = new MintableERC20('TOKEN C', 'TOKENC');

    oracleA = new MockAggregator(1e8);
    oracleB = new MockAggregator(2 * 1e8);
    oracleC = new MockAggregator(100 * 1e8);

    irStrategy = new DefaultReserveInterestRateStrategy(47 * 1e25, 0, 7 * 1e25, 30 * 1e25);
  }
}
