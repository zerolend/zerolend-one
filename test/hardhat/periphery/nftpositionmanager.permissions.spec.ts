import { ethers } from 'hardhat';
import { deployPool } from '../fixtures/pool';
import { MintableERC20, NFTPositionManager } from '../../../types';
import { deployNftPositionManager } from '../fixtures/periphery';
import { SignerWithAddress } from '@nomicfoundation/hardhat-ethers/signers';

describe('NFT Position Manager - permissions', () => {
  let manager: NFTPositionManager;
  let poolFactory;
  let governance: SignerWithAddress, alice: SignerWithAddress, bob: SignerWithAddress;

  beforeEach(async () => {
    [alice, bob] = await ethers.getSigners();
    ({ poolFactory, governance } = await deployPool());
    manager = await deployNftPositionManager(poolFactory, await governance.getAddress());
  });

  it('todo', async () => {
    // todo
  });
});
