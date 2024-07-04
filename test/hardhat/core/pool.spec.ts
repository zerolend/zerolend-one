import { MaxUint256, ZeroAddress, ZeroHash, parseEther as eth, parseUnits } from 'ethers';
import { MintableERC20, PoolConfigurator } from '../../../types';
import { Pool, PoolFactory } from '../../../types/contracts/core/pool';
import { deployPool } from '../fixtures/pool';
import { expect } from 'chai';
import { SignerWithAddress } from '@nomicfoundation/hardhat-ethers/signers';
import { getPositionId } from '../utils/helpers';
import { DefaultReserveInterestRateStrategy } from '../../../types/contracts/core/protocol/pool';

describe('Pool', () => {
  let pool: Pool;
  let poolFactory: PoolFactory;
  let configurator: PoolConfigurator;
  let irStrategy: DefaultReserveInterestRateStrategy;

  let tokenA: MintableERC20;
  let tokenB: MintableERC20;

  let deployer: SignerWithAddress;

  beforeEach(async () => {
    const fixture = await deployPool();
    ({ tokenA, tokenB, pool, owner: deployer, poolFactory, configurator, irStrategy } = fixture);
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

    it('should give right balances for supplied positions', async () => {
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

  describe('Pool Getters', () => {
    describe('getReserveData', function () {
      it('should return reserve data for a given asset', async function () {
        const reserveData = await pool.getReserveData(tokenA.target);
        expect(reserveData).to.exist;
      });
    });

    describe('getBalanceByPosition', function () {
      it('should return balance for a given position', async function () {
        const balance = await pool.getBalanceByPosition(
          tokenA.target,
          getPositionId(deployer.address, 0)
        );
        expect(balance).to.equal(0);
      });
    });

    describe('getHook', function () {
      it('should return the hook address', async function () {
        const hook = await pool.getHook();
        expect(hook).to.equal(ZeroAddress);
      });
    });

    describe('getBalance', function () {
      it('should return balance for a given user and index', async function () {
        const balance = await pool.getBalance(tokenA, deployer.address, 0);
        expect(balance).to.equal(0);
      });
    });

    describe('getBalanceRawByPositionId', function () {
      it('should return raw balance for a given position ID', async function () {
        const balance = await pool.getBalanceRawByPositionId(tokenA.target, ZeroHash);
        expect(balance.supplyShares).to.equal(0);
        expect(balance.debtShares).to.equal(0);
      });
    });

    describe('getBalanceRaw', function () {
      it('should return raw balance for a given user and index', async function () {
        const balance = await pool.getBalanceRaw(tokenA.target, deployer.address, 0);
        expect(balance.supplyShares).to.equal(0);
        expect(balance.debtShares).to.equal(0);
      });
    });

    describe('getTotalSupplyRaw', function () {
      it('should return total raw supply for a given asset', async function () {
        const totalSupply = await pool.getTotalSupplyRaw(tokenA.target);
        expect(totalSupply.supplyShares).to.equal(0);
        expect(totalSupply.debtShares).to.equal(0);
      });
    });

    describe('totalAssets', function () {
      it('should return total assets for a given asset', async function () {
        const totalAssets = await pool.totalAssets(tokenA.target);
        expect(totalAssets).to.equal(0);
      });
    });

    describe('totalDebt', function () {
      it('should return total debt for a given asset', async function () {
        const totalDebt = await pool.totalDebt(tokenA.target);
        expect(totalDebt).to.equal(0);
      });
    });

    describe('getDebtByPosition', function () {
      it('should return debt for a given position', async function () {
        const debt = await pool.getDebtByPosition(tokenA.target, ZeroHash);
        expect(debt).to.equal(0);
      });
    });

    describe('getDebt', function () {
      it('should return debt for a given user and index', async function () {
        const debt = await pool.getDebt(tokenA.target, deployer.address, 0);
        expect(debt).to.equal(0);
      });
    });

    describe('getUserAccountData', function () {
      it('should return user account data', async function () {
        const userData = await pool.getUserAccountData(deployer.address, 0);
        expect(userData).to.exist;
      });
    });

    describe('getConfiguration', function () {
      it('should return configuration for a given asset', async function () {
        const config = await pool.getConfiguration(tokenA.target);
        expect(config).to.exist;
      });
    });

    describe('getUserConfiguration', function () {
      it('should return user configuration', async function () {
        const userConfig = await pool.getUserConfiguration(deployer.address, 0);
        expect(userConfig).to.exist;
      });
    });

    describe('getReserveNormalizedIncome', function () {
      it('should return normalized income for a given reserve', async function () {
        const income = await pool.getReserveNormalizedIncome(tokenA.target);
        expect(income).to.equal(eth('1000000000'));
      });
    });

    describe('getReserveNormalizedVariableDebt', function () {
      it('should return normalized variable debt for a given reserve', async function () {
        const debt = await pool.getReserveNormalizedVariableDebt(tokenA.target);
        expect(debt).to.equal(eth('1000000000'));
      });
    });

    describe('getReservesList', function () {
      it('should return list of reserves', async function () {
        const reservesList = await pool.getReservesList();
        expect(reservesList.length).to.equal(3);
      });
    });

    describe('getReservesCount', function () {
      it('should return count of reserves', async function () {
        const reservesCount = await pool.getReservesCount();
        expect(reservesCount).to.equal(3);
      });
    });

    describe('getConfigurator', function () {
      it('should return configurator address', async function () {
        const poolConfigurator = await pool.getConfigurator();
        expect(poolConfigurator).to.equal(configurator);
      });
    });

    describe('getReserveAddressById', function () {
      it('should return reserve address by ID', async function () {
        const reserveAddress = await pool.getReserveAddressById(0);
        expect(reserveAddress).to.equal(tokenA.target);
      });
    });

    describe('getAssetPrice', function () {
      it('should return asset price from the oracle', async function () {
        const price = await pool.getAssetPrice(tokenA.target);
        expect(price).to.equal(1e8);
      });
    });

    describe('factory', function () {
      it('should return the factory address', async function () {
        const factory = await pool.factory();
        expect(factory).to.equal(poolFactory.target);
      });
    });

    describe('getReserveFactor', function () {
      it('should return the reserve factor', async function () {
        const reserveFactor = await pool.getReserveFactor();
        expect(reserveFactor).to.equal(0);
      });
    });
  });

  describe("DefaultReserveInterestRateStrategy", function () {
    const BASE_VARIABLE_BORROW_RATE = BigInt(0);
    const VARIABLE_RATE_SLOPE_1 = parseUnits("0.07", 27);
    const VARIABLE_RATE_SLOPE_2 = parseUnits("0.3", 27);
    it("should return the correct optimal usage ratio", async function () {
      expect(await irStrategy.OPTIMAL_USAGE_RATIO()).to.equal(parseUnits('0.45', 27));
    });
  
    it("should return the correct max excess usage ratio", async function () {
      const MAX_EXCESS_USAGE_RATIO = parseUnits("0.55", 27);
      expect(await irStrategy.MAX_EXCESS_USAGE_RATIO()).to.equal(MAX_EXCESS_USAGE_RATIO);
    });
  
    it("should return the correct base variable borrow rate", async function () {
      expect(await irStrategy.getBaseVariableBorrowRate()).to.equal(BASE_VARIABLE_BORROW_RATE);
    });
  
    it("should return the correct variable rate slope 1", async function () {
      expect(await irStrategy.getVariableRateSlope1()).to.equal(VARIABLE_RATE_SLOPE_1);
    });
  
    it("should return the correct variable rate slope 2", async function () {
      expect(await irStrategy.getVariableRateSlope2()).to.equal(VARIABLE_RATE_SLOPE_2);
    });
  
    it("should return the correct max variable borrow rate", async function () {
      const MAX_VARIABLE_BORROW_RATE = BASE_VARIABLE_BORROW_RATE + VARIABLE_RATE_SLOPE_1 + VARIABLE_RATE_SLOPE_2;
      expect(await irStrategy.getMaxVariableBorrowRate()).to.equal(MAX_VARIABLE_BORROW_RATE);
    });
  });
});
