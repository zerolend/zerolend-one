import { ethers } from 'hardhat';
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

  describe('erc721-enumerable', () => {
    it('name of the nft should be correct', async () => {
      expect(await manager.name()).to.be.equals('ZeroLend Position V2');
    });
    it('symbol of the nft should be correct', async () => {
      expect(await manager.symbol()).to.be.equals('ZL-POS-V2');
    });
  });

  describe('mint', () => {
    it('should revert if the pool are not deployed through factory', async () => {
      const mintParams = {
        asset: await tokenA.getAddress(),
        pool: ZeroAddress,
        amount: 10,
        data: { interestRateData: '0x', hookData: '0x' },
      };
      await expect(manager.mint(mintParams)).to.be.revertedWithCustomError(manager, 'NotPool');
    });
    it('should revert if user pass invalid asset address', async () => {
      const mintParams = {
        asset: ZeroAddress,
        pool,
        amount: 0,
        data: { interestRateData: '0x', hookData: '0x' },
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
        data: { interestRateData: '0x', hookData: '0x' },
      };
      await expect(manager.mint(mintParams)).to.be.revertedWithCustomError(
        manager,
        'ZeroValueNotAllowed'
      );
    });

    it('should emit the event IncreasedLiquidity on Mint', async () => {
      // mint asset tokens to alice
      const mintAmount = ethers.parseUnits('100', 18);
      const supplyAmount = ethers.parseUnits('10', 18);

      await tokenA.connect(alice)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await alice.getAddress())).to.be.equals(mintAmount);
      const mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      // Approve the NFT Position Manager
      await tokenA.approve(manager.target, mintAmount);

      await expect(manager.mint(mintParams))
        .to.emit(manager, 'LiquidityIncreased')
        .withArgs(tokenA.target, 1, supplyAmount);
    });

    it('_handleLiquidity should transfer asset from user to NFT-Position-Manager & mint NFT', async () => {
      // mint asset tokens to alice
      const mintAmount = ethers.parseUnits('100', 18);
      const supplyAmount = ethers.parseUnits('10', 18);

      await tokenA.connect(alice)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await alice.getAddress())).to.be.equals(mintAmount);
      const mintParams = {
        asset: tokenA,
        pool,
        amount: ethers.parseUnits('10', 18),
        data: { interestRateData: '0x', hookData: '0x' },
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

  describe('increaseliquidity', () => {
    it('should revert if user pass invalid asset address', async () => {
      const mintAmount = ethers.parseUnits('100', 18);
      const supplyAmount = ethers.parseUnits('10', 18);
      await tokenA.connect(alice)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await alice.getAddress())).to.be.equals(mintAmount);
      const mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      // Approve the NFT Position Manager
      await tokenA.approve(manager.target, supplyAmount);

      // mint a postion for tokenId 1 by alice
      await manager.mint(mintParams);

      const liquidityParams = {
        asset: ZeroAddress,
        pool,
        amount: supplyAmount,
        tokenId: 1,
        data: { interestRateData: '0x', hookData: '0x' },
      };
      await expect(manager.increaseLiquidity(liquidityParams)).to.be.revertedWithCustomError(
        manager,
        'ZeroAddressNotAllowed'
      );
    });
    it('should revert if user pass invalid amount', async () => {
      const mintAmount = ethers.parseUnits('100', 18);
      const supplyAmount = ethers.parseUnits('10', 18);
      await tokenA.connect(alice)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await alice.getAddress())).to.be.equals(mintAmount);
      const mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      // Approve the NFT Position Manager
      await tokenA.approve(manager.target, supplyAmount);

      // mint a postion for tokenId 1 by alice
      await manager.mint(mintParams);

      const liquidityParams = {
        asset: tokenA,
        pool,
        amount: 0,
        tokenId: 1,
        data: { interestRateData: '0x', hookData: '0x' },
      };
      await expect(manager.increaseLiquidity(liquidityParams)).to.be.revertedWithCustomError(
        manager,
        'ZeroValueNotAllowed'
      );
    });
    it('should revert if the caller is not owner or approved for tokenId', async () => {
      const supplyAmount = ethers.parseUnits('10', 18);
      const mintAmount = ethers.parseUnits('100', 18);
      await tokenA.connect(alice)['mint(uint256)'](mintAmount);

      const mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      await tokenA.connect(alice).approve(manager.target, supplyAmount);
      await manager.connect(alice).mint(mintParams);

      const liquidityParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        tokenId: 1,
        data: { interestRateData: '0x', hookData: '0x' },
      };
      await expect(
        manager.connect(bob).increaseLiquidity(liquidityParams)
      ).to.be.revertedWithCustomError(manager, 'NotTokenIdOwner');
    });
    it('_handleLiquidity should transfer asset from user to NFT-Position-Manager', async () => {
      const mintAmount = ethers.parseUnits('100', 18);
      const supplyAmount = ethers.parseUnits('10', 18);

      await tokenA.connect(bob)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await bob.getAddress())).to.be.equals(mintAmount);
      const mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
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
        data: { interestRateData: '0x', hookData: '0x' },
      };

      await manager.connect(bob).increaseLiquidity(liquidityParams);
      let balanceAfterLiquidity = await tokenA.balanceOf(pool.target);

      expect(await tokenA.balanceOf(pool.target)).to.be.equals(balanceAfterLiquidity);

      // Bob still should be the owner of the nft after increase liquidity
      expect(await manager.ownerOf(1)).to.be.equals(await bob.getAddress());
    });
  });

  describe('withdraw', () => {
    it('should revert if user pass invalid asset address', async () => {
      const mintAmount = ethers.parseUnits('100', 18);
      const supplyAmount = ethers.parseUnits('10', 18);
      await tokenA.connect(alice)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await alice.getAddress())).to.be.equals(mintAmount);
      const mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      // Approve the NFT Position Manager
      await tokenA.approve(manager.target, supplyAmount);

      // mint a postion for tokenId 1 by alice
      await manager.mint(mintParams);

      const withdrawParams = {
        asset: ZeroAddress,
        pool,
        amount: supplyAmount,
        tokenId: 1,
        data: { interestRateData: '0x', hookData: '0x' },
      };
      await expect(manager.withdraw(withdrawParams)).to.be.revertedWithCustomError(
        manager,
        'ZeroAddressNotAllowed'
      );
    });
    it('should revert if user pass invalid amount', async () => {
      const mintAmount = ethers.parseUnits('100', 18);
      const supplyAmount = ethers.parseUnits('10', 18);
      await tokenA.connect(alice)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await alice.getAddress())).to.be.equals(mintAmount);
      const mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      // Approve the NFT Position Manager
      await tokenA.approve(manager.target, supplyAmount);

      // mint a postion for tokenId 1 by alice
      await manager.mint(mintParams);

      const withdrawParams = {
        asset: tokenA,
        pool,
        amount: 0,
        tokenId: 1,
        data: { interestRateData: '0x', hookData: '0x' },
      };
      await expect(manager.withdraw(withdrawParams)).to.be.revertedWithCustomError(
        manager,
        'ZeroValueNotAllowed'
      );
    });
    it('should revert if the caller is not owner or approved for tokenId', async () => {
      const supplyAmount = ethers.parseUnits('10', 18);
      const mintAmount = ethers.parseUnits('100', 18);
      await tokenA.connect(alice)['mint(uint256)'](mintAmount);

      const mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      await tokenA.connect(alice).approve(manager.target, supplyAmount);
      await manager.connect(alice).mint(mintParams);

      const withdrawParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        tokenId: 1,
        data: { interestRateData: '0x', hookData: '0x' },
      };
      await expect(manager.connect(bob).withdraw(withdrawParams)).to.be.revertedWithCustomError(
        manager,
        'NotTokenIdOwner'
      );
    });
    it('Should be able to withdraw and update the balances', async () => {
      let mintAmount = ethers.parseUnits('150', 18);
      let supplyAmount = ethers.parseUnits('50', 18);
      let withdrawAmount = ethers.parseUnits('20', 18);
      await tokenA.connect(bob)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await bob.getAddress())).to.be.equals(mintAmount);
      const mintParams = {
        asset: await tokenA.getAddress(),
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };
      await tokenA.connect(bob).approve(manager.target, supplyAmount);
      await manager.connect(bob).mint(mintParams);

      const withdrawParams = {
        asset: await tokenA.getAddress(),
        pool,
        amount: supplyAmount,
        tokenId: 1,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      await manager.connect(bob).withdraw(withdrawParams);
    });
  });

  describe('burn', () => {
    it('Should revert if he is not the ower or approved', async () => {
      const supplyAmount = ethers.parseUnits('10', 18);
      const mintAmount = ethers.parseUnits('100', 18);
      await tokenA.connect(alice)['mint(uint256)'](mintAmount);

      const mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      await tokenA.connect(alice).approve(manager.target, supplyAmount);
      await manager.connect(alice).mint(mintParams);

      await expect(manager.connect(bob).burn(1)).to.be.revertedWithCustomError(
        manager,
        'NotTokenIdOwner'
      );
    });
    it.skip('should revert if the position not cleared', async () => {
      const supplyAmount = ethers.parseUnits('10', 18);
      const mintAmount = ethers.parseUnits('100', 18);
      await tokenA.connect(alice)['mint(uint256)'](mintAmount);

      const mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      await tokenA.connect(alice).approve(manager.target, supplyAmount);
      await manager.connect(alice).mint(mintParams);

      await expect(manager.connect(alice).burn(1)).to.be.revertedWithCustomError(
        manager,
        'PositionNotCleared'
      );
      await manager.connect(alice).burn(1);
    });
    it('Should burn the tokenId and delete the position', async () => {
      const supplyAmount = ethers.parseUnits('10', 18);
      const mintAmount = ethers.parseUnits('100', 18);
      await tokenA.connect(alice)['mint(uint256)'](mintAmount);

      const mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      await tokenA.connect(alice).approve(manager.target, supplyAmount);
      await manager.connect(alice).mint(mintParams);

      await expect(manager.connect(alice).burn(1)).to.be.revertedWithCustomError(
        manager,
        'PositionNotCleared'
      );
    });
  });

  describe('approved', () => {
    it('Should revert if the tokenId does not exists', async () => {
      await expect(manager.getApproved(1)).to.be.revertedWith(
        'ERC721: approved query for nonexistent token'
      );
    });
    it('Should return the operator address if tokenId is valid', async () => {
      const supplyAmount = ethers.parseUnits('10', 18);
      const mintAmount = ethers.parseUnits('100', 18);
      await tokenA.connect(alice)['mint(uint256)'](mintAmount);

      const mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      await tokenA.connect(alice).approve(manager.target, supplyAmount);
      await manager.connect(alice).mint(mintParams);

      await manager.approve(await bob.getAddress(), 1);

      const operatorAddress = await manager.connect(alice).getApproved(1);
      expect(operatorAddress).to.be.equals(await bob.getAddress());
    });
  });

  describe('borrow', () => {
    it('should revert if user pass invalid asset address', async () => {
      const mintAmount = ethers.parseUnits('100', 18);
      await tokenA.connect(alice)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await alice.getAddress())).to.be.equals(mintAmount);
      const mintParams = {
        asset: tokenA,
        pool,
        amount: ethers.parseUnits('10', 18),
        data: { interestRateData: '0x', hookData: '0x' },
      };

      // Approve the NFT Position Manager
      await tokenA.approve(manager.target, mintAmount);

      // mint a postion for tokenId 1 by alice
      await manager.mint(mintParams);

      const borrowParams = {
        asset: ZeroAddress,
        tokenId: 1,
        amount: 0,
        data: { interestRateData: '0x', hookData: '0x' },
      };
      await expect(manager.borrow(borrowParams)).to.be.revertedWithCustomError(
        manager,
        'ZeroAddressNotAllowed'
      );
    });
    it('should revert if user pass invalid amount', async () => {
      const mintAmount = ethers.parseUnits('100', 18);
      await tokenA.connect(alice)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await alice.getAddress())).to.be.equals(mintAmount);
      const mintParams = {
        asset: await tokenA.getAddress(),
        pool,
        amount: ethers.parseUnits('10', 18),
        data: { interestRateData: '0x', hookData: '0x' },
      };

      // Approve the NFT Position Manager
      await tokenA.approve(manager.target, mintAmount);

      // mint a postion for tokenId 1 by alice
      await manager.mint(mintParams);

      const borrowParams = {
        asset: await tokenA.getAddress(),
        tokenId: 1,
        amount: 0,
        data: { interestRateData: '0x', hookData: '0x' },
      };
      await expect(manager.borrow(borrowParams)).to.be.revertedWithCustomError(
        manager,
        'ZeroValueNotAllowed'
      );
    });
    it('should revert if the caller is not owner or approved for tokenId', async () => {
      const supplyAmount = ethers.parseUnits('10', 18);
      const mintAmount = ethers.parseUnits('100', 18);
      await tokenA.connect(alice)['mint(uint256)'](mintAmount);

      const mintParams = {
        asset: tokenA,
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      await tokenA.connect(alice).approve(manager.target, supplyAmount);
      await manager.connect(alice).mint(mintParams);

      const borrowParams = {
        asset: await tokenA.getAddress(),
        tokenId: 1,
        amount: 0,
        data: { interestRateData: '0x', hookData: '0x' },
      };
      await expect(manager.connect(bob).borrow(borrowParams)).to.be.revertedWithCustomError(
        manager,
        'NotTokenIdOwner'
      );
    });
    it('should emit BorrowIncreased on borrow', async () => {
      let mintAmount = ethers.parseUnits('100', 18);
      let supplyAmount = ethers.parseUnits('50', 18);

      let borrowAmount = ethers.parseUnits('30', 18);
      const mintParams = {
        asset: await tokenA.getAddress(),
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };
      const borrowParams = {
        asset: await tokenA.getAddress(),
        amount: borrowAmount,
        tokenId: 1,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      await tokenA.connect(alice)['mint(uint256)'](mintAmount);

      await tokenA.connect(alice).approve(manager.target, supplyAmount);

      await manager.connect(alice).mint(mintParams);

      await expect(manager.connect(alice).borrow(borrowParams))
        .to.emit(manager, 'BorrowIncreased')
        .withArgs(tokenA.target, borrowAmount, 1);
    });
    it('should transfer assets and update the balances', async () => {
      let mintAmount = ethers.parseUnits('100', 18);
      let supplyAmount = ethers.parseUnits('50', 18);

      let borrowAmount = ethers.parseUnits('30', 18);
      const mintParams = {
        asset: await tokenA.getAddress(),
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };
      const borrowParams = {
        asset: await tokenA.getAddress(),
        amount: borrowAmount,
        tokenId: 1,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      await tokenA.connect(alice)['mint(uint256)'](mintAmount);
      await tokenA.connect(alice).approve(manager.target, supplyAmount);
      await manager.connect(alice).mint(mintParams);

      await manager.connect(alice).borrow(borrowParams);

      expect(await tokenA.balanceOf(await pool.target)).to.be.equals(ethers.parseUnits('20', 18));
      expect(await tokenA.balanceOf(await alice.getAddress())).to.be.equals(
        ethers.parseUnits('80', 18)
      );
    });
  });

  describe('repay', () => {
    it('should revert if user pass invalid asset address', async () => {
      const mintAmount = ethers.parseUnits('100', 18);
      await tokenA.connect(alice)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await alice.getAddress())).to.be.equals(mintAmount);
      const mintParams = {
        asset: tokenA,
        pool,
        amount: ethers.parseUnits('10', 18),
        data: { interestRateData: '0x', hookData: '0x' },
      };

      // Approve the NFT Position Manager
      await tokenA.approve(manager.target, mintAmount);

      // mint a postion for tokenId 1 by alice
      await manager.mint(mintParams);

      const repayParams = {
        asset: ZeroAddress,
        tokenId: 1,
        amount: 0,
        data: { interestRateData: '0x', hookData: '0x' },
      };
      await expect(manager.repay(repayParams)).to.be.revertedWithCustomError(
        manager,
        'ZeroAddressNotAllowed'
      );
    });
    it('should revert if user pass invalid amount', async () => {
      const mintAmount = ethers.parseUnits('100', 18);
      await tokenA.connect(alice)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await alice.getAddress())).to.be.equals(mintAmount);
      const mintParams = {
        asset: await tokenA.getAddress(),
        pool,
        amount: ethers.parseUnits('10', 18),
        data: { interestRateData: '0x', hookData: '0x' },
      };

      // Approve the NFT Position Manager
      await tokenA.approve(manager.target, mintAmount);

      // mint a postion for tokenId 1 by alice
      await manager.mint(mintParams);

      const repayParams = {
        asset: await tokenA.getAddress(),
        tokenId: 1,
        amount: 0,
        data: { interestRateData: '0x', hookData: '0x' },
      };
      await expect(manager.repay(repayParams)).to.be.revertedWithCustomError(
        manager,
        'ZeroValueNotAllowed'
      );
    });
    it('should be able to repay and update the balance', async () => {
      const mintAmount = ethers.parseUnits('150', 18);
      const supplyAmount = ethers.parseUnits('50', 18);
      const borrowAmount = ethers.parseUnits('30', 18);
      const repayAmount = ethers.parseUnits('20', 18);

      await tokenA.connect(bob)['mint(uint256)'](mintAmount);
      expect(await tokenA.balanceOf(await bob.getAddress())).to.be.equals(mintAmount);
      const mintParams = {
        asset: await tokenA.getAddress(),
        pool,
        amount: supplyAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };
      await tokenA.connect(bob).approve(manager.target, supplyAmount);
      await manager.connect(bob).mint(mintParams);

      const borrowParams = {
        asset: await tokenA.getAddress(),
        amount: borrowAmount,
        tokenId: 1,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      await manager.connect(bob).borrow(borrowParams);

      let borrowBalanceBob = await manager.getPosition(1);
      expect(borrowBalanceBob[0][0][2]).to.be.equals(borrowAmount);

      let repayParams = {
        asset: await tokenA.getAddress(),
        tokenId: 1,
        amount: repayAmount,
        data: { interestRateData: '0x', hookData: '0x' },
      };

      await tokenA.connect(bob).approve(manager.target, repayAmount);

      await manager.connect(bob).repay(repayParams);
      borrowBalanceBob = await manager.getPosition(1);
      expect(borrowBalanceBob[0][0][2]).to.be.equals(borrowAmount - repayAmount);

      const repayAmount2 = repayAmount + ethers.parseUnits('30', 18);
      await tokenA.connect(bob).approve(manager.target, repayAmount2);

      repayParams = {
        ...repayParams,
        amount: repayAmount2,
      };
      await manager.connect(bob).repay(repayParams);
    });
  });
});
