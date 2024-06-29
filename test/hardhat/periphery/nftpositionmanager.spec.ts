import { ethers, upgrades } from 'hardhat';
import { deployPool } from '../fixtures/pool';
import { expect } from 'chai';
import { Signer, ZeroAddress } from 'ethers';
import { MintableERC20, NFTPositionManager, Pool } from '../../../types';
import { deployNftPositionManager } from '../fixtures/periphery';

describe('NFT Position Manager', () => {
  let manager: NFTPositionManager;
  let poolFactory;
  let pool: Pool;
  let tokenA: MintableERC20;
  let governance: Signer, alice: Signer, bob: Signer;

  beforeEach(async () => {
    [alice, bob] = await ethers.getSigners();
    ({ poolFactory, pool, tokenA, governance } = await deployPool());
    manager = await deployNftPositionManager(poolFactory, await governance.getAddress());
  });

  describe('ERC721-Enumerable', () => {
    it('name of the nft should be correct', async () => {
      expect(await manager.name()).to.be.equals('ZeroLend Position V2');
    });
    it('symbol of the nft should be correct', async () => {
      expect(await manager.symbol()).to.be.equals('ZL-POS-V2');
    });
  });

  describe('Mint', () => {
    it('should revert if the pool are not deployed through factory', async () => {
      const mintParams = {
        asset: await tokenA.getAddress(),
        pool: ZeroAddress,
        amount: 10,
        data: { interestRateData: '', hookData: '' },
      };
      await expect(manager.mint(mintParams)).to.be.revertedWithCustomError(manager, 'NotPool');
    });
    it('should revert if user pass invalid asset address', async () => {
      const mintParams = {
        asset: ZeroAddress,
        pool,
        amount: 0,
        data: { interestRateData: '', hookData: '' },
      };
      await expect(manager.mint(mintParams)).to.be.revertedWithCustomError(
        manager,
        'ZeroAddressNotAllowed'
      );
    });
    it('should revert if user pass invalid amount', async () => {
      let mintParams = {
        asset: tokenA,
        pool,
        amount: 0,
        data: { interestRateData: '', hookData: '' },
      };
      await expect(manager.mint(mintParams)).to.be.revertedWithCustomError(
        manager,
        'ZeroValueNotAllowed'
      );
    });

    it('should emit the event IncreasedLiquidity on Mint', async () => {
      // mint asset tokens to alice
      const mintAmount = ethers.parseUnits('100', 'wei');
      const supplyAmount = ethers.parseUnits('10', 'wei');

      await tokenA.connect(alice)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await alice.getAddress())).to.be.equals(mintAmount);
      const mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        data: { interestRateData: '', hookData: '' },
      };

      // Approve the NFT Position Manager
      await tokenA.approve(manager.target, mintAmount);

      await expect(manager.mint(mintParams))
        .to.emit(manager, 'LiquidityIncreased')
        .withArgs(tokenA.target, 1, supplyAmount);
    });

    it('_handleLiquidity should transfer asset from user to NFT-Position-Manager & mint NFT', async () => {
      // mint asset tokens to alice
      const mintAmount = ethers.parseUnits('100', 'wei');
      const supplyAmount = ethers.parseUnits('10', 'wei');

      await tokenA.connect(alice)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await alice.getAddress())).to.be.equals(mintAmount);
      const mintParams = {
        asset: tokenA,
        pool,
        amount: ethers.parseUnits('10', 'wei'),
        data: { interestRateData: '', hookData: '' },
      };

      // Approve the NFT Position Manager
      await tokenA.approve(manager.target, mintAmount);

      // mint a postion for tokenId 1 by alice
      await manager.mint(mintParams);

      // Store the positions
      const position = await manager.positions(1);
      expect(position[0]).to.be.equals(await pool.getAddress());
      expect(position[1]).to.be.equals(ZeroAddress);

      // Pool transfer now assets from NFT Position Manager
      expect(await tokenA.balanceOf(await pool.target)).to.be.equals(supplyAmount);

      // Alice should be the owner of the nft
      expect(await manager.ownerOf(1)).to.be.equals(await alice.getAddress());
    });
  });

  describe('IncreaseLiquidity', () => {
    it('should revert if user pass invalid asset address', async () => {
      const liquidityParams = {
        asset: ZeroAddress,
        pool,
        amount: 0,
        data: { interestRateData: '', hookData: '' },
      };
      await expect(manager.mint(liquidityParams)).to.be.revertedWithCustomError(
        manager,
        'ZeroAddressNotAllowed'
      );
    });
    it('should revert if user pass invalid amount', async () => {
      const liquidityParams = {
        asset: tokenA,
        pool,
        amount: 0,
        data: { interestRateData: '', hookData: '' },
      };
      await expect(manager.mint(liquidityParams)).to.be.revertedWithCustomError(
        manager,
        'ZeroValueNotAllowed'
      );
    });
    it('should revert if the caller is not owner or approved for tokenId', async () => {
      const supplyAmount = ethers.parseUnits('10', 'wei');
      const mintAmount = ethers.parseUnits('100', 'wei');
      await tokenA.connect(alice)['mint(uint256)'](mintAmount);

      const mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        data: { interestRateData: '', hookData: '' },
      };

      await tokenA.connect(alice).approve(manager.target, supplyAmount);
      await manager.connect(alice).mint(mintParams);

      const liquidityParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        tokenId: 1,
        data: { interestRateData: '', hookData: '' },
      };
      await expect(
        manager.connect(bob).increaseLiquidity(liquidityParams)
      ).to.be.revertedWithCustomError(manager, 'NotTokenIdOwner');
    });
    it('_handleLiquidity should transfer asset from user to NFT-Position-Manager', async () => {
      const mintAmount = ethers.parseUnits('100', 'wei');
      const supplyAmount = ethers.parseUnits('10', 'wei');

      await tokenA.connect(bob)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await bob.getAddress())).to.be.equals(mintAmount);
      const mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        data: { interestRateData: '', hookData: '' },
      };

      // Approve the NFT Position Manager
      await tokenA.connect(bob).approve(manager.target, supplyAmount);

      // mint a postion for tokenId 1 by alice
      await manager.connect(bob).mint(mintParams);

      // Store the positions
      const position = await manager.positions(1);
      expect(position[0]).to.be.equals(await pool.getAddress());
      expect(position[1]).to.be.equals(ZeroAddress);
      expect(await tokenA.balanceOf(pool.target)).to.be.equals(supplyAmount);

      // Bob should be the owner of the nft
      expect(await manager.ownerOf(1)).to.be.equals(await bob.getAddress());

      // Now call the increaseLiquidity and supply the asset to the pool
      await tokenA.connect(bob).approve(manager.target, supplyAmount);
      let liquidityParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        tokenId: 1,
        data: { interestRateData: '', hookData: '' },
      };

      await manager.connect(bob).increaseLiquidity(liquidityParams);
      let balanceAfterLiquidity = await tokenA.balanceOf(pool.target);

      expect(await tokenA.balanceOf(pool.target)).to.be.equals(balanceAfterLiquidity);

      // Bob still should be the owner of the nft after increase liquidity
      expect(await manager.ownerOf(1)).to.be.equals(await bob.getAddress());
    });
  });
});
