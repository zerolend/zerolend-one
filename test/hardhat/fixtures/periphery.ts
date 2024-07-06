import { ethers } from 'hardhat';
import { PoolFactory } from '../../../types';
import { ZeroAddress } from 'ethers';

export async function deployNftPositionManager(factory: PoolFactory, admin: string) {
  const NFTPositionManager = await ethers.getContractFactory('NFTPositionManager');
  const Proxy = await ethers.getContractFactory('TransparentUpgradeableProxy');

  const implementation = await NFTPositionManager.deploy();

  const proxy = await Proxy.deploy(implementation.target, admin, '0x');
  const nftPositionManager = await ethers.getContractAt('NFTPositionManager', proxy.target);

  await nftPositionManager.initialize(factory.target, ZeroAddress, ZeroAddress, ZeroAddress);
  return nftPositionManager;
}
