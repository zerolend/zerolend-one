pragma solidity 0.8.10;

import 'forge-std/src/Test.sol';

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

  function invariant_A() external {
    assertEq(foo.val1() + foo.val2(), foo.val3());
  }

  function invariant_B() external {
    assertGe(foo.val1() + foo.val2(), foo.val3());
  }
}
