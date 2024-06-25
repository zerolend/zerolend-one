import { HardhatUserConfig } from 'hardhat/config';
import '@nomicfoundation/hardhat-toolbox-viem';
import '@openzeppelin/hardhat-upgrades';
import 'hardhat-deploy';
import '@typechain/hardhat';
import '@nomicfoundation/hardhat-ethers';
import '@nomicfoundation/hardhat-chai-matchers';
import 'hardhat-abi-exporter';
import 'hardhat-dependency-compiler';
import 'solidity-docgen';
import 'solidity-coverage';

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
