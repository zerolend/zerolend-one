import { parseUnits } from 'ethers';
import { ethers } from 'hardhat';

export async function deployCore() {
  const [owner, whale, ant, governance] = await ethers.getSigners();

  const BorrowLogic = await ethers.getContractFactory('BorrowLogic');
  const FlashLoanLogic = await ethers.getContractFactory('FlashLoanLogic');
  const LiquidationLogic = await ethers.getContractFactory('LiquidationLogic');
  const PoolLogic = await ethers.getContractFactory('PoolLogic');
  const SupplyLogic = await ethers.getContractFactory('SupplyLogic');
  const PoolFactory = await ethers.getContractFactory('PoolFactory');
  const CuratedVaultFactory = await ethers.getContractFactory('CuratedVaultFactory');
  const CuratedVault = await ethers.getContractFactory('CuratedVault');
  const PoolConfigurator = await ethers.getContractFactory('PoolConfigurator');
  const MintableERC20 = await ethers.getContractFactory('MintableERC20');
  const MockAggregator = await ethers.getContractFactory('MockAggregator');
  const DefaultReserveInterestRateStrategy = await ethers.getContractFactory(
    'DefaultReserveInterestRateStrategy'
  );

  const borrowLogic = await BorrowLogic.deploy();
  const flashLoanLogic = await FlashLoanLogic.deploy();
  const liquidationLogic = await LiquidationLogic.deploy();
  const poolLogic = await PoolLogic.deploy();
  const supplyLogic = await SupplyLogic.deploy();

  const libraries = {
    BorrowLogic: borrowLogic.target,
    FlashLoanLogic: flashLoanLogic.target,
    LiquidationLogic: liquidationLogic.target,
    PoolLogic: poolLogic.target,
    SupplyLogic: supplyLogic.target,
  };

  const Pool = await ethers.getContractFactory('Pool', { libraries });

  // deploy pool
  const poolImpl = await Pool.deploy();
  const poolFactory = await PoolFactory.deploy(poolImpl.target);
  const configurator = await PoolConfigurator.deploy(poolFactory.target, governance.address);
  await poolFactory.setConfigurator(configurator.target);

  // deploy vault
  const curatedVaultImpl = await CuratedVault.deploy();
  const curatedVaultFactory = await CuratedVaultFactory.deploy(curatedVaultImpl.target);

  // create dummy tokens
  const tokenA = await MintableERC20.deploy('TOKEN A', 'TOKENA');
  const tokenB = await MintableERC20.deploy('TOKEN B', 'TOKENB');
  const tokenC = await MintableERC20.deploy('TOKEN C', 'TOKENC');

  // create dummy oracles
  const oracleA = await MockAggregator.deploy(1e8);
  const oracleB = await MockAggregator.deploy(2 * 1e8);
  const oracleC = await MockAggregator.deploy(100 * 1e8);

  const irStrategy = await DefaultReserveInterestRateStrategy.deploy(
    parseUnits('0.45', 27).toString(),
    '0',
    parseUnits('0.07', 27).toString(),
    parseUnits('0.3', 27).toString()
  );

  return {
    owner,
    whale,
    ant,
    configurator,
    governance,
    irStrategy,
    poolImpl,
    poolFactory,
    curatedVaultFactory,
    curatedVaultImpl,
    tokenA,
    tokenB,
    tokenC,
    oracleA,
    oracleB,
    oracleC,
    libraries,
  };
}
