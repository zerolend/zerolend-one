import { DataTypes } from '../../../types/IPool';
import { DefaultReserveInterestRateStrategy, MintableERC20, MockAggregator } from '../../../types';
import { deployCore } from '../fixtures/core';
import { PoolFactory } from '../../../types/contracts/core/protocol/pool/PoolFactory';
import { ZeroAddress } from 'ethers';
import { basicConfig } from '../fixtures/pool';
import { expect } from 'chai';

describe('Pool Factory', () => {
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

  it('should create a new pool', async () => {
    const input: DataTypes.InitPoolParamsStruct = {
      hook: ZeroAddress,
      assets: [tokenA.target, tokenB.target, tokenC.target],
      rateStrategyAddresses: [irStrategy.target, irStrategy.target, irStrategy.target],
      sources: [oracleA.target, oracleB.target, oracleC.target],
      configurations: [basicConfig, basicConfig, basicConfig],
    };

    expect(await poolFactory.poolsLength()).eq(0);

    const tx = await poolFactory.createPool(input);
    await expect(tx).to.emit(poolFactory, 'PoolCreated');

    expect(await poolFactory.poolsLength()).eq(1);
  });
});
