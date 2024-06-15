import { HardhatUserConfig } from 'hardhat/config';
import '@nomicfoundation/hardhat-toolbox-viem';
import 'hardhat-dependency-compiler';
import 'solidity-docgen';
import 'solidity-coverage';

import dotenv from 'dotenv';
dotenv.config();

const config: HardhatUserConfig = {
  solidity: '0.8.19',
  docgen: {
    pages: 'files',
  },
};

export default config;
