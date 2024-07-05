import {
  CuratedVault,
  CuratedVaultFactory,
  DefaultReserveInterestRateStrategy,
  MintableERC20,
  MockAggregator,
  PoolFactory,
} from '../../../types';
import { MaxUint256, ZeroAddress, keccak256 } from 'ethers';
import { basicConfig, deployPool } from '../fixtures/pool';
import { expect } from 'chai';
import _range from 'lodash/range';
import { SignerWithAddress } from '@nomicfoundation/hardhat-ethers/signers';
import hre, { ethers } from 'hardhat';
import { DataTypes, Pool } from '../../../types/contracts/core/pool/Pool';

let seed = 42;
const random = () => {
  seed = (seed * 16807) % 2147483647;
  return (seed - 1) / 2147483646;
};

describe('Curated Vault', () => {
  // Without the division it overflows.
  const initBalance = MaxUint256 / BigInt(10000000000000000);
  const oraclePriceScale = BigInt(1000000000000000000000000000000000000);
  const marketsCount = 5;
  const timelock = 3600 * 24 * 7; // 1 week.

  let factory: CuratedVaultFactory;
  let poolFactory: PoolFactory;

  let poolA: Pool;
  let poolB: Pool;
  let poolC: Pool;
  let poolD: Pool;
  let poolE: Pool;

  let loan: MintableERC20;
  let collateral: MintableERC20;

  let oracleA: MockAggregator;
  let oracleB: MockAggregator;
  let oracleC: MockAggregator;

  let irStrategy: DefaultReserveInterestRateStrategy;

  let vault: CuratedVault;

  let admin: SignerWithAddress;
  let curator: SignerWithAddress;
  let allocator: SignerWithAddress;
  let suppliers: SignerWithAddress[];
  let borrowers: SignerWithAddress[];

  let supplyCap: bigint;

  beforeEach(async () => {
    const fixture = await deployPool();
    ({
      curatedVaultFactory: factory,
      poolFactory,
      tokenA: loan,
      tokenB: collateral,
      oracleA,
      oracleC,
      oracleB,
      irStrategy,
      whale: allocator,
      ant: curator,
      owner: admin,
    } = fixture);

    const allSigners = await ethers.getSigners();
    const users = allSigners.slice(0, -3);
    suppliers = users.slice(0, users.length / 2);
    borrowers = users.slice(users.length / 2);

    // create 5 pools and a vault
    const input: DataTypes.InitPoolParamsStruct = {
      hook: ZeroAddress,
      assets: [loan.target, collateral.target],
      rateStrategyAddresses: [irStrategy.target, irStrategy.target],
      sources: [oracleA.target, oracleB.target],
      configurations: [basicConfig, basicConfig],
    };

    await poolFactory.createPool(input);
    await poolFactory.createPool(input);
    await poolFactory.createPool(input);
    await poolFactory.createPool(input);
    await poolFactory.createPool(input);

    poolA = await ethers.getContractAt('Pool', await poolFactory.pools(0));
    poolB = await ethers.getContractAt('Pool', await poolFactory.pools(1));
    poolC = await ethers.getContractAt('Pool', await poolFactory.pools(2));
    poolD = await ethers.getContractAt('Pool', await poolFactory.pools(3));
    poolE = await ethers.getContractAt('Pool', await poolFactory.pools(4));

    await factory.createVault(
      admin.address,
      admin.address,
      86400,
      loan.target,
      'TEST',
      'TEST-1',
      keccak256('0x')
    );

    supplyCap = BigInt(50 * suppliers.length * 2) / BigInt(marketsCount / 2);

    const vaultAddr = await factory.vaults(0);
    vault = await ethers.getContractAt('CuratedVault', vaultAddr);

    for (const user of users) {
      await loan.mint(user.address, initBalance);
      await loan.connect(user).approve(vault.target, MaxUint256);
      await collateral.mint(user.address, initBalance);
      await collateral.connect(user).approve(vault.target, MaxUint256);
    }

    hre.tracer.enabled = true;
  });
});
