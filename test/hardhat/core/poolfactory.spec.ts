import { DataTypes } from '../../../types/IPool';
import {
  BorrowLogic__factory,
  DefaultReserveInterestRateStrategy,
  MintableERC20,
  MockAggregator,
} from '../../../types';
import { deployCore } from '../fixtures/core';
import { PoolFactory } from '../../../types/contracts/core/pool/PoolFactory';
import { Addressable, ZeroAddress } from 'ethers';
import { basicConfig } from '../fixtures/pool';
import { expect } from 'chai';
import { ethers } from 'hardhat';

describe('Pool Factory', () => {
  let poolFactory: PoolFactory;

  let tokenA: MintableERC20;
  let tokenB: MintableERC20;
  let tokenC: MintableERC20;

  let oracleA: MockAggregator;
  let oracleB: MockAggregator;
  let oracleC: MockAggregator;

  let irStrategy: DefaultReserveInterestRateStrategy;

  let libraries: {
    BorrowLogic: string | Addressable;
    FlashLoanLogic: string | Addressable;
    LiquidationLogic: string | Addressable;
    PoolLogic: string | Addressable;
    SupplyLogic: string | Addressable;
  };

  beforeEach(async () => {
    const fixture = await deployCore();
    ({ poolFactory, libraries, tokenA, tokenB, tokenC, oracleA, oracleC, oracleB, irStrategy } =
      fixture);
  });

  it('should create a new pool', async () => {
    const input: DataTypes.InitPoolParamsStruct = {
      hook: ZeroAddress,
      assets: [tokenA.target, tokenB.target, tokenC.target],
      rateStrategyAddresses: [irStrategy.target, irStrategy.target, irStrategy.target],
      sources: [oracleA.target, oracleB.target, oracleC.target],
      configurations: [basicConfig, basicConfig, basicConfig],
    };

    await expect(await poolFactory.poolsLength()).eq(0);

    const tx = await poolFactory.createPool(input);
    await expect(tx).to.emit(poolFactory, 'PoolCreated');

    await expect(await poolFactory.poolsLength()).eq(1);
  });

  it('should update pool implementation properly and not allow re-init(..)', async () => {
    const input: DataTypes.InitPoolParamsStruct = {
      hook: ZeroAddress,
      assets: [tokenA.target, tokenB.target, tokenC.target],
      rateStrategyAddresses: [irStrategy.target, irStrategy.target, irStrategy.target],
      sources: [oracleA.target, oracleB.target, oracleC.target],
      configurations: [basicConfig, basicConfig, basicConfig],
    };

    // should deploy pool
    const tx = await poolFactory.createPool(input);

    await expect(tx).to.emit(poolFactory, 'PoolCreated');
    await expect(await poolFactory.poolsLength()).eq(1);
    const poolAddr = await poolFactory.pools(0);

    const pool = await ethers.getContractAt('Pool', poolAddr);
    await expect(await pool.revision()).eq('1');

    // now try to upgrade the beacon
    const UpgradedPool = await ethers.getContractFactory('UpgradedPool', { libraries });
    const upgradedPool = await UpgradedPool.deploy();
    const tx2 = await poolFactory.setImplementation(upgradedPool.target);
    await expect(tx2).to.emit(poolFactory, 'ImplementationUpdated');

    // check if the pool upgraded properly
    await expect(await pool.revision()).eq('1000');
    await expect(pool.initialize(input)).to.revertedWith(
      'Initializable: contract is already initialized'
    );
  });
});
