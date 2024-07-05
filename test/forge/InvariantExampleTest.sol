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

import '../../lib/forge-std/src/Test.sol';

contract ExampleContract1 {
  uint256 public val1;
  uint256 public val2;
  uint256 public val3;

  function addToA(uint256 amount) external {
    val1 += amount;
    val3 += amount;
  }

  function addToB(uint256 amount) external {
    val2 += amount;
    val3 += amount;
  }
}

contract InvariantExampleTest is Test {
  ExampleContract1 foo;

  function setUp() external {
    foo = new ExampleContract1();
  }

  function invariant_A() external view {
    assertEq(foo.val1() + foo.val2(), foo.val3());
  }

  function invariant_B() external view {
    assertGe(foo.val1() + foo.val2(), foo.val3());
  }
}
