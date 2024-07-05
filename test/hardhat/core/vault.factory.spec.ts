import { DataTypes } from '../../../types/contracts/core/pool/Pool';

import {
  CuratedVaultFactory,
  DefaultReserveInterestRateStrategy,
  MintableERC20,
  MockAggregator,
} from '../../../types';
import { ZeroAddress, keccak256 } from 'ethers';
import { basicConfig, deployPool } from '../fixtures/pool';
import { expect } from 'chai';
import { SignerWithAddress } from '@nomicfoundation/hardhat-ethers/signers';
import { ethers } from 'hardhat';

describe('Curated Vault Factory', () => {
  let curatedVaultFactory: CuratedVaultFactory;

  let tokenA: MintableERC20;
  let tokenB: MintableERC20;
  let tokenC: MintableERC20;

  let oracleA: MockAggregator;
  let oracleB: MockAggregator;
  let oracleC: MockAggregator;

  let irStrategy: DefaultReserveInterestRateStrategy;

  let owner: SignerWithAddress;
  let ant: SignerWithAddress;

  beforeEach(async () => {
    const fixture = await deployPool();
    ({
      curatedVaultFactory,
      tokenA,
      tokenB,
      tokenC,
      oracleA,
      oracleC,
      oracleB,
      irStrategy,
      ant,
      owner,
    } = fixture);
  });

  describe('vault creation & updating', function () {
    it('should create a new vault', async () => {
      await expect(await curatedVaultFactory.vaultsLength()).eq(0);
      const tx = await curatedVaultFactory.createVault(
        owner.address, // address initialOwner,
        owner.address, // address initialProxyOwner,
        86400, // uint256 initialTimelock,
        tokenA.target, // address asset,
        'TEST', // string memory name,
        'TEST-1', // string memory symbol,
        keccak256('0x') // bytes32 salt
      );
      await expect(tx).to.emit(curatedVaultFactory, 'VaultCreated');
      await expect(await curatedVaultFactory.vaultsLength()).eq(1);
    });

    it('should update vault implementation properly and not allow re-init(..)', async () => {
      const input: DataTypes.InitPoolParamsStruct = {
        hook: ZeroAddress,
        assets: [tokenA.target, tokenB.target, tokenC.target],
        rateStrategyAddresses: [irStrategy.target, irStrategy.target, irStrategy.target],
        sources: [oracleA.target, oracleB.target, oracleC.target],
        configurations: [basicConfig, basicConfig, basicConfig],
      };

      // should deploy pool
      const tx = await curatedVaultFactory.createVault(
        owner.address, // address initialOwner,
        owner.address, // address initialProxyOwner,
        86400, // uint256 initialTimelock,
        tokenA.target, // address asset,
        'TEST', // string memory name,
        'TEST-1', // string memory symbol,
        keccak256('0x') // bytes32 salt
      );

      await expect(tx).to.emit(curatedVaultFactory, 'VaultCreated');
      await expect(await curatedVaultFactory.vaultsLength()).eq(1);
      const vaultAddr = await curatedVaultFactory.vaults(0);

      const vault = await ethers.getContractAt('CuratedVault', vaultAddr);
      await expect(await vault.revision()).eq('1');
      await expect(
        vault.initialize(
          owner.address, // address initialOwner,
          86400, // uint256 initialTimelock,
          tokenA.target, // address asset,
          'TEST', // string memory name,
          'TEST-1' // string memory symbol,
        )
      ).to.revertedWith('Initializable: contract is already initialized');

      // now try to upgrade the beacon
      const UpgradedCuratedVault = await ethers.getContractFactory('UpgradedCuratedVault');
      const upgradedPool = await UpgradedCuratedVault.deploy();
      const tx2 = await curatedVaultFactory.setImplementation(upgradedPool.target);
      await expect(tx2).to.emit(curatedVaultFactory, 'ImplementationUpdated');

      // check if the pool upgraded properly
      await expect(await vault.revision()).eq('1000');
      await expect(
        vault.initialize(
          owner.address, // address initialOwner,
          86400, // uint256 initialTimelock,
          tokenA.target, // address asset,
          'TEST', // string memory name,
          'TEST-1' // string memory symbol,
        )
      ).to.revertedWith('Initializable: contract is already initialized');
    });
  });

  describe('setImplementation', function () {
    it('should update implementation', async function () {
      await curatedVaultFactory.setImplementation(ant.address);
      expect(await curatedVaultFactory.implementation()).to.equal(ant.address);
    });

    it('should emit ImplementationUpdated event', async function () {
      const oldImplementation = await curatedVaultFactory.implementation();

      await expect(curatedVaultFactory.setImplementation(ant.address))
        .to.emit(curatedVaultFactory, 'ImplementationUpdated')
        .withArgs(oldImplementation, ant.address, owner.address);
    });

    it('should only allow owner to set implementation', async function () {
      await expect(
        curatedVaultFactory.connect(ant).setImplementation(ant.address)
      ).to.be.revertedWith('Ownable: caller is not the owner');
    });
  });

  // describe('setConfigurator', function () {
  //   let newConfigurator: PoolConfigurator;
  //   beforeEach(async () => {
  //     const PoolConfigurator = await ethers.getContractFactory('PoolConfigurator');
  //     newConfigurator = await PoolConfigurator.deploy(curatedVaultFactory.target, governance.address);
  //   });
  //   it('should update configurator', async function () {
  //     await curatedVaultFactory.setConfigurator(newConfigurator.target);
  //     expect(await curatedVaultFactory.configurator()).to.equal(newConfigurator.target);
  //   });

  //   it('should emit ConfiguratorUpdated event', async function () {
  //     await expect(curatedVaultFactory.setConfigurator(newConfigurator.target))
  //       .to.emit(curatedVaultFactory, 'ConfiguratorUpdated')
  //       .withArgs(await curatedVaultFactory.configurator(), newConfigurator.target, owner.address);
  //   });

  //   it('should only allow owner to set configurator', async function () {
  //     await expect(
  //       curatedVaultFactory.connect(ant).setConfigurator(newConfigurator.target)
  //     ).to.be.revertedWith('Ownable: caller is not the owner');
  //   });
  // });

  // describe('setTreasury', function () {
  //   it('should update treasury', async function () {
  //     await curatedVaultFactory.setTreasury(ant.address);
  //     expect(await curatedVaultFactory.treasury()).to.equal(ant.address);
  //   });

  //   it('should emit TreasuryUpdated event', async function () {
  //     await expect(curatedVaultFactory.setTreasury(ant.address))
  //       .to.emit(curatedVaultFactory, 'TreasuryUpdated')
  //       .withArgs(await curatedVaultFactory.treasury(), ant.address, owner.address);
  //   });

  //   it('should only allow owner to set treasury', async function () {
  //     await expect(curatedVaultFactory.connect(ant).setTreasury(ant.address)).to.be.revertedWith(
  //       'Ownable: caller is not the owner'
  //     );
  //   });
  // });

  // describe('setReserveFactor', function () {
  //   it('should update reserve factor', async function () {
  //     await curatedVaultFactory.setReserveFactor(50);
  //     expect(await curatedVaultFactory.reserveFactor()).to.equal(50);
  //   });

  //   it('should emit ReserveFactorUpdated event', async function () {
  //     await expect(curatedVaultFactory.setReserveFactor(50))
  //       .to.emit(curatedVaultFactory, 'ReserveFactorUpdated')
  //       .withArgs(await curatedVaultFactory.reserveFactor(), 50, owner.address);
  //   });

  //   it('should only allow owner to set reserve factor', async function () {
  //     await expect(curatedVaultFactory.connect(ant).setReserveFactor(50)).to.be.revertedWith(
  //       'Ownable: caller is not the owner'
  //     );
  //   });
  // });

  // describe('setRewardsController', function () {
  //   it('should update rewards controller', async function () {
  //     await curatedVaultFactory.setRewardsController(ant.address);
  //     expect(await curatedVaultFactory.rewardsController()).to.equal(ant.address);
  //   });

  //   it('should emit RewardsControllerUpdated event', async function () {
  //     await expect(curatedVaultFactory.setRewardsController(ant.address))
  //       .to.emit(curatedVaultFactory, 'RewardsControllerUpdated')
  //       .withArgs(await curatedVaultFactory.rewardsController(), ant.address, owner.address);
  //   });

  //   it('should only allow owner to set rewards controller', async function () {
  //     await expect(curatedVaultFactory.connect(ant).setRewardsController(ant.address)).to.be.revertedWith(
  //       'Ownable: caller is not the owner'
  //     );
  //   });
  // });

  // describe('setFlashloanPremium', function () {
  //   it('should update flashloan premium', async function () {
  //     await curatedVaultFactory.setFlashloanPremium(100);
  //     expect(await curatedVaultFactory.flashLoanPremiumToProtocol()).to.equal(100);
  //   });

  //   it('should emit FlashLoanPremiumToProtocolUpdated event', async function () {
  //     await expect(curatedVaultFactory.setFlashloanPremium(100))
  //       .to.emit(curatedVaultFactory, 'FlashLoanPremiumToProtocolUpdated')
  //       .withArgs(await curatedVaultFactory.flashLoanPremiumToProtocol(), 100, owner.address);
  //   });

  //   it('should only allow owner to set flashloan premium', async function () {
  //     await expect(curatedVaultFactory.connect(ant).setFlashloanPremium(100)).to.be.revertedWith(
  //       'Ownable: caller is not the owner'
  //     );
  //   });
  // });
});
