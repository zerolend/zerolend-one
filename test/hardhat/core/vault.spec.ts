import {
  CuratedVault,
  CuratedVaultFactory,
  DefaultReserveInterestRateStrategy,
  MintableERC20,
  MockAggregator,
} from '../../../types';
import { MaxUint256, keccak256 } from 'ethers';
import { deployPool } from '../fixtures/pool';
import { expect } from 'chai';
import { SignerWithAddress } from '@nomicfoundation/hardhat-ethers/signers';
import hre, { ethers } from 'hardhat';

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

  let tokenA: MintableERC20;
  let tokenB: MintableERC20;
  let tokenC: MintableERC20;

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
  let allMarketParams: {
    loanToken: string;
    collateralToken: string;
    oracle: string;
    irm: string;
    lltv: number;
  }[];
  let idleParams: {
    loanToken: string;
    collateralToken: string;
    oracle: string;
    irm: string;
    lltv: number;
  };

  beforeEach(async () => {
    const fixture = await deployPool();
    ({
      curatedVaultFactory: factory,
      tokenA,
      tokenB,
      tokenC,
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

    const tx = await factory.createVault(
      admin.address, // address initialOwner,
      admin.address, // address initialProxyOwner,
      86400, // uint256 initialTimelock,
      tokenA.target, // address asset,
      'TEST', // string memory name,
      'TEST-1', // string memory symbol,
      keccak256('0x') // bytes32 salt
    );

    await expect(tx).to.emit(factory, 'VaultCreated');
    await expect(await factory.vaultsLength()).eq(1);

    supplyCap = BigInt(50 * suppliers.length * 2) / BigInt(marketsCount / 2);

    const vaultAddr = await factory.vaults(0);
    vault = await ethers.getContractAt('CuratedVault', vaultAddr);
    hre.tracer.enabled = true;
  });
});
