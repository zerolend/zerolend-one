import { MaxUint256, ZeroAddress, ZeroHash, parseEther as eth, parseUnits } from 'ethers';
import { MintableERC20, PoolConfigurator } from '../../../types';
import { Pool, PoolFactory } from '../../../types/contracts/core/pool';
import { deployPool } from '../fixtures/pool';
import { expect } from 'chai';
import { SignerWithAddress } from '@nomicfoundation/hardhat-ethers/signers';
import { getPositionId } from '../utils/helpers';
import { DefaultReserveInterestRateStrategy } from '../../../types/contracts/core/protocol/pool';

describe.only('PoolConfigurator', () => {
  let pool: Pool;
  let configurator: PoolConfigurator;

  let tokenA: MintableERC20;
  let tokenB: MintableERC20;

  beforeEach(async () => {
    const fixture = await deployPool();
    ({ configurator, pool, tokenA, tokenB } = fixture);
  });

  it('should allow the pool admin to set reserve borrowing', async function () {
    await configurator.setReserveBorrowing(pool.target, tokenA.target, true);
    const config = await pool.getConfiguration(tokenA.target);
    expect(config[0]).to.equal(BigInt(293342023413407052));
  });

  it('should allow the risk or pool admin to set reserve freeze', async function () {
    await configurator.setReserveFreeze(pool.target, tokenA, true);
    let config = await pool.getConfiguration(tokenA);
    expect(config.frozen).to.equal(true);

    await configurator.connect(admin).setReserveFreeze(pool.target, asset, false);
    config = await pool.getConfiguration(asset);
    expect(config.frozen).to.equal(false);
  });

  it('should allow the emergency admin to set pool freeze', async function () {
    const reserves = [ethers.Wallet.createRandom().address, ethers.Wallet.createRandom().address];
    await pool.setReservesList(reserves);

    await configurator.connect(emergencyAdmin).setPoolFreeze(pool.address, true);
    for (let reserve of reserves) {
      const config = await pool.getConfiguration(reserve);
      expect(config.frozen).to.equal(true);
    }
  });

  it('should allow the risk or pool admin to set borrow cap', async function () {
    const newBorrowCap = 1000;
    await configurator.connect(riskAdmin).setBorrowCap(pool.target, asset, newBorrowCap);
    const config = await pool.getConfiguration(asset);
    expect(config.borrowCap).to.equal(newBorrowCap);
  });

  it('should allow the risk or pool admin to set supply cap', async function () {
    const newSupplyCap = 2000;
    await configurator.connect(admin).setSupplyCap(pool.target, asset, newSupplyCap);
    const config = await pool.getConfiguration(asset);
    expect(config.supplyCap).to.equal(newSupplyCap);
  });

  it('should allow the pool admin to set reserve interest rate strategy address', async function () {
    const newRateStrategyAddress = ethers.Wallet.createRandom().address;
    await configurator
      .connect(admin)
      .setReserveInterestRateStrategyAddress(pool.target, asset, newRateStrategyAddress);
    const reserveData = await pool.getReserveData(asset);
    expect(reserveData.interestRateStrategyAddress).to.equal(newRateStrategyAddress);
  });
});
