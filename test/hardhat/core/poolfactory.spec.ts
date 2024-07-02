import { DataTypes } from '../../../types/contracts/core/pool/Pool';

import { DefaultReserveInterestRateStrategy, MintableERC20, MockAggregator, PoolConfigurator } from '../../../types';
import { deployCore } from '../fixtures/core';
import { PoolFactory } from '../../../types/contracts/core/pool/PoolFactory';
import { Addressable, ZeroAddress } from 'ethers';
import { basicConfig } from '../fixtures/pool';
import { expect } from 'chai';
import { ethers } from 'hardhat';
import { SignerWithAddress } from '@nomicfoundation/hardhat-ethers/signers';

describe.only('Pool Factory', () => {
  let poolFactory: PoolFactory;
  let poolImpl: any;

  let tokenA: MintableERC20;
  let tokenB: MintableERC20;
  let tokenC: MintableERC20;

  let oracleA: MockAggregator;
  let oracleB: MockAggregator;
  let oracleC: MockAggregator;

  let irStrategy: DefaultReserveInterestRateStrategy;

  let owner: SignerWithAddress;
  let addr1: SignerWithAddress;
  let addr2: SignerWithAddress;
  let governance: SignerWithAddress;

  let libraries: {
    BorrowLogic: string | Addressable;
    FlashLoanLogic: string | Addressable;
    LiquidationLogic: string | Addressable;
    PoolLogic: string | Addressable;
    SupplyLogic: string | Addressable;
  }
  before(async () => {
    const fixture = await deployCore();
    [,,,,,,,,addr1, addr2] = await ethers.getSigners();
    ({owner, poolImpl,governance, poolFactory, tokenA, tokenB, tokenC, oracleA, oracleC, oracleB, irStrategy } = fixture);
  });

  before(async () => {
    const fixture = await deployCore();
    ({ poolFactory, libraries, tokenA, tokenB, tokenC, oracleA, oracleC, oracleB, irStrategy } =
      fixture);
  });

  it('should create a new pool', async () => {
    const input: DataTypes.InitPoolParamsStruct = {
      hook: ZeroAddress,
      assets: [tokenA.target, tokenB.target, tokenC.target],
      rateStrategyAddresses: [irStrategy.target, irStrategy.target, irStrategy.target],
      sources: [oracleA.target, oracleB.target, oracleC.target],
      configurations: [basicConfig, basicConfig, basicConfig],
    };

    expect(await poolFactory.poolsLength()).eq(0);

    const tx = await poolFactory.createPool(input);
    await expect(tx).to.emit(poolFactory, 'PoolCreated');

    expect(await poolFactory.poolsLength()).eq(1);
  });

  describe("setImplementation", function () {
    it("should update implementation", async function () {
      await poolFactory.setImplementation(addr1.address);
      expect(await poolFactory.implementation()).to.equal(addr1.address);
    });

    it("should emit ImplementationUpdated event", async function () {
      const oldImplementation = await poolFactory.implementation();
      
      await expect(poolFactory.setImplementation(addr1.address))
        .to.emit(poolFactory, "ImplementationUpdated")
        .withArgs(oldImplementation, addr1.address, owner.address);
    });

    it("should only allow owner to set implementation", async function () {
      await expect(
        poolFactory.connect(addr1).setImplementation(addr1.address)
      ).to.be.revertedWith("Ownable: caller is not the owner");
    });
  });

  describe("setConfigurator", function () {
    let newConfigurator: PoolConfigurator;
    beforeEach(async ()=> {
      const PoolConfigurator = await ethers.getContractFactory('PoolConfigurator');
      newConfigurator = await PoolConfigurator.deploy(poolFactory.target, governance.address);
    })
    it("should update configurator", async function () {
      await poolFactory.setConfigurator(newConfigurator.target);
      expect(await poolFactory.configurator()).to.equal(newConfigurator.target);
    });

    it("should emit ConfiguratorUpdated event", async function () {
      await expect(poolFactory.setConfigurator(newConfigurator.target))
        .to.emit(poolFactory, "ConfiguratorUpdated")
        .withArgs(await poolFactory.configurator(), newConfigurator.target, owner.address);
    });

    it("should only allow owner to set configurator", async function () {
      await expect(
        poolFactory.connect(addr1).setConfigurator(newConfigurator.target)
      ).to.be.revertedWith("Ownable: caller is not the owner");
    });
  });

  describe("setTreasury", function () {
    it("should update treasury", async function () {
      await poolFactory.setTreasury(addr1.address);
      expect(await poolFactory.treasury()).to.equal(addr1.address);
    });

    it("should emit TreasuryUpdated event", async function () {
      await expect(poolFactory.setTreasury(addr1.address))
        .to.emit(poolFactory, "TreasuryUpdated")
        .withArgs(await poolFactory.treasury(), addr1.address, owner.address);
    });

    it("should only allow owner to set treasury", async function () {
      await expect(
        poolFactory.connect(addr1).setTreasury(addr1.address)
      ).to.be.revertedWith("Ownable: caller is not the owner");
    });
  });

  describe("setReserveFactor", function () {
    it("should update reserve factor", async function () {
      await poolFactory.setReserveFactor(50);
      expect(await poolFactory.reserveFactor()).to.equal(50);
    });

    it("should emit ReserveFactorUpdated event", async function () {
      await expect(poolFactory.setReserveFactor(50))
        .to.emit(poolFactory, "ReserveFactorUpdated")
        .withArgs(await poolFactory.reserveFactor(), 50, owner.address);
    });

    it("should only allow owner to set reserve factor", async function () {
      await expect(
        poolFactory.connect(addr1).setReserveFactor(50)
      ).to.be.revertedWith("Ownable: caller is not the owner");
    });
  });

  describe("setRewardsController", function () {
    it("should update rewards controller", async function () {
      await poolFactory.setRewardsController(addr1.address);
      expect(await poolFactory.rewardsController()).to.equal(addr1.address);
    });

    it("should emit RewardsControllerUpdated event", async function () {
      await expect(poolFactory.setRewardsController(addr1.address))
        .to.emit(poolFactory, "RewardsControllerUpdated")
        .withArgs(await poolFactory.rewardsController(), addr1.address, owner.address);
    });

    it("should only allow owner to set rewards controller", async function () {
      await expect(
        poolFactory.connect(addr1).setRewardsController(addr1.address)
      ).to.be.revertedWith("Ownable: caller is not the owner");
    });
  });

  describe("setFlashloanPremium", function () {
    it("should update flashloan premium", async function () {
      await poolFactory.setFlashloanPremium(100);
      expect(await poolFactory.flashLoanPremiumToProtocol()).to.equal(100);
    });

    it("should emit FlashLoanPremiumToProtocolUpdated event", async function () {
      await expect(poolFactory.setFlashloanPremium(100))
        .to.emit(poolFactory, "FlashLoanPremiumToProtocolUpdated")
        .withArgs(await poolFactory.flashLoanPremiumToProtocol(), 100, owner.address);
    });

    it("should only allow owner to set flashloan premium", async function () {
      await expect(
        poolFactory.connect(addr1).setFlashloanPremium(100)
      ).to.be.revertedWith("Ownable: caller is not the owner");
    });
  });
});
