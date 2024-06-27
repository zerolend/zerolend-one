import { HardhatUserConfig } from 'hardhat/config';
import '@nomicfoundation/hardhat-toolbox-viem';
import '@typechain/hardhat';
import '@nomicfoundation/hardhat-ethers';
import '@nomicfoundation/hardhat-chai-matchers';
import '@openzeppelin/hardhat-upgrades';
import 'hardhat-abi-exporter';
import 'hardhat-dependency-compiler';
import 'solidity-docgen';
import 'solidity-coverage';
import 'hardhat-deploy';
import 'hardhat-contract-sizer';

import dotenv from 'dotenv';
dotenv.config();

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      {
        version: '0.8.10',
        settings: {
          optimizer: { enabled: true, runs: 100_000 },
        },
      },
      {
        version: '0.8.12',
        settings: {
          optimizer: { enabled: true, runs: 100_000 },
        },
      },
      {
        version: '0.8.19',
        settings: {
          optimizer: { enabled: true, runs: 100_000 },
        },
      },
    ],
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
  dependencyCompiler: {
    paths: [],
  },
  typechain: {
    outDir: 'types',
  },
  networks: {
    hardhat: {
      live: false,
      loggingEnabled: false,
      allowUnlimitedContractSize: true
    },
    goerli: {
      url: `https://goerli.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161`,
      accounts: [process.env.WALLET_PRIVATE_KEY || ''],
      saveDeployments: true,
    },
    blast: {
      // url: `https://rpc.blast.io`,
      url: `http://127.0.0.1:8545/`,
      accounts: [process.env.WALLET_PRIVATE_KEY || ''],
    },
    blastSepolia: {
      url: `https://sepolia.blast.io`,
      accounts: [process.env.WALLET_PRIVATE_KEY || ''],
      saveDeployments: true,
    },
    lineaSepolia: {
      url: `https://rpc.sepolia.linea.build`,
      accounts: [process.env.WALLET_PRIVATE_KEY || ''],
      saveDeployments: true,
    },
    mainnet: {
      url: `https://rpc.ankr.com/eth`,
      accounts: [process.env.WALLET_PRIVATE_KEY || ''],
      saveDeployments: true,
    },
    linea: {
      url: `https://rpc.linea.build/`,
      accounts: [process.env.WALLET_PRIVATE_KEY || ''],
      saveDeployments: true,
    },
    era: {
      url: `https://mainnet.era.zksync.io`,
      accounts: [process.env.WALLET_PRIVATE_KEY || ''],
    },
    manta: {
      url: `https://pacific-rpc.manta.network/http`,
      accounts: [process.env.WALLET_PRIVATE_KEY || ''],
    },
  },
  namedAccounts: {
    deployer: 0,
  },
  etherscan: {
    apiKey: {
      blast: process.env.BLASTSCAN_KEY || '',
      linea: process.env.LINEASCAN_KEY || '',
      xLayer: process.env.XLAYER_KEY || '',
      mainnet: process.env.ETHERSCAN_KEY || '',
      blastSepolia: process.env.BLAST_SEPOLIA_KEY || '',
      manta: '',
      era: process.env.ZKSYNC_KEY || '',
    },
    customChains: [
      {
        network: 'manta',
        chainId: 169,
        urls: {
          apiURL: 'https://pacific-explorer.manta.network/api',
          browserURL: 'https://pacific-explorer.manta.network',
        },
      },
      {
        network: 'linea',
        chainId: 59144,
        urls: {
          apiURL: 'https://api.lineascan.build/api',
          browserURL: 'https://lineascan.build',
        },
      },
      {
        network: 'blast',
        chainId: 81457,
        urls: {
          apiURL: 'https://api.blastscan.io/api',
          browserURL: 'https://blastscan.io',
        },
      },
      {
        network: 'xLayer',
        chainId: 196,
        urls: {
          apiURL:
            'https://www.oklink.com/api/v5/explorer/contract/verify-source-code-plugin/XLAYER',
          browserURL: 'https://www.oklink.com/xlayer', //or https://www.oklink.com/xlayer for mainnet
        },
      },
      {
        network: 'blastSepolia',
        chainId: 168587773,
        urls: {
          apiURL: 'https://api-sepolia.blastscan.io/api',
          browserURL: 'https://sepolia.blastscan.io/',
        },
      },
    ],
  },
};

export default config;
