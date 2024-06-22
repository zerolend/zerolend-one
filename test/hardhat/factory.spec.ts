import { ZeroAddress } from 'ethers';
import { IPool } from '../../types';
import { Factory } from '../../types/contracts/core/protocol/factory/Factory';
import { deployCore } from './fixtures/core';

describe('Factory', () => {
  let factory: Factory;

  before(async () => {
    const fixture = await deployCore();
    factory = fixture.factory;
  });

  it('Should create a new pool', async () => {
    const input: IPool.InitParamsStruct = {
      hook: ZeroAddress,
      assets: [],
      rateStrategyAddresses: [],
      sources: [],
      configurations: [],
    };

    const tx = await factory.createPool(input);
    console.log('pool created', tx.hash);
  });
});
