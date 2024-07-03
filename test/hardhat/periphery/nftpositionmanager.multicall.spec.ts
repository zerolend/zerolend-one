import { ethers } from 'hardhat';
import { deployPool } from '../fixtures/pool';
import { expect } from 'chai';
import { MaxUint256, Signer, parseEther as e18 } from 'ethers';
import { MintableERC20, NFTPositionManager, Pool } from '../../../types';
import { deployNftPositionManager } from '../fixtures/periphery';

describe.only('NFT position manager - multicall', () => {
  let manager: NFTPositionManager;
  let poolFactory;
  let pool: Pool;
  let tokenA: MintableERC20;
  let tokenB: MintableERC20;
  let governance: Signer, alice: Signer, bob: Signer;

  beforeEach(async () => {
    [alice, bob] = await ethers.getSigners();
    ({ poolFactory, pool, tokenA, tokenB, governance } = await deployPool());
    manager = await deployNftPositionManager(poolFactory, await governance.getAddress());

    await tokenA.connect(alice)['mint(uint256)'](e18('100'));
    await tokenA.connect(alice).approve(manager.target, MaxUint256);

    await tokenB.connect(alice)['mint(uint256)'](e18('100'));
    await tokenB.connect(alice).approve(manager.target, MaxUint256);
  });

  it('should be able to mint and supply using multicall', async () => {
    let supplyAmount = e18('50');
    let incLiquidityAmount = e18('20');

    const mintSupplyCall = await manager.connect(alice).interface.encodeFunctionData('mint', [
      {
        asset: tokenA.target,
        pool: pool.target,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      },
    ]);

    const liqiuidityIncreaseCall = manager.interface.encodeFunctionData('increaseLiquidity', [
      {
        asset: tokenB.target,
        pool: pool.target,
        amount: incLiquidityAmount,
        tokenId: 0,
        data: { interestRateData: '0x', hookData: '0x' },
      },
    ]);

    await manager.connect(alice).multicall([mintSupplyCall, liqiuidityIncreaseCall]);

    const balance = await manager.getPosition(1);

    // token A
    expect(balance.assets[0].balance).eq(supplyAmount);
    expect(await tokenA.balanceOf(pool.target)).eq(supplyAmount);

    // token B
    expect(balance.assets[1].balance).eq(incLiquidityAmount);
    expect(await tokenB.balanceOf(pool.target)).eq(incLiquidityAmount);
  });

  it.skip('should be able to repay and withdraw using multicall', async () => {
    let mintAmount = e18('100');
    let supplyAmount = e18('50');
    let increaseLiquidityAmount = e18('20');
    let borrowAmount = e18('20');
    let repayAmount = e18('20');
    let withdrawAmount = e18('70');
    let multiCallData;

    const mintParams = {
      asset: tokenA.target,
      pool: pool.target,
      amount: supplyAmount,
      data: { interestRateData: '0x', hookData: '0x' },
    };

    await tokenA.connect(alice)['mint(uint256)'](mintAmount);
    await tokenA.connect(alice).approve(manager.target, supplyAmount);
    const mintSupplyCall = await manager
      .connect(alice)
      .interface.encodeFunctionData('mint', [mintParams]);

    // multiCallData = [mintSupplyCall];
    // await manager.connect(alice).multicall(multiCallData);

    let supplyBalanceAlice = await manager.getPosition(1);
    expect(supplyBalanceAlice[0][0][1]).eq(supplyAmount);
    // expect(await manager.ownerOf(1)).eq(await alice.getAddress());

    const liquidityParams = {
      asset: tokenA.target,
      pool: pool.target,
      amount: increaseLiquidityAmount,
      tokenId: 1,
      data: { interestRateData: '0x', hookData: '0x' },
    };

    await tokenA.connect(alice).approve(manager.target, increaseLiquidityAmount);

    const liqiuidityIncreaseCall = manager.interface.encodeFunctionData('increaseLiquidity', [
      liquidityParams,
    ]);

    multiCallData = [mintSupplyCall, liqiuidityIncreaseCall];
    await manager.connect(alice).multicall(multiCallData);

    supplyBalanceAlice = await manager.getPosition(1);
    expect(supplyBalanceAlice[0][0][1]).eq(supplyAmount + increaseLiquidityAmount);
    expect(await tokenA.balanceOf(pool.target)).eq(supplyAmount + increaseLiquidityAmount);

    const borrowParams = {
      asset: await tokenA.getAddress(),
      amount: borrowAmount,
      tokenId: 1,
      data: { interestRateData: '0x', hookData: '0x' },
    };

    const borrowCall = manager.interface.encodeFunctionData('borrow', [borrowParams]);

    multiCallData = [borrowCall];
    await manager.connect(alice).multicall(multiCallData);

    let borrowBalanceAlice = await manager.getPosition(1);
    expect(borrowBalanceAlice[0][0][2]).eq(borrowAmount);
    expect(await tokenA.balanceOf(pool.target)).eq(
      supplyAmount + increaseLiquidityAmount - borrowAmount
    );

    let repayParams = {
      asset: await tokenA.getAddress(),
      amount: repayAmount,
      tokenId: 1,
      data: { interestRateData: '0x', hookData: '0x' },
    };

    await tokenA.connect(alice).approve(manager.target, repayAmount);

    let repayCall = manager.interface.encodeFunctionData('repay', [repayParams]);
    multiCallData = [repayCall];
    await manager.connect(alice).multicall(multiCallData);

    borrowBalanceAlice = await manager.getPosition(1);
    expect(borrowBalanceAlice[0][0][2]).eq(0);

    let withdrawParams = {
      asset: await tokenA.getAddress(),
      amount: withdrawAmount,
      tokenId: 1,
      data: { interestRateData: '0x', hookData: '0x' },
    };

    const withdrawCall = manager.interface.encodeFunctionData('withdraw', [withdrawParams]);
    multiCallData = [withdrawCall];
    await manager.connect(alice).multicall(multiCallData);

    supplyBalanceAlice = await manager.getPosition(1);
    expect(supplyBalanceAlice[0][0][1]).eq(0);
    expect(await tokenA.balanceOf(await alice.getAddress())).eq(mintAmount);

    const burnCall = manager.interface.encodeFunctionData('burn', ['1']);
    multiCallData = [burnCall];

    await manager.connect(alice).multicall(multiCallData);

    expect(await manager.balanceOf(await alice.getAddress())).eq(0);
  });
});
