import { parseEther } from 'ethers';
import { MintableERC20 } from '../../types';
import { Pool } from '../../types/contracts/core/protocol/pool';
import { deployPool } from './fixtures/pool';
import { expect } from 'chai';

describe('Pool', () => {
  let pool: Pool;
  let tokenA: MintableERC20;

  beforeEach(async () => {
    const fixture = await deployPool();
    ({ tokenA, pool } = fixture);
  });

  describe('Supply functions', () => {
    beforeEach(async () => {
      await tokenA.mint(parseEther('10'));
      await tokenA.approve(pool.target, parseEther('1'));
    });

    it('Try to supply into a pool', async () => {
      await pool['supply(address,uint256,uint256)'](tokenA.target, parseEther('1'), 0);
    });

    it('Try to withdraw after a supply into a pool', async () => {
      await pool['supply(address,uint256,uint256)'](tokenA.target, parseEther('1'), 0);
      await pool['withdraw(address,uint256,uint256)'](tokenA.target, parseEther('1'), 0);
    });

    it('Should revert if withdraw after another index', async () => {
      await pool['supply(address,uint256,uint256)'](tokenA.target, parseEther('1'), 0);
      const t = pool['withdraw(address,uint256,uint256)'](tokenA.target, parseEther('1'), 1);
      await expect(t).to.revertedWith('Insufficient Balance!');
    });
  });
});
