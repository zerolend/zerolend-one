import { ZeroAddress } from 'ethers';
import {
  DefaultReserveInterestRateStrategy,
  IPool,
  MintableERC20,
  MockAggregator,
} from '../../types';
import { Factory } from '../../types/contracts/core/protocol/factory/Factory';
import { deployCore } from './fixtures/core';

describe('Factory', () => {
  let factory: Factory;

  let tokenA: MintableERC20;
  let tokenB: MintableERC20;
  let tokenC: MintableERC20;

  let oracleA: MockAggregator;
  let oracleB: MockAggregator;
  let oracleC: MockAggregator;

  let irStrategy: DefaultReserveInterestRateStrategy;

  before(async () => {
    const fixture = await deployCore();
    ({ factory, tokenA, tokenB, tokenC, oracleA, oracleC, oracleB, irStrategy } = fixture);
  });

  it('Should create a new pool', async () => {
    const input: IPool.InitParamsStruct = {
      hook: ZeroAddress,
      assets: [tokenA.target, tokenB.target, tokenC.target],
      rateStrategyAddresses: [irStrategy.target, irStrategy.target, irStrategy.target],
      sources: [oracleA.target, oracleB.target, oracleC.target],
      configurations: [{ data: 0 }, { data: 0 }, { data: 0 }],
    };

    const tx = await factory.createPool(input);

    // todo check logs
    // const receipt = await tx.wait();
    // console.log('pool created', receipt?.logs);
  });
});
