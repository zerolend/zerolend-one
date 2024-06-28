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

    it('Should give right balances for supplied positions', async () => {
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

  describe.only("Borrow functions", () => {
    beforeEach(async () => {
      await tokenA['mint(uint256)'](parseEther('10'));
      await tokenA.approve(pool.target, parseEther('3'));
      console.log("!!!!!!!!!!!!!!");
      
      await pool['supply(address,uint256,uint256)'](tokenA.target, parseEther('1'), 0);
      console.log("!!!!!!!!!!!!!!");
      await pool['supply(address,uint256,uint256)'](tokenA.target, parseEther('1'), 0);

      console.log(await pool.getUserAccountData(deployer.address, 0));
      
    });

    it("Should borrow from the pool", async () => {
      // const balanceBefore = await tokenB.balanceOf(deployer.address);
      // console.log("# ~ file: pool.spec.ts:63 ~ it ~ balanceBefore:", balanceBefore);
      
      // // await pool['borrow(address,uint256,uint256)'](tokenB.target, parseEther('1'), 0);
      
      // const balanceAfter = await tokenB.balanceOf(deployer.address);
      // console.log("# ~ file: pool.spec.ts:68 ~ it ~ balanceAfter:", balanceAfter);
    });
  });
});
