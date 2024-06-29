import { HardhatUserConfig } from 'hardhat/config';
import '@nomicfoundation/hardhat-chai-matchers';
import '@nomicfoundation/hardhat-ethers';
import '@nomicfoundation/hardhat-toolbox-viem';
import '@openzeppelin/hardhat-upgrades';
import '@typechain/hardhat';
import 'hardhat-abi-exporter';
import 'hardhat-dependency-compiler';
import 'hardhat-deploy';
import 'solidity-coverage';
import 'solidity-docgen';

import dotenv from 'dotenv';
dotenv.config();

const config: HardhatUserConfig = {
  solidity: {
    version: '0.8.19',
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  paths: {
    tests: './test/hardhat',
  },
  networks: {
    hardhat: {
      allowUnlimitedContractSize: true,
      live: false,
    },
  },
  abiExporter: {
    path: './abi',
    runOnCompile: true,
    clear: true,
    spacing: 2,
  },
  docgen: {
    pages: 'files',
  },
  typechain: {
    outDir: 'types',
  },
};

export default config;
