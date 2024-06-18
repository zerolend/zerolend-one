// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.8.19;

interface INFTPositionManager {
  struct MintParams {
    address token;
    address recipient;
    address pool;
    uint256 amount;
  }

  struct Pair {
    address market;
    uint256 amount;
  }
  struct Position {
    Pair[] markets;
    Pair[] debts;
    address pool;
    address operator;
  }

  //   struct AddLiquidityParams {
  //     ;
  //   }
}
