/**
 * Invariant tests for the core Pool contract
 */

methods {
	// Pool
    function getBalance(address asset, address who, uint256 index) external returns (uint256 ) envfree;
}


// Supplying an asset into the pool should increase the pool balance
// exactly with the amount supplied
rule supplyShouldIncreaseBalance(address asset, uint256 amount) {
	env e;
	mathint balanceBefore = getBalance(asset, e.msg.sender, 0);
    supply(e, asset, amount, 0);
    mathint balanceAfter = getBalance(asset, e.msg.sender, 0);
	assert balanceAfter == balanceBefore + amount;
}

// If we are able to withdraw an amount of asset from the protocol, then it is only possible if we have
// supplied at least the withdrawable amount into the same user position before.
rule withdrawShouldDecreaseFromSuppliedBalance(address asset, uint256 index1, uint256 index2, uint256 amountSupply, uint256 amountWithdraw) {
	env e1;
    env e2;

    supply(e1, asset, amountSupply, index1);
    withdraw@withrevert(e2, asset, amountWithdraw, index2);

    assert !lastReverted =>
        e1.msg.sender == e2.msg.sender &&
        amountSupply >= amountWithdraw &&
        index1 == index2;
}
