import { parseEther } from 'ethers';
import { MintableERC20 } from '../../types';
import { Pool } from '../../types/contracts/core/protocol/pool';
import { deployPool } from './fixtures/pool';
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

  describe('Supply functions', () => {
    beforeEach(async () => {
      await tokenA['mint(uint256)'](parseEther('10'));
      await tokenA.approve(pool.target, parseEther('3'));
    });

    it('Try to supply into a pool', async () => {
      await pool['supply(address,uint256,uint256)'](tokenA.target, parseEther('1'), 0);
    });

    it('Try to withdraw after a supply into a pool', async () => {
      await pool['supply(address,uint256,uint256)'](tokenA.target, parseEther('1'), 0);
      await pool['withdraw(address,uint256,uint256)'](tokenA.target, parseEther('1'), 0);
    });

    it('Should give right balances for supploed positions', async () => {
      await pool['supply(address,uint256,uint256)'](tokenA.target, parseEther('1'), 0);
      await pool['supply(address,uint256,uint256)'](tokenA.target, parseEther('2'), 1);

      expect(await pool['getBalance(address,address,uint256)'](tokenA, deployer.address, 0)).eq(
        parseEther('1')
      );
      expect(await pool['getBalance(address,address,uint256)'](tokenA, deployer.address, 1)).eq(
        parseEther('2')
      );
    });

    it('Should revert if withdraw after another index', async () => {
      await pool['supply(address,uint256,uint256)'](tokenA.target, parseEther('1'), 0);
      const t = pool['withdraw(address,uint256,uint256)'](tokenA.target, parseEther('1'), 1);
      await expect(t).to.revertedWith('Insufficient Balance!');
    });
  });

  describe.only('Borrow functions', () => {
    beforeEach(async () => {
      await tokenA['mint(uint256)'](parseEther('10'));
      await tokenB['mint(uint256)'](parseEther('10'));

      await tokenA.approve(pool.target, parseEther('10'));
      await tokenB.approve(pool.target, parseEther('10'));

      await pool['supply(address,uint256,uint256)'](tokenA.target, parseEther('5'), 0);
      await pool['supply(address,uint256,uint256)'](tokenB.target, parseEther('5'), 0);
    });

    it('Try to borrow from a pool', async () => {
      await pool['borrow(address,uint256,uint256)'](tokenB.target, parseEther('1'), 0);
    });
  });
});
