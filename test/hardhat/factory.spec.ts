import { DataTypes } from '../../types/IPool';
import { DefaultReserveInterestRateStrategy, MintableERC20, MockAggregator } from '../../types';
import { deployCore } from './fixtures/core';
import { PoolFactory } from '../../types/contracts/core/protocol/pool/PoolFactory';
import { ZeroAddress } from 'ethers';

describe('Factory', () => {
  let poolFactory: PoolFactory;

  let tokenA: MintableERC20;
  let tokenB: MintableERC20;
  let tokenC: MintableERC20;

  let oracleA: MockAggregator;
  let oracleB: MockAggregator;
  let oracleC: MockAggregator;

  let irStrategy: DefaultReserveInterestRateStrategy;

  before(async () => {
    const fixture = await deployCore();
    ({ poolFactory, tokenA, tokenB, tokenC, oracleA, oracleC, oracleB, irStrategy } = fixture);
  });

  it('Should create a new pool', async () => {
    const basicConfig: DataTypes.InitReserveConfigStruct = {
      ltv: 7500,
      liquidationThreshold: 8000,
      liquidationBonus: 10500,
      decimals: 18,
      frozen: false,
      borrowable: true,
      borrowCap: 0,
      supplyCap: 0,
    };

    const input: DataTypes.InitPoolParamsStruct = {
      hook: ZeroAddress,
      assets: [tokenA.target, tokenB.target, tokenC.target],
      rateStrategyAddresses: [irStrategy.target, irStrategy.target, irStrategy.target],
      sources: [oracleA.target, oracleB.target, oracleC.target],
      configurations: [basicConfig, basicConfig, basicConfig],
    };

    const tx = await poolFactory.createPool(input);

    // todo check logs
    // const receipt = await tx.wait();
    // console.log('pool created', receipt?.logs);
  });
});
