import { HardhatUserConfig } from 'hardhat/config';
import '@nomicfoundation/hardhat-toolbox-viem';
import 'hardhat-dependency-compiler';
import dotenv from 'dotenv';
dotenv.config();

const config: HardhatUserConfig = {
  solidity: '0.8.19',

  // dependencyCompiler: {
  //   paths: ['@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol'],
  // },
  networks: {
    hardhat: {
      accounts: [
        {
          privateKey: process.env.WALLET_PRIVATE_KEY || '',
          balance: '10000000000000000000000000000000000000',
        },
      ],
    },
  },
};

export default config;
