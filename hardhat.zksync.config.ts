// @ts-ignore
import { accounts } from './test-wallets.js';
import { COVERAGE_CHAINID, HARDHAT_CHAINID } from './helpers/constants.js';
import { buildForkConfig } from './helper-hardhat-config.js';

require('dotenv').config();

import '@nomicfoundation/hardhat-toolbox';
import 'hardhat-deploy';
import '@tenderly/hardhat-tenderly';
import 'hardhat-contract-sizer';
import 'hardhat-dependency-compiler';
import '@nomicfoundation/hardhat-chai-matchers';

import '@matterlabs/hardhat-zksync-deploy';
import '@matterlabs/hardhat-zksync-solc';

import { DEFAULT_NAMED_ACCOUNTS } from '@aave/deploy-v3';

const DEFAULT_BLOCK_GAS_LIMIT = 12450000;
const HARDFORK = 'london';

const hardhatConfig = {
  gasReporter: {
    enabled: true,
  },
  contractSizer: {
    alphaSort: true,
    runOnCompile: false,
    disambiguatePaths: false,
  },
  solidity: {
    // Docs for the compiler https://docs.soliditylang.org/en/v0.8.10/using-the-compiler.html
    version: '0.8.12',
    settings: {
      optimizer: {
        enabled: true,
        runs: 100000,
      },
      // evmVersion: 'london',
    },
  },
  zksolc: {
    version: '1.3.13',
    settings: {
      libraries: {
        'contracts/protocol/libraries/logic/BridgeLogic.sol': {
          BridgeLogic: '0x6CDe8a8cEE9771A30dE4fEAB8eaccb58cb0d30aF',
        },
        'contracts/protocol/libraries/logic/ConfiguratorLogic.sol': {
          ConfiguratorLogic: '0x8731d4E5b990025143609F4A40eC80Fb482E46A0',
        },
        'contracts/protocol/libraries/logic/PoolLogic.sol': {
          PoolLogic: '0xA8D16FB0620E3376093cb89e2cD9dEF9fE47Daaa',
        },
        'contracts/protocol/libraries/logic/EModeLogic.sol': {
          EModeLogic: '0xD84E953a621bb9D81Dc998E0b1482D2916153c23',
        },
        'contracts/protocol/libraries/logic/LiquidationLogic.sol': {
          LiquidationLogic: '0x1962271C81e9734dC201312350a1D19351B7C4Ac',
        },
        'contracts/protocol/libraries/logic/SupplyLogic.sol': {
          SupplyLogic: '0x9223dC9205Cf8336CA59bA0bD390647E62D487E5',
        },
        'contracts/protocol/libraries/logic/FlashLoanLogic.sol': {
          FlashLoanLogic: '0xBD93e7f228d56ACd10182D1C92283809e8521633',
        },
        'contracts/protocol/libraries/logic/BorrowLogic.sol': {
          BorrowLogic: '0x81D6b98Beb0A4288dCFab724FDeaE52E5Aa2F7b1',
        },
      },
    },
  },
  typechain: {
    outDir: 'types',
    target: 'ethers-v5',
  },
  mocha: {
    timeout: 0,
    bail: true,
  },
  tenderly: {
    project: process.env.TENDERLY_PROJECT || '',
    username: process.env.TENDERLY_USERNAME || '',
    forkNetwork: '1', //Network id of the network we want to fork
  },
  networks: {
    zkSyncTestnet: {
      url: 'https://testnet.era.zksync.dev',
      ethNetwork: 'goerli', // or a Goerli RPC endpoint from Infura/Alchemy/Chainstack etc.
      zksync: true,
    },
    coverage: {
      url: 'http://localhost:8555',
      chainId: COVERAGE_CHAINID,
      throwOnTransactionFailures: true,
      throwOnCallFailures: true,
      zksync: false,
    },
    hardhat: {
      hardfork: HARDFORK,
      blockGasLimit: DEFAULT_BLOCK_GAS_LIMIT,
      gas: DEFAULT_BLOCK_GAS_LIMIT,
      gasPrice: 8000000000,
      zksync: false,
      chainId: HARDHAT_CHAINID,
      throwOnTransactionFailures: true,
      throwOnCallFailures: true,
      forking: buildForkConfig(),
      allowUnlimitedContractSize: true,
      accounts: accounts.map(({ secretKey, balance }: { secretKey: string; balance: string }) => ({
        privateKey: secretKey,
        balance,
      })),
    },
    ganache: {
      url: 'http://ganache:8545',
      accounts: {
        mnemonic: 'fox sight canyon orphan hotel grow hedgehog build bless august weather swarm',
        path: "m/44'/60'/0'/0",
        initialIndex: 0,
        count: 20,
      },
      zksync: false,
    },
  },
  defaultNetwork: 'zkSyncTestnet',
  namedAccounts: {
    ...DEFAULT_NAMED_ACCOUNTS,
  },
  external: {
    // contracts: [
    //   {
    //     artifacts: './temp-artifacts',
    //     deploy: 'node_modules/@aave/deploy-v3/dist/deploy',
    //   },
    // ],
  },
};

export default hardhatConfig;
