import { parseEther as eth } from 'ethers';
import { MintableERC20 } from '../../../types';
import { Pool } from '../../../types/contracts/core/pool';
import { deployPool, RAY } from '../fixtures/pool';
import { expect } from 'chai';
import { time } from '@nomicfoundation/hardhat-network-helpers';

import { SignerWithAddress } from '@nomicfoundation/hardhat-ethers/signers';

describe.only('Pool - Liquidity Index', () => {
  let pool: Pool;
  let tokenA: MintableERC20;
  let deployer: SignerWithAddress;

  beforeEach(async () => {
    const fixture = await deployPool();
    ({ tokenA, pool, owner: deployer } = fixture);

    // mint some tokens and give approval
    await tokenA['mint(uint256)'](eth('10'));
    await tokenA.approve(pool.target, eth('3'));
  });

  it('liquidity index for a new reserve should be set to 1 ray', async () => {
    const reserve = await pool.getReserveData(tokenA.target);
    expect(reserve.liquidityIndex).eq(RAY);
  });

  it('after supplying, liquidity index should not change', async () => {
    await pool.supplySimple(tokenA.target, eth('1'), 0);
    const reserve = await pool.getReserveData(tokenA.target);
    expect(reserve.liquidityIndex).eq(RAY);
  });

  it('after supplying, and waiting for some time liquidity index should not change', async () => {
    await pool.supplySimple(tokenA.target, eth('1'), 0);
    await time.increase(86400); // one day
    const reserve = await pool.getReserveData(tokenA.target);
    expect(reserve.liquidityIndex).eq(RAY);
  });

  it('after supplying, and waiting for some time; balances should not change', async () => {
    const balBefore = await pool.getBalance(tokenA.target, deployer.address, 0);

    await pool.supplySimple(tokenA.target, 2, 0);

    const balAfter = await pool.getBalance(tokenA.target, deployer.address, 0);
    await time.increase(86400); // one day
    const balAfterDay = await pool.getBalance(tokenA.target, deployer.address, 0);

    // Supply again
    await pool.supplySimple(tokenA.target, 2, 0);
    const finalBalance = await pool.getBalance(tokenA.target, deployer.address, 0);

    expect(balBefore).eq(0);
    expect(balAfter).eq(2);
    expect(balAfter).eq(balAfterDay);
    expect(finalBalance).eq(4);
  });

  it.only('borrowing should increase variable rate index', async () => {
    await pool.supplySimple(tokenA.target, eth('1'), 0);
    await pool.borrowSimple(tokenA.target, eth('0.4'), 0);

    const state = await pool.getReserveData(tokenA.target);

    console.log('currentBorrowRate', state.currentBorrowRate);
    console.log('borrowIndex', state.borrowIndex);
    console.log('currentLiquidityRate', state.currentLiquidityRate);

    expect(state.currentBorrowRate).approximately('62222222222222222222222222', '10000000');
  });

  // it('after supplying and some borrowing, liquidity index should increase after some time', async () => {
  //   await pool.supplySimple(tokenA.target, eth('1'), 0);
  //   await pool.borrowSimple(tokenA.target, eth('0.4'), 0);

  //   const reserveBefore = await pool.getReserveData(tokenA.target);
  //   await time.increase(86400 * 2000); // 2000 days

  //   await pool.repaySimple(tokenA.target, eth('0.01'), 0);
  //   const reserveAfter = await pool.getReserveData(tokenA.target);

  //   expect(reserveBefore.liquidityIndex).eq(RAY);
  //   expect(reserveAfter.liquidityIndex).gt(RAY);
  // });
});
