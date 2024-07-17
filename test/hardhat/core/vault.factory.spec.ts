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
});
