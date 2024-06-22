/**
 * Invariant tests for the core Pool contract regarding supplies and withdrawals.
 */

methods {
    function getBalance(address asset, address who, uint256 index) external returns (uint256) envfree;
    function getReserveData(address asset) external returns (DataTypes.ReserveData) envfree;
}

definition RAY() returns uint128 = 10^27;

// Supplying an asset into the pool should increase the pool balance
// exactly with the amount supplied
rule supplyShouldIncreaseBalance(address asset, uint256 amount) {
	env e;

    // ensure liquidity index is initialized at least 1 ray
    DataTypes.ReserveData d = getReserveData(asset);
    require d.liquidityIndex == RAY();
    require d.variableBorrowIndex == RAY();

    // fetch balance before supply
	mathint balanceBefore = getBalance(asset, e.msg.sender, 0);

    supply(e, asset, amount, 0);

    // ensure balance after is exactly the difference
    mathint balanceAfter = getBalance(asset, e.msg.sender, 0);
	assert balanceAfter == balanceBefore + amount;
}

// If we are able to withdraw an amount of asset from the protocol, then it is only possible if we have
// supplied at least the withdrawable amount into the same user position before.
rule withdrawShouldExecuteAfterValidSupply(address asset, uint256 index1, uint256 index2, uint256 amountSupply, uint256 amountWithdraw) {
	env e1;
    env e2;

    // ensure liquidity index is initialized at least 1 ray
    DataTypes.ReserveData d = getReserveData(asset);
    require d.liquidityIndex == RAY();
    require d.variableBorrowIndex == RAY();

    // random supply
    supply(e1, asset, amountSupply, index1);

    // random withdraw (which might revert)
    withdraw@withrevert(e2, asset, amountWithdraw, index2);

    // if the withdraw did not revert; then it means we had supplied
    // at least `amountWithdraw` worth of assets into the same position before.
    assert !lastReverted =>
        e1.msg.sender == e2.msg.sender &&
        amountSupply >= amountWithdraw &&
        index1 == index2;
}

// This is a check on the getBalance property to ensure that a withdrawal does execute properly if there is enough
// balance in the contract
rule withdrawShouldExecuteWithValidBalance(address asset, uint256 index, uint256 amountWithdraw) {
	env e;

    // random supply
    mathint balanceBefore = getBalance(asset, e.msg.sender, index);

    // random withdraw (which might revert)
    withdraw@withrevert(e, asset, amountWithdraw, index);

    // if the withdraw did not revert; then it means we had supplied
    // at least `amountWithdraw` worth of assets into the same position before.
    assert !lastReverted => assert_uint256(balanceBefore) >= amountWithdraw;
}

// This is a check to ensure that the balance decreases properly if a user executes a withdraw
rule withdrawShouldReduceBalanceProperly(address asset, uint256 amountWithdraw) {
	env e;

    // ensure liquidity index is initialized at least 1 ray
    DataTypes.ReserveData d = getReserveData(asset);
    require d.liquidityIndex == RAY();
    require d.variableBorrowIndex == RAY();

    // check if the user has enough balance
    mathint balanceBefore = getBalance(asset, e.msg.sender, 0);
    require amountWithdraw <= assert_uint256(balanceBefore);

    withdraw@withrevert(e, asset, amountWithdraw, 0);

    // check the balance after
    mathint balanceAfter = getBalance(asset, e.msg.sender, 0);

    // the difference needs to be exact
    assert balanceAfter == balanceBefore - amountWithdraw;
}