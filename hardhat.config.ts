import { HardhatUserConfig } from 'hardhat/config';
import '@nomicfoundation/hardhat-chai-matchers';
import '@nomicfoundation/hardhat-ethers';
import '@nomicfoundation/hardhat-toolbox-viem';
import '@openzeppelin/hardhat-upgrades';
import '@typechain/hardhat';
import 'hardhat-abi-exporter';
import 'hardhat-contract-sizer';
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
  gasReporter: {
    // @ts-ignore
    reportFormat: 'terminal',
    outputFile: 'coverage/gasReport.txt',
    noColors: true,
    forceTerminalOutput: true,
    forceTerminalOutputFormat: 'terminal',
  },
  paths: {
    tests: './test/hardhat',
  },
  networks: {
    hardhat: {
      live: false,
      loggingEnabled: false,
      allowUnlimitedContractSize: true,
    },
    sepolia: {
      url: `https://1rpc.io/sepolia`,
      accounts: process.env.WALLET_PRIVATE_KEY ? [process.env.WALLET_PRIVATE_KEY] : [],
      saveDeployments: true,
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
    exclude: ['core/interfaces', 'periphery/interfaces', 'governance', 'mocks'],
  },
  typechain: {
    outDir: 'types',
  },
  namedAccounts: {
    deployer: 0,
  },
  etherscan: {
    apiKey: {
      sepolia: process.env.ETHERSCAN_KEY || '',
      mainnet: process.env.ETHERSCAN_KEY || '',
    },
  },
};

export default config;
