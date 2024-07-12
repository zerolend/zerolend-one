import { ethers } from 'hardhat';
import { NFTPositionManager, PoolConfigurator, PoolFactory } from '../../../types';
import { ZeroAddress } from 'ethers';

export async function deployNftPositionManager(factory: PoolFactory, admin: string) {
  const NFTPositionManager = await ethers.getContractFactory('NFTPositionManager');
  const Proxy = await ethers.getContractFactory('TransparentUpgradeableProxy');

  const implementation = await NFTPositionManager.deploy();

  const proxy = await Proxy.deploy(implementation.target, admin, '0x');
  const manager = await ethers.getContractAt('NFTPositionManager', proxy.target);
  await manager.initialize(factory.target, ZeroAddress, ZeroAddress, ZeroAddress);

  return manager;
}

export async function deployUIHelper(
  factory: PoolFactory,
  configurator: PoolConfigurator,
  manager: NFTPositionManager
) {
  const UIHelper = await ethers.getContractFactory('UIHelper');
  return await UIHelper.deploy(factory.target, configurator.target, manager.target);
}
