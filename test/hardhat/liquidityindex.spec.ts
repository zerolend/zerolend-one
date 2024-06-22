import { parseEther } from 'ethers';
import { MintableERC20 } from '../../types';
import { Pool } from '../../types/contracts/core/protocol/pool';
import { deployPool } from './fixtures/pool';
import { expect } from 'chai';
import { time } from '@nomicfoundation/hardhat-network-helpers';

import { SignerWithAddress } from '@nomicfoundation/hardhat-ethers/signers';

const ray = parseEther('1000000000');

describe('Pool - Liquidity Index', () => {
  let pool: Pool;
  let tokenA: MintableERC20;
  let deployer: SignerWithAddress;

  beforeEach(async () => {
    const fixture = await deployPool();
    ({ tokenA, pool, owner: deployer } = fixture);

    // mint some tokens and give approval
    await tokenA['mint(uint256)'](parseEther('10'));
    await tokenA.approve(pool.target, parseEther('3'));
  });

  it('Liquidity index for a new reserve should be set to 1 ray', async () => {
    const reserve = await pool.getReserveData(tokenA.target);
    expect(reserve.liquidityIndex).eq(ray);
  });

  it('After supplying, liquidity index should not change', async () => {
    pool['supply(address,uint256,uint256)'](tokenA.target, parseEther('1'), 0);
    const reserve = await pool.getReserveData(tokenA.target);
    expect(reserve.liquidityIndex).eq(ray);
  });

  it('After supplying, and waiting for some time liquidity index should not change', async () => {
    pool['supply(address,uint256,uint256)'](tokenA.target, parseEther('1'), 0);

    // wait for a day
    await time.increase(86400);

    const reserve = await pool.getReserveData(tokenA.target);
    expect(reserve.liquidityIndex).eq(ray);
  });

  it('After supplying, and waiting for some time; balances should not change', async () => {
    const balBefore = await pool['getBalance(address,address,uint256)'](
      tokenA.target,
      deployer.address,
      0
    );

    await pool['supply(address,uint256,uint256)'](tokenA.target, parseEther('1'), 0);

    const balAfter = await pool['getBalance(address,address,uint256)'](
      tokenA.target,
      deployer.address,
      0
    );

    // wait for a day
    await time.increase(86400);

    const balAfterDay = await pool['getBalance(address,address,uint256)'](
      tokenA.target,
      deployer.address,
      0
    );

    // Supply again
    await pool['supply(address,uint256,uint256)'](tokenA.target, parseEther('1'), 0);

    const finalBalance = await pool['getBalance(address,address,uint256)'](
      tokenA.target,
      deployer.address,
      0
    );

    expect(balBefore).eq(0);
    expect(balAfter).eq(parseEther('1'));
    expect(balAfter).eq(balAfterDay);
    expect(finalBalance).eq(parseEther('2'));
  });
});
