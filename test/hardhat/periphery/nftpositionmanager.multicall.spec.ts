import { deployPool } from '../fixtures/pool';
import { expect } from 'chai';
import { MaxUint256, parseEther as e18 } from 'ethers';
import { MintableERC20, NFTPositionManager, Pool } from '../../../types';
import { deployNftPositionManager } from '../fixtures/periphery';
import { SignerWithAddress } from '@nomicfoundation/hardhat-ethers/signers';

describe('NFT position manager - multicall', () => {
  let manager: NFTPositionManager;
  let poolFactory;
  let pool: Pool;
  let tokenA: MintableERC20;
  let tokenB: MintableERC20;
  let governance: SignerWithAddress,
    ant: SignerWithAddress,
    whale: SignerWithAddress,
    owner: SignerWithAddress;

  beforeEach(async () => {
    ({ poolFactory, pool, tokenA, tokenB, governance, ant, whale, owner } = await deployPool());
    manager = await deployNftPositionManager(poolFactory, await governance.getAddress());

    await tokenA.connect(ant).approve(manager.target, MaxUint256);
    await tokenA.mint(ant.getAddress(), e18('100'));
    await tokenA.connect(whale).approve(manager.target, MaxUint256);
    await tokenA.mint(whale.getAddress(), e18('100'));
    await tokenB.connect(ant).approve(manager.target, MaxUint256);
    await tokenB.mint(ant.getAddress(), e18('100'));

    // seed some liquidity into the pool
    const mintSupplyCall = await manager.interface.encodeFunctionData('mint', [
      {
        asset: tokenA.target,
        pool: pool.target,
        amount: e18('100'),
        data: { interestRateData: '0x', hookData: '0x' },
      },
    ]);
    await manager.connect(whale).multicall([mintSupplyCall]);
  });

  it('should be able to mint and supply using multicall', async () => {
    const supplyAmount = e18('50');
    const incLiquidityAmount = e18('20');

    const mintSupplyCall = await manager.connect(ant).interface.encodeFunctionData('mint', [
      {
        asset: tokenA.target,
        pool: pool.target,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      },
    ]);

    const liqiuidityIncreaseCall = manager.interface.encodeFunctionData('supply', [
      {
        asset: tokenB.target,
        amount: incLiquidityAmount,
        tokenId: 0,
        data: { interestRateData: '0x', hookData: '0x' },
      },
    ]);

    await manager.connect(ant).multicall([mintSupplyCall, liqiuidityIncreaseCall]);

    const balance = await manager.getPosition(2);

    // token A
    expect(balance.assets[0].balance).eq(supplyAmount);
    expect(balance.assets[0].debt).eq(0);
    expect(await tokenA.balanceOf(pool.target)).eq(supplyAmount + e18('100'));

    // token B
    expect(balance.assets[1].balance).eq(incLiquidityAmount);
    expect(balance.assets[1].debt).eq(0);
    expect(await tokenB.balanceOf(pool.target)).eq(incLiquidityAmount);
  });

  it('should be able to supply and borrow using multicall', async () => {
    const supplyAmount = e18('50');
    const borrowAmount = e18('20');

    // prepare multicall for the ant
    const mintSupplyCallBob = await manager.interface.encodeFunctionData('mint', [
      {
        asset: tokenB.target,
        pool: pool.target,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      },
    ]);
    const borrowCall = manager.interface.encodeFunctionData('borrow', [
      {
        asset: tokenA.target,
        amount: borrowAmount,
        tokenId: 2,
        data: { interestRateData: '0x', hookData: '0x' },
      },
    ]);
    await manager.connect(ant).multicall([mintSupplyCallBob, borrowCall]);

    const balance = await manager.getPosition(2);

    // token A - borrowed
    expect(balance.assets[0].debt).eq(borrowAmount);
    expect(balance.assets[0].balance).eq(0);
    expect(await tokenA.balanceOf(await ant.getAddress())).eq(borrowAmount + e18('100'));

    // token B - supplied
    expect(balance.assets[1].balance).eq(supplyAmount);
    expect(balance.assets[1].debt).eq(0);
    expect(await tokenB.balanceOf(pool.target)).eq(supplyAmount);
  });

  it.skip('should be able to repay and withdraw using multicall', async () => {
    // todo
  });
});
