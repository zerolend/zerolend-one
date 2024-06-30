import { MaxUint256, parseEther as eth } from 'ethers';
import { MintableERC20 } from '../../../types';
import { Pool } from '../../../types/contracts/core/pool';
import { deployPool } from '../fixtures/pool';
import { expect } from 'chai';
import { SignerWithAddress } from '@nomicfoundation/hardhat-ethers/signers';

describe('Pool', () => {
  let pool: Pool;
  let tokenA: MintableERC20;
  let tokenB: MintableERC20;
  let deployer: SignerWithAddress;

  beforeEach(async () => {
    const fixture = await deployPool();
    ({ tokenA, tokenB, pool, owner: deployer } = fixture);
  });

  describe('Supply / Withdraw functions', () => {
    beforeEach(async () => {
      await tokenA['mint(uint256)'](eth('10'));
      await tokenA.approve(pool.target, eth('3'));
    });

    it('try to supply into a pool', async () => {
      await pool.supplySimple(tokenA.target, eth('1'), 0);
    });

    it('try to withdraw after a supply into a pool', async () => {
      await pool.supplySimple(tokenA.target, eth('1'), 0);
      await pool.withdrawSimple(tokenA.target, eth('1'), 0);
    });

    it('should give right balances for supploed positions', async () => {
      await pool.supplySimple(tokenA.target, eth('1'), 0);
      await pool.supplySimple(tokenA.target, eth('2'), 1);

      expect(await pool.getBalance(tokenA, deployer.address, 0)).eq(eth('1'));
      expect(await pool.getBalance(tokenA, deployer.address, 1)).eq(eth('2'));
    });

    it('should revert if withdraw after another index', async () => {
      await pool.supplySimple(tokenA.target, eth('1'), 0);
      const t = pool.withdrawSimple(tokenA.target, eth('1'), 1);
      await expect(t).to.revertedWith('Insufficient Balance!');
    });

    it('should revert if withdraw more than supplied', async () => {
      await pool.supplySimple(tokenA.target, eth('1'), 0);
      const t = pool.withdrawSimple(tokenA.target, eth('10'), 0);
      await expect(t).to.revertedWith('Insufficient Balance!');
    });
  });

  describe('Borrow / Repay functions', () => {
    beforeEach(async () => {
      await tokenA['mint(uint256)'](eth('10'));
      await tokenB['mint(uint256)'](eth('10'));

      await tokenA.approve(pool.target, eth('10'));
      await tokenB.approve(pool.target, eth('10'));

      await pool.supplySimple(tokenA.target, eth('5'), 0);
      await pool.supplySimple(tokenB.target, eth('5'), 0);
    });

    it('try to borrow from a pool', async () => {
      expect(await tokenB.balanceOf(deployer.address)).eq(eth('5'));
      await pool.borrowSimple(tokenB.target, eth('1'), 0);
      expect(await tokenB.balanceOf(deployer.address)).eq(eth('6'));
    });

    it('try to max repay whatever was borrowed', async () => {
      expect(await tokenB.balanceOf(deployer.address)).eq(eth('5'));
      await pool.borrowSimple(tokenB.target, eth('1'), 0);
      expect(await tokenB.balanceOf(deployer.address)).eq(eth('6'));
      await pool.repaySimple(tokenB.target, MaxUint256.toString(), 0);
      expect(await tokenB.balanceOf(deployer.address)).closeTo(eth('5'), eth('0.01'));
    });

    it('try to partial repay whatever was borrowed', async () => {
      expect(await tokenB.balanceOf(deployer.address)).eq(eth('5'));
      await pool.borrowSimple(tokenB.target, eth('1'), 0);
      expect(await tokenB.balanceOf(deployer.address)).eq(eth('6'));
      await pool.repaySimple(tokenB.target, eth('0.1'), 0);
      expect(await tokenB.balanceOf(deployer.address)).closeTo(eth('5.9'), eth('0.01'));
    });
  });
});
