import { ethers } from 'hardhat';
import { ZeroAddress } from 'ethers';
import { Factory } from '../../../types/contracts/core/protocol/factory/Factory';

export async function deployCore() {
  const [owner, whale, ant, governance] = await ethers.getSigners();

  const BorrowLogic = await ethers.getContractFactory('BorrowLogic');
  const FlashLoanLogic = await ethers.getContractFactory('FlashLoanLogic');
  const LiquidationLogic = await ethers.getContractFactory('LiquidationLogic');
  const PoolLogic = await ethers.getContractFactory('PoolLogic');
  const SupplyLogic = await ethers.getContractFactory('SupplyLogic');

  const Factory = await ethers.getContractFactory('Factory');
  const PoolConfigurator = await ethers.getContractFactory('PoolConfigurator');

  const borrowLogic = await BorrowLogic.deploy();
  const flashLoanLogic = await FlashLoanLogic.deploy();
  const liquidationLogic = await LiquidationLogic.deploy();
  const poolLogic = await PoolLogic.deploy();
  const supplyLogic = await SupplyLogic.deploy();

  const PoolFactory = await ethers.getContractFactory('Pool', {
    libraries: {
      BorrowLogic: borrowLogic.target,
      FlashLoanLogic: flashLoanLogic.target,
      LiquidationLogic: liquidationLogic.target,
      PoolLogic: poolLogic.target,
      SupplyLogic: supplyLogic.target,
    },
  });

  // deploy pool
  const poolImpl = await PoolFactory.deploy();
  const factory = await Factory.deploy(poolImpl.target);
  const configurator = await PoolConfigurator.deploy(factory.target, governance.address);

  await factory.setConfigurator(configurator.target);

  return {
    owner,
    whale,
    ant,
    configurator,
    governance,
    poolImpl,
    factory,
  };
}
