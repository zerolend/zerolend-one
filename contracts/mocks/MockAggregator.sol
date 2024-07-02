// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

// ███████╗███████╗██████╗  ██████╗
// ╚══███╔╝██╔════╝██╔══██╗██╔═══██╗
//   ███╔╝ █████╗  ██████╔╝██║   ██║
//  ███╔╝  ██╔══╝  ██╔══██╗██║   ██║
// ███████╗███████╗██║  ██║╚██████╔╝
// ╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝
// Website: https://zerolend.xyz
// Discord: https://discord.gg/zerolend
// Twitter: https://twitter.com/zerolendxyz

contract MockAggregator {
  int256 public latestAnswer;

  constructor(int256 _answer) {
    latestAnswer = _answer;
  }

  function setAnswer(int256 _answer) external {
    latestAnswer = _answer;
  }

  function decimals() external pure returns (uint8) {
    return 8;
  }
}
