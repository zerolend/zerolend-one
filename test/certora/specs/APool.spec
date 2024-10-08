/*
    This is a Specification File for Smart Contract Verification with the Certora Prover.
    This file is run with scripts/verifyPool.sh
*/

/*
    Declaration of contracts used in the spec
*/
using ATokenHarness as _aToken;
// using StableDebtTokenHarness as _stable
// using VariableDebtToken as _variable
// using SimpleERC20 as _asset
// using SymbolicPriceOracle as priceOracle

/* Methods Summerizations and Enviroment-Free (e.g relative to e.msg variables) Declarations */

methods {
	// Pool
	function getReserveList(uint256 index) external   returns (address) envfree;
    function balanceOf(address) external returns (uint) envfree;
	function getReserveDataIndex(address token) external returns (uint256) envfree;
	function getReservesCount() external returns (uint256) envfree;
	function handleAction(address, uint256, uint256) external => NONDET;
	function getConfigurationData(address) external returns uint256 envfree;
	function getUserEMode(address) external returns uint256 envfree;
	function getAssetEMode(address) external returns uint256 envfree;
	function getAssetId(address) external returns uint16 envfree;
	function reserveAddressById(uint256) external returns address envfree;
	function isActiveReserve(address asset) external returns bool envfree;
	function isFrozenReserve(address asset) external returns bool envfree;
	function isPausedReserve(address asset) external returns bool envfree;
	function isBorrowableReserve(address) external returns bool envfree;
	function isStableRateBorrowableReserve(address) external returns bool envfree;
	function getReserveATokenAddress(address) external returns address envfree;
	function getReserveStableDebtTokenAddress(address) external returns address envfree;
	function getReserveVariableDebtTokenAddress(address) external returns address envfree;
	function getReserveLiquidityIndex(address) external returns uint256 envfree;
	function getReserveCurrentLiquidityRate(address) external returns uint256 envfree;
	function getReserveVariableBorrowIndex(address) external returns uint256 envfree;
	function getReserveCurrentVariableBorrowRate(address) external returns uint256 envfree;
	function getReserveCurrentStableBorrowRate(address) external returns uint256 envfree;
	function getATokenTotalSupply(address) external returns uint256 envfree;
	function getReserveSupplyCap(address) external returns uint256 envfree;
	function mockUserAccountData() external returns (uint256, uint256, uint256, uint256, uint256, bool) => NONDET;
	function mockHealthFactor() external returns (uint256, bool) => NONDET;
	function getAssetPrice(address) external returns uint256 => NONDET;
	function getPriceOracle() external returns address => ALWAYS(2);
	function getPriceOracleSentinel() external returns address => ALWAYS(4);
	function isBorrowAllowed() external returns bool => NONDET;

    // PoolHarness
    function getCurrScaledVariableDebt(address) external returns (uint256) envfree;

	// math
	function rayMul(uint256 a, uint256 b) external returns uint256 => rayMulSummariztion(a, b);
	function rayDiv(uint256 a, uint256 b) external returns uint256 => rayDivSummariztion(a, b);
	function calculateLinearInterest(uint256, uint40) external returns uint256 => ALWAYS(1000000000000000000000000000);  // this is not good dont use this;
	function calculateCompoundedInterest(uint256 x, uint40 t0, uint256 t1) external returns uint256 => calculateCompoundedInterestSummary(x, t0, t1);

	// ERC20
	function transfer(address, uint256) external returns bool => DISPATCHER(true);
	function transferFrom(address, address, uint256) external returns bool => DISPATCHER(true);
	function approve(address, uint256) external returns bool => DISPATCHER(true);
	function mint(address, uint256) external returns bool => DISPATCHER(true);
	function burn(uint256) external => DISPATCHER(true);
	function balanceOf(address) external returns uint256 => DISPATCHER(true);

	// ATOKEN
	function mint(address user, uint256 amount, uint256 index) external returns(bool) => DISPATCHER(true);
	function burn(address user, address receiverOfUnderlying, uint256 amount, uint256 index)  external =>  DISPATCHER(true);
	function mintToTreasury(uint256 amount, uint256 index) external => DISPATCHER(true);
	function transferOnLiquidation(address from, address to, uint256 value) external => DISPATCHER(true);
	function transferUnderlyingTo(address user, uint256 amount) external => DISPATCHER(true);
	function handleRepayment(address user, uint256 amount) external => DISPATCHER(true);
	function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external => DISPATCHER(true);

	//Debt Tokens
	// _variable.scaledTotalSupply() => DISPATCHER(true)

	// StableDebt
	function mint(address user, address onBehalfOf, uint256 amount, uint256 rate) external => DISPATCHER(true);
	function burn(address user, uint256 amount) external => DISPATCHER(true);
	function getSupplyData() external returns (uint256, uint256, uint256, uint40) => DISPATCHER(true);

	//variableDebt
	function  burn(address user, uint256 amount, uint256 index) external => DISPATCHER(true);

	// ReserveConfiguration
	function mockGetEModeCategory() external returns uint256 => CONSTANT;
	function mockGetActive() external returns bool => CONSTANT;
    function mockGetFrozen() external returns bool => CONSTANT;
    function mockGetBorrowingEnabled() external returns bool => CONSTANT;
    function mockGetStableRateBorrowingEnabled() external returns bool => CONSTANT;
    function mockGetPaused() external returns bool => CONSTANT;
	function mockGetReserveFactor() external returns uint256 => CONSTANT;
	function mockGetBorrowCap()   external returns uint256 => CONSTANT;
	function mockGetBorrowableInIsolation() external returns bool => CONSTANT;
	function mockGetLtv() external returns uint256 => CONSTANT;
	function mockGetSupplyCap() external returns uint256 => ALWAYS(100000000000000000000000000000000000000000000000000);
}

/* definitions and functions to be used within the spec file */

definition RAY()   returns uint256 = 10^27;
definition IS_UINT256(uint256 x)   returns bool = ((x >= 0) && (x <= max_uint256));

function first_term(uint256 x, uint256 y)   returns uint256 { return x; }
ghost mapping(uint256 => mapping(uint256 => uint256)) calculateCompoundedInterestSummaryValues;
function calculateCompoundedInterestSummary(uint256 rate, uint40 t0, uint256 t1)   returns uint256
{
	uint256 deltaT = t1 - t0;
	if (deltaT == 0)
	{
		return RAY();
	}
	if (rate == RAY())
	{
		return RAY();
	}
	if (rate >= RAY())
	{
		require calculateCompoundedInterestSummaryValues[rate][deltaT] >= rate;
	}
	else{
		require calculateCompoundedInterestSummaryValues[rate][deltaT] < rate;
	}
	return calculateCompoundedInterestSummaryValues[rate][deltaT];
}

ghost mapping(uint256 => mapping(uint256 => uint256)) rayMulSummariztionValues;
ghost mapping(uint256 => mapping(uint256 => uint256)) rayDivSummariztionValues;

function rayMulSummariztion(uint256 x, uint256 y)   returns uint256
{
	if (x == 0 || y == 0)
	{
		return 0;
	}
	if (x == RAY())
	{
		return y;
	}
	if (y == RAY())
	{
		return x;
	}

	if (y > x)
	{
		if (y > RAY())
		{
			require rayMulSummariztionValues[y][x] >= x;
		}
		if (x > RAY())
		{
			require rayMulSummariztionValues[y][x] >= y;
		}
		return rayMulSummariztionValues[y][x];
	}
	else{
		if (x > RAY())
		{
			require rayMulSummariztionValues[x][y] >= y;
		}
		if (y > RAY())
		{
			require rayMulSummariztionValues[x][y] >= x;
		}
		return rayMulSummariztionValues[x][y];
	}
}

function rayDivSummariztion(uint256 x, uint256 y)   returns uint256
{
	if (x == 0)
	{
		return 0;
	}
	if (y == RAY())
	{
		return x;
	}
	if (y == x)
	{
		return RAY();
	}
	require y > RAY() => rayDivSummariztionValues[x][y] <= x;
	require y < RAY() => x <= rayDivSummariztionValues[x][y];
	return rayDivSummariztionValues[x][y];
}

// The borrowing index should monotonically increasing
rule getReserveNormalizedVariableDebtCheck()
{
	env e1;
	calldataarg args;
	calldataarg args2;
      address asset; uint256 amount; address onBehalfOf; uint16 referralCode;
    require asset != _aToken;
	uint256 oldIndex = getReserveNormalizedVariableDebt(e1, args);
    uint256 totalDebtBefore = getCurrScaledVariableDebt(asset);
	supply(e1, asset, amount, onBehalfOf, referralCode);
	uint256 newIndex = getReserveNormalizedVariableDebt(e1, args);
	assert totalDebtBefore != 0 => newIndex >= oldIndex;
}

// withdrawing a sum (part1 + part2) should not revert if withdrawing the two parts seperately does not revert
// !!! Times out !!!
// rule withdrawCheck()
// {
// 	env e;
// 	address to;
// 	address asset;
// 	uint256 part1;
// 	uint256 part2;
// 	storage init = lastStorage;
// 	withdraw(e, asset, part1, to);
// 	withdraw(e, asset, part2, to);
// 	withdraw@withrevert(e, asset, part1 + part2, to) at init;
// 	assert !lastReverted;
// }

// The liquidity index should not give different result if we called mintToTreasury before a function (flashloan);
// !!! Times out !!!
// rule accruToTreasury()
// {
// 	env e;
// 	calldataarg args;
// 	calldataarg args2;
// 	calldataarg args3;
// 	storage init = lastStorage;
// 	mintToTreasury(e, args);
// 	flashLoan(e, args2);
// 	//mintToTreasury(e, args);
// 	uint256 withMintBefore = getReserveNormalizedIncome(e, args3);
// 	flashLoan(e, args2) at init;
// 	//mintToTreasury(e, args);
// 	uint256 withoutMintBefore = getReserveNormalizedIncome(e, args3);
// 	assert withoutMintBefore == withMintBefore;
// }
