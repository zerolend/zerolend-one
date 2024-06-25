import { ethers, upgrades } from 'hardhat';
import { deployPool } from './fixtures/pool';
import { expect } from 'chai';
import { Contract, Signer, ZeroAddress } from 'ethers';
import { INFTPositionManager, MintableERC20, NFTPositionManager, Pool } from '../../types';

describe('NFT Position Manager', () => {
  let positionManager: Contract, factory, pool: Pool, tokenA: MintableERC20;
  let alice: Signer, bob: Signer;

  beforeEach(async () => {
    [alice, bob] = await ethers.getSigners();
    ({ factory, pool, tokenA } = await deployPool());
    // console.log(`Factory Proxy ${await factory.getAddress()}`);
    const NFTPositionManager = await ethers.getContractFactory('NFTPositionManager');
    positionManager = await upgrades.deployProxy(NFTPositionManager, [await factory.getAddress()], {
      initializer: 'initialize',
      kind: 'transparent',
    });
    await positionManager.waitForDeployment();
    // console.log(`NFT Position Manager Proxy Deployed to ${await positionManager.getAddress()}`);
  });

  describe('ERC721-Enumerable', () => {
    it('name of the nft should be correct', async () => {
      expect(await positionManager.name()).to.be.equals('ZeroLend Position V2');
    });
    it('symbol of the nft should be correct', async () => {
      expect(await positionManager.symbol()).to.be.equals('ZL-POS-V2');
    });
  });

  describe('Mint', () => {
    it('should revert if the pool are not deployed through factory', async () => {
      let mintParams = {
        asset: await tokenA.getAddress(),
        pool: ZeroAddress,
        amount: 10,
      };
      await expect(positionManager.mint(mintParams)).to.be.revertedWithCustomError(
        positionManager,
        'NotPool'
      );
    });
    it('Should revert if user pass invalid asset address', async () => {
      let mintParams = {
        asset: ZeroAddress,
        pool: pool,
        amount: 0,
      };
      await expect(positionManager.mint(mintParams)).to.be.revertedWithCustomError(
        positionManager,
        'ZeroAddressNotAllowed'
      );
    });
    it('Should revert if user pass invalid amount', async () => {
      let mintParams = {
        asset: tokenA,
        pool,
        amount: 0,
      };
      await expect(positionManager.mint(mintParams)).to.be.revertedWithCustomError(
        positionManager,
        'ZeroValueNotAllowed'
      );
    });

    it('Should emit the event IncreasedLiquidity on Mint', async () => {
      // mint asset tokens to alice
      let mintAmount = ethers.parseUnits('100', 'wei');
      let supplyAmount = ethers.parseUnits('10', 'wei');

      await tokenA.connect(alice)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await alice.getAddress())).to.be.equals(mintAmount);
      let mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
      };
      // Approve the NFT Position Manager
      await tokenA.approve(positionManager.target, mintAmount);

      await expect(positionManager.mint(mintParams))
        .to.emit(positionManager, 'LiquidityIncreased')
        .withArgs(tokenA.target, 1, supplyAmount);
    });

    it('_handleLiquidity should transfer asset from user to NFT-Position-Manager', async () => {
      // mint asset tokens to alice
      let mintAmount = ethers.parseUnits('100', 'wei');
      let supplyAmount = ethers.parseUnits('10', 'wei');

      await tokenA.connect(alice)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await alice.getAddress())).to.be.equals(mintAmount);
      let mintParams = {
        asset: tokenA,
        pool,
        amount: ethers.parseUnits('10', 'wei'),
      };
      // Approve the NFT Position Manager
      await tokenA.approve(positionManager.target, mintAmount);
      // mint a postion for tokenId 1 by alice
      await positionManager.mint(mintParams);
      // Store the positions
      const position = await positionManager.positions(1);
      expect(position[0]).to.be.equals(await pool.getAddress());
      expect(position[1]).to.be.equals(ZeroAddress);
      // Pool transfer now assets from NFT Position Manager
      expect(await tokenA.balanceOf(await pool.target)).to.be.equals(supplyAmount);

      //Alice should be the owner of the nft
      expect(await positionManager.ownerOf(1)).to.be.equals(await alice.getAddress());
    });
  });

  describe('IncreaseLiquidity', () => {
    it('Should revert if user pass invalid asset address', async () => {
      let liquidityParams = {
        asset: ZeroAddress,
        pool: pool,
        amount: 0,
      };
      await expect(positionManager.mint(liquidityParams)).to.be.revertedWithCustomError(
        positionManager,
        'ZeroAddressNotAllowed'
      );
    });
    it('Should revert if user pass invalid amount', async () => {
      let liquidityParams = {
        asset: tokenA,
        pool,
        amount: 0,
      };
      await expect(positionManager.mint(liquidityParams)).to.be.revertedWithCustomError(
        positionManager,
        'ZeroValueNotAllowed'
      );
    });
    it('Should revert if the caller is not owner or approved for tokenId', async () => {
      
    });
  });
});
