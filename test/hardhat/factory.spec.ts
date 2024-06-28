import { ZeroAddress } from 'ethers';
import {
  DefaultReserveInterestRateStrategy,
  IPool,
  MintableERC20,
  MockAggregator,
} from '../../types';
import { PoolFactory } from '../../types/contracts/core/protocol/pool/PoolFactory';
import { deployCore } from './fixtures/core';

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
    const input: IPool.InitParamsStruct = {
      hook: ZeroAddress,
      assets: [tokenA.target, tokenB.target, tokenC.target],
      rateStrategyAddresses: [irStrategy.target, irStrategy.target, irStrategy.target],
      sources: [oracleA.target, oracleB.target, oracleC.target],
      configurations: [{ data: 0 }, { data: 0 }, { data: 0 }],
    };

    const tx = await poolFactory.createPool(input);

    // todo check logs
    // const receipt = await tx.wait();
    // console.log('pool created', receipt?.logs);
  });
});
