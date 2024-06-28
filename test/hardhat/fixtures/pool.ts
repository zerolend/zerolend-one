import { ethers } from 'hardhat';
import { IPool } from '../../../types/contracts/core/interfaces';
import { deployCore } from './core';
import { ZeroAddress, parseEther } from 'ethers';

export async function deployPool() {
  const fixture = await deployCore();
  const { factory, configurator, tokenA, tokenB, tokenC, irStrategy, oracleA, oracleB, oracleC } = fixture;

  const input: IPool.InitParamsStruct = {
    hook: ZeroAddress,
    assets: [tokenA.target, tokenB.target, tokenC.target],
    rateStrategyAddresses: [irStrategy.target, irStrategy.target, irStrategy.target],
    sources: [oracleA.target, oracleB.target, oracleC.target],
    configurations: [{ data: 0 }, { data: 0 }, { data: 0 }],
  };

  // create a pool
  await factory.createPool(input);

  // grab the instance and return
  const poolAddr = await factory.pools(0);
  const pool = await ethers.getContractAt('Pool', poolAddr);

  await configurator.setReserveBorrowing(poolAddr, tokenA.target, true);
  await configurator.setReserveBorrowing(poolAddr, tokenB.target, true);
  await configurator.setReserveBorrowing(poolAddr, tokenC.target, true);

  return {
    ...fixture,
    pool,
  };
}
