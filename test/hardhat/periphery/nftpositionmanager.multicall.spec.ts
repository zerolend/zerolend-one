import { deployPool } from '../fixtures/pool';
import { expect } from 'chai';
import { MaxUint256, ZeroAddress, parseEther as e18 } from 'ethers';
import {
  MintableERC20,
  NFTPositionManager,
  Pool,
  PoolConfigurator,
  UIHelper,
} from '../../../types';
import { deployNftPositionManager, deployUIHelper } from '../fixtures/periphery';
import { SignerWithAddress } from '@nomicfoundation/hardhat-ethers/signers';

describe.only('NFT position manager - multicall', () => {
  let manager: NFTPositionManager;
  let poolFactory;
  let pool: Pool;
  let tokenA: MintableERC20;
  let tokenB: MintableERC20;
  let uiHelper: UIHelper;
  let configurator: PoolConfigurator;
  let governance: SignerWithAddress,
    ant: SignerWithAddress,
    whale: SignerWithAddress,
    owner: SignerWithAddress;

  beforeEach(async () => {
    ({ poolFactory, pool, tokenA, tokenB, governance, ant, configurator, whale, owner } =
      await deployPool());
    manager = await deployNftPositionManager(poolFactory, await governance.getAddress());
    uiHelper = await deployUIHelper(poolFactory, configurator, manager);

    await tokenA.connect(ant).approve(manager.target, MaxUint256);
    await tokenA.mint(ant.getAddress(), e18('100'));
    await tokenA.connect(whale).approve(manager.target, MaxUint256);
    await tokenA.mint(whale.getAddress(), e18('100'));
    await tokenB.connect(ant).approve(manager.target, MaxUint256);
    await tokenB.mint(ant.getAddress(), e18('100'));

    // seed some liquidity into the pool
    const mintCall = await manager.interface.encodeFunctionData('mint', [pool.target]);
    const supplyCall = await manager.interface.encodeFunctionData('supply', [
      {
        asset: tokenA.target,
        target: ZeroAddress,
        tokenId: 0,
        amount: e18('100'),
        data: { interestRateData: '0x', hookData: '0x' },
      },
    ]);
    await manager.connect(whale).multicall([mintCall, supplyCall]);
  });

  it.only('should be able to mint and supply using multicall', async () => {
    const supplyAmount = e18('50');
    const incLiquidityAmount = e18('20');

    const mintSupplyCall = await manager.interface.encodeFunctionData('mint', [pool.target]);
    const supplyCallA = await manager.interface.encodeFunctionData('supply', [
      {
        asset: tokenA.target,
        target: ZeroAddress,
        tokenId: 0,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      },
    ]);
    const supplyCallB = await manager.interface.encodeFunctionData('supply', [
      {
        asset: tokenB.target,
        target: ZeroAddress,
        tokenId: 0,
        amount: incLiquidityAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      },
    ]);

    await manager.connect(ant).multicall([mintSupplyCall, supplyCallA, supplyCallB]);

    const balance = await uiHelper.getNftPosition(2);

    console.log(balance);

    // token A
    expect(balance[0].balance).eq(supplyAmount);
    expect(balance[0].debt).eq(0);
    expect(await tokenA.balanceOf(pool.target)).eq(supplyAmount + e18('100'));

    // token B
    expect(balance[1].balance).eq(incLiquidityAmount);
    expect(balance[1].debt).eq(0);
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
