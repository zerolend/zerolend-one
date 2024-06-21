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
// Telegram: https://t.me/zerolendxyz

import {ERC20} from '@openzeppelin/contracts/token/ERC20/ERC20.sol';

abstract contract WETH9Mocked is ERC20 {
  // // Mint not backed by Ether: only for testing purposes
  // function mint(uint256 value) public returns (bool) {
  //   balanceOf[msg.sender] += value;
  //   emit Transfer(address(0), msg.sender, value);
  //   return true;
  // }
  // function mint(address account, uint256 value) public returns (bool) {
  //   balanceOf[account] += value;
  //   emit Transfer(address(0), account, value);
  //   return true;
  // }
}
