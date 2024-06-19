// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.8.19;

interface INFTPositionManager {
  struct MintParams {
    address market;
    address recipient;
    address pool;
    uint256 amount;
  }

  struct Pair {
    address market;
    uint256 balance;
  }

  struct Position {
    Pair[] supplyMarkets;
    Pair[] debtMarkets;
    address pool;
    address operator;
  }

  struct AddLiquidityParams {
    uint256 tokenId;
    address market;
    address recipient;
    uint256 amount;
  }

  struct BorrowParams {
    uint256 tokenId;
    address market;
    uint256 amount;
  }

  struct RepayParams {
    uint256 tokenId;
    address market;
    uint256 amount;
  }

  struct WithdrawParams {
    uint256 tokenId;
    address market;
    address recipient;
    uint256 amount;
  }
}
