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

contract Safe {

  receive() external payable { }

  function withdraw() external {
    payable(msg.sender).transfer(address(this).balance);
  }

}

contract FuzzingExampleTest is Test {

  Safe safe;

  // Needed so the test contract itself can receive ether
  // when withdrawing
  receive() external payable { }

  function setUp() public {
    safe = new Safe();
  }

  function test_Withdraw() public {
    payable(address(safe)).transfer(1 ether);
    uint256 preBalance = address(this).balance;
    safe.withdraw();
    uint256 postBalance = address(this).balance;
    assertEq(preBalance + 1 ether, postBalance);
  }

  function testFuzz_Withdraw(uint96 amount) public {
    // vm.assume(amount < 0.1 ether);

    payable(address(safe)).transfer(amount);
    uint256 preBalance = address(this).balance;
    safe.withdraw();
    uint256 postBalance = address(this).balance;
    assertEq(preBalance + amount, postBalance);
  }

}
