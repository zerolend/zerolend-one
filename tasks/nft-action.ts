import { task } from 'hardhat/config';
import { waitForTx } from './utils';
import { DataTypes } from '../types/contracts/core/pool/Pool';
import { MaxUint256, parseEther as eth, ZeroAddress } from 'ethers';
import { HardhatRuntimeEnvironment } from 'hardhat/types';

task(`nft-action`).setAction(async (_, hre: HardhatRuntimeEnvironment) => {
  if (hre.network.name !== 'linea') throw new Error('invalid network');

  const weth = '0xe5D7C2a44FfDDf6b295A15c148167daaAf5Cf34f';
  const pool = await hre.ethers.getContractAt('Pool', '0x1f3bb379a6d1beb067cd033a4304e135f0174269');
  const token = await hre.ethers.getContractAt('ERC20', weth);

  const manageraddr = (await hre.deployments.get('NFTPositionManager')).address;
  const manager = await hre.ethers.getContractAt('NFTPositionManager', manageraddr);

  console.log('manager at', manager.target);

  console.log('giving approval');
  await waitForTx(await token.approve(manager.target, MaxUint256));

  console.log('supplying asset');
  const supply = await manager.mint.populateTransaction({
    asset: weth,
    pool: pool.target,
    amount: eth('0.001'),
    data: { interestRateData: '0x', hookData: '0x' },
  });

  const borrow = await manager.borrow.populateTransaction({
    asset: weth,
    tokenId: 1,
    amount: eth('0.0001'),
    data: { interestRateData: '0x', hookData: '0x' },
  });

  await waitForTx(await manager.multicall([supply.data, borrow.data]));
});
