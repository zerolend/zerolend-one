import { HardhatUserConfig } from 'hardhat/config';
import '@nomicfoundation/hardhat-toolbox-viem';
import 'hardhat-dependency-compiler';
import 'solidity-docgen';
import dotenv from 'dotenv';
dotenv.config();

const config: HardhatUserConfig = {
  solidity: '0.8.19',

  // dependencyCompiler: {
  //   paths: ['@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol'],
  // },
  docgen: {
    pages: 'files',
  },
  networks: {
    hardhat: {},
  },
};

export default config;
