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

/**
 * @title PoolErrorsLib
 * @notice Defines the errors for a ZeroLend Pool.
 */
library PoolErrorsLib {
  string public constant CALLER_NOT_POOL_ADMIN = 'CALLER_NOT_POOL_ADMIN'; // 'The caller of the function is not a pool admin'
  string public constant CALLER_NOT_EMERGENCY_ADMIN = 'CALLER_NOT_EMERGENCY_ADMIN'; // 'The caller of the function is not an emergency
  // admin'
  string public constant CALLER_NOT_POOL_OR_EMERGENCY_ADMIN = 'CALLER_NOT_POOL_OR_EMERGENCY_ADMIN'; // 'The caller of the function is not a
  // pool or emergency admin'
  string public constant CALLER_NOT_RISK_OR_POOL_ADMIN = 'CALLER_NOT_RISK_OR_POOL_ADMIN'; // 'The caller of the function is not a risk or
  // pool admin'
  string public constant CALLER_NOT_ASSET_LISTING_OR_POOL_ADMIN = 'CALLER_NOT_ASSET_LISTING_OR_POOL_ADMIN'; // 'The caller of the function
  // is not an asset listing or pool admin'
  string public constant CALLER_NOT_BRIDGE = 'CALLER_NOT_BRIDGE'; // 'The caller of the function is not a bridge'
  string public constant ADDRESSES_PROVIDER_NOT_REGISTERED = 'ADDRESSES_PROVIDER_NOT_REGISTERED'; // 'Pool addresses provider is not
  // registered'
  string public constant INVALID_ADDRESSES_PROVIDER_ID = 'INVALID_ADDRESSES_PROVIDER_ID'; // 'Invalid id for the pool addresses provider'
  string public constant NOT_CONTRACT = 'NOT_CONTRACT'; // 'Address is not a contract'
  string public constant CALLER_NOT_POOL_CONFIGURATOR = 'CALLER_NOT_POOL_CONFIGURATOR'; // 'The caller of the function is not the pool
  // configurator'
  string public constant CALLER_NOT_ATOKEN = 'CALLER_NOT_ATOKEN'; // 'The caller of the function is not an AToken'
  string public constant INVALID_ADDRESSES_PROVIDER = 'INVALID_ADDRESSES_PROVIDER'; // 'The address of the pool addresses provider is
  // invalid'
  string public constant INVALID_FLASHLOAN_EXECUTOR_RETURN = 'INVALID_FLASHLOAN_EXECUTOR_RETURN'; // 'Invalid return value of the flashloan
  // executor function'
  string public constant RESERVE_ALREADY_ADDED = 'RESERVE_ALREADY_ADDED'; // 'Reserve has already been added to reserve list'
  string public constant NO_MORE_RESERVES_ALLOWED = 'NO_MORE_RESERVES_ALLOWED'; // 'Maximum amount of reserves in the pool reached'
  string public constant RESERVE_LIQUIDITY_NOT_ZERO = 'RESERVE_LIQUIDITY_NOT_ZERO'; // 'The liquidity of the reserve needs to be 0'
  string public constant FLASHLOAN_PREMIUM_INVALID = 'FLASHLOAN_PREMIUM_INVALID'; // 'Invalid flashloan premium'
  string public constant INVALID_RESERVE_PARAMS = 'INVALID_RESERVE_PARAMS'; // 'Invalid risk parameters for the reserve'
  string public constant BRIDGE_PROTOCOL_FEE_INVALID = 'BRIDGE_PROTOCOL_FEE_INVALID'; // 'Invalid bridge protocol fee'
  string public constant CALLER_MUST_BE_POOL = 'CALLER_MUST_BE_POOL'; // 'The caller of this function must be a pool'
  string public constant INVALID_MINT_AMOUNT = 'INVALID_MINT_AMOUNT'; // 'Invalid amount to mint'
  string public constant INVALID_BURN_AMOUNT = 'INVALID_BURN_AMOUNT'; // 'Invalid amount to burn'
  string public constant INVALID_AMOUNT = 'INVALID_AMOUNT'; // 'Amount must be greater than 0'
  string public constant RESERVE_INACTIVE = 'RESERVE_INACTIVE'; // 'Action requires an active reserve'
  string public constant RESERVE_FROZEN = 'RESERVE_FROZEN'; // 'Action cannot be performed because the reserve is frozen'
  string public constant RESERVE_PAUSED = 'RESERVE_PAUSED'; // 'Action cannot be performed because the reserve is paused'
  string public constant BORROWING_NOT_ENABLED = 'BORROWING_NOT_ENABLED'; // 'Borrowing is not enabled'
  string public constant STABLE_BORROWING_NOT_ENABLED = 'STABLE_BORROWING_NOT_ENABLED'; // 'Stable borrowing is not enabled'
  string public constant NOT_ENOUGH_AVAILABLE_USER_BALANCE = 'NOT_ENOUGH_AVAILABLE_USER_BALANCE'; // 'User cannot withdraw more than the
  // available balance'
  string public constant INVALID_INTEREST_RATE_MODE_SELECTED = 'INVALID_INTEREST_RATE_MODE_SELECTED'; // 'Invalid interest rate mode
  // selected'
  string public constant COLLATERAL_BALANCE_IS_ZERO = 'COLLATERAL_BALANCE_IS_ZERO'; // 'The collateral balance is 0'
  string public constant HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD = 'HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD'; // 'Health
  // factor is lesser than the liquidation threshold'
  string public constant COLLATERAL_CANNOT_COVER_NEW_BORROW = 'COLLATERAL_CANNOT_COVER_NEW_BORROW'; // 'There is not enough collateral to
  // cover a new borrow'
  string public constant COLLATERAL_SAME_AS_BORROWING_CURRENCY = 'COLLATERAL_SAME_AS_BORROWING_CURRENCY'; // 'Collateral is (mostly) the
  // same currency that is being borrowed'
  string public constant AMOUNT_BIGGER_THAN_MAX_LOAN_SIZE_STABLE = 'AMOUNT_BIGGER_THAN_MAX_LOAN_SIZE_STABLE'; // 'The requested amount is
  // greater than the max loan size in stable rate mode'
  string public constant NO_DEBT_OF_SELECTED_TYPE = 'NO_DEBT_OF_SELECTED_TYPE'; // 'For repayment of a specific type of debt, the user needs
  // to have debt that type'
  string public constant NO_EXPLICIT_AMOUNT_TO_REPAY_ON_BEHALF = 'NO_EXPLICIT_AMOUNT_TO_REPAY_ON_BEHALF'; // 'To repay on behalf of a user
  // an explicit amount to repay is needed'
  string public constant NO_OUTSTANDING_STABLE_DEBT = 'NO_OUTSTANDING_STABLE_DEBT'; // 'User does not have outstanding stable rate debt on
  // this reserve'
  string public constant NO_OUTSTANDING_VARIABLE_DEBT = 'NO_OUTSTANDING_VARIABLE_DEBT'; // 'User does not have outstanding variable rate
  // debt on this reserve'
  string public constant UNDERLYING_BALANCE_ZERO = 'UNDERLYING_BALANCE_ZERO'; // 'The underlying balance needs to be greater than 0'
  string public constant INTEREST_RATE_REBALANCE_CONDITIONS_NOT_MET = 'INTEREST_RATE_REBALANCE_CONDITIONS_NOT_MET'; // 'Interest rate
  // rebalance conditions were not met'
  string public constant HEALTH_FACTOR_NOT_BELOW_THRESHOLD = 'HEALTH_FACTOR_NOT_BELOW_THRESHOLD'; // 'Health factor is not below the
  // threshold'
  string public constant COLLATERAL_CANNOT_BE_LIQUIDATED = 'COLLATERAL_CANNOT_BE_LIQUIDATED'; // 'The collateral chosen cannot be
  // liquidated'
  string public constant SPECIFIED_CURRENCY_NOT_BORROWED_BY_USER = 'SPECIFIED_CURRENCY_NOT_BORROWED_BY_USER'; // 'User did not borrow the
  // specified currency'
  string public constant INCONSISTENT_FLASHLOAN_PARAMS = 'INCONSISTENT_FLASHLOAN_PARAMS'; // 'Inconsistent flashloan parameters'
  string public constant BORROW_CAP_EXCEEDED = 'BORROW_CAP_EXCEEDED'; // 'Borrow cap is exceeded'
  string public constant SUPPLY_CAP_EXCEEDED = 'SUPPLY_CAP_EXCEEDED'; // 'Supply cap is exceeded'
  string public constant UNBACKED_MINT_CAP_EXCEEDED = 'UNBACKED_MINT_CAP_EXCEEDED'; // 'Unbacked mint cap is exceeded'
  string public constant DEBT_CEILING_EXCEEDED = 'DEBT_CEILING_EXCEEDED'; // 'Debt ceiling is exceeded'
  string public constant UNDERLYING_CLAIMABLE_RIGHTS_NOT_ZERO = 'UNDERLYING_CLAIMABLE_RIGHTS_NOT_ZERO'; // 'Claimable rights over underlying
  // not zero (aToken supply or accruedToTreasuryShares)'
  string public constant STABLE_DEBT_NOT_ZERO = 'STABLE_DEBT_NOT_ZERO'; // 'Stable debt supply is not zero'
  string public constant VARIABLE_DEBT_SUPPLY_NOT_ZERO = 'VARIABLE_DEBT_SUPPLY_NOT_ZERO'; // 'Variable debt supply is not zero'
  string public constant LTV_VALIDATION_FAILED = 'LTV_VALIDATION_FAILED'; // 'Ltv validation failed'
  string public constant INCONSISTENT_EMODE_CATEGORY = 'INCONSISTENT_EMODE_CATEGORY'; // 'Inconsistent eMode category'
  string public constant PRICE_ORACLE_SENTINEL_CHECK_FAILED = 'PRICE_ORACLE_SENTINEL_CHECK_FAILED'; // 'Price oracle sentinel validation
  // failed'
  string public constant RESERVE_ALREADY_INITIALIZED = 'RESERVE_ALREADY_INITIALIZED'; // 'Reserve has already been initialized'
  string public constant LTV_ZERO = 'LTV_ZERO'; // 'ltv is zero'
  string public constant INVALID_LTV = 'INVALID_LTV'; // 'Invalid ltv parameter for the reserve'
  string public constant INVALID_LIQ_THRESHOLD = 'INVALID_LIQ_THRESHOLD'; // 'Invalid liquidity threshold parameter for the reserve'
  string public constant INVALID_LIQ_BONUS = 'INVALID_LIQ_BONUS'; // 'Invalid liquidity bonus parameter for the reserve'
  string public constant INVALID_DECIMALS = 'INVALID_DECIMALS'; // 'Invalid decimals parameter of the underlying asset of the reserve'
  string public constant INVALID_RESERVE_FACTOR = 'INVALID_RESERVE_FACTOR'; // 'Invalid reserve factor parameter for the reserve'
  string public constant INVALID_BORROW_CAP = 'INVALID_BORROW_CAP'; // 'Invalid borrow cap for the reserve'
  string public constant INVALID_SUPPLY_CAP = 'INVALID_SUPPLY_CAP'; // 'Invalid supply cap for the reserve'
  string public constant INVALID_LIQUIDATION_PROTOCOL_FEE = 'INVALID_LIQUIDATION_PROTOCOL_FEE'; // 'Invalid liquidation protocol fee for the
  // reserve'
  string public constant INVALID_EMODE_CATEGORY = 'INVALID_EMODE_CATEGORY'; // 'Invalid eMode category for the reserve'
  string public constant INVALID_UNBACKED_MINT_CAP = 'INVALID_UNBACKED_MINT_CAP'; // 'Invalid unbacked mint cap for the reserve'
  string public constant INVALID_DEBT_CEILING = 'INVALID_DEBT_CEILING'; // 'Invalid debt ceiling for the reserve
  string public constant INVALID_RESERVE_INDEX = 'INVALID_RESERVE_INDEX'; // 'Invalid reserve index'
  string public constant ACL_ADMIN_CANNOT_BE_ZERO = 'ACL_ADMIN_CANNOT_BE_ZERO'; // 'ACL admin cannot be set to the zero address'
  string public constant INCONSISTENT_PARAMS_LENGTH = 'INCONSISTENT_PARAMS_LENGTH'; // 'Array parameters that should be equal length are
  // not'
  string public constant ZERO_ADDRESS_NOT_VALID = 'ZERO_ADDRESS_NOT_VALID'; // 'Zero address not valid'
  string public constant INVALID_EXPIRATION = 'INVALID_EXPIRATION'; // 'Invalid expiration'
  string public constant INVALID_SIGNATURE = 'INVALID_SIGNATURE'; // 'Invalid signature'
  string public constant OPERATION_NOT_SUPPORTED = 'OPERATION_NOT_SUPPORTED'; // 'Operation not supported'
  string public constant DEBT_CEILING_NOT_ZERO = 'DEBT_CEILING_NOT_ZERO'; // 'Debt ceiling is not zero'
  string public constant ASSET_NOT_LISTED = 'ASSET_NOT_LISTED'; // 'Asset is not listed'
  string public constant INVALID_OPTIMAL_USAGE_RATIO = 'INVALID_OPTIMAL_USAGE_RATIO'; // 'Invalid optimal usage ratio'
  string public constant INVALID_OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO = 'INVALID_OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO'; // 'Invalid optimal
  // stable to total debt ratio'
  string public constant UNDERLYING_CANNOT_BE_RESCUED = 'UNDERLYING_CANNOT_BE_RESCUED'; // 'The underlying asset cannot be rescued'
  string public constant ADDRESSES_PROVIDER_ALREADY_ADDED = 'ADDRESSES_PROVIDER_ALREADY_ADDED'; // 'Reserve has already been added to
  // reserve list'
  string public constant POOL_ADDRESSES_DO_NOT_MATCH = 'POOL_ADDRESSES_DO_NOT_MATCH'; // 'The token implementation pool address and the pool
  // address provided by the initializing pool do not match'
  string public constant STABLE_BORROWING_ENABLED = 'STABLE_BORROWING_ENABLED'; // 'Stable borrowing is enabled'
  string public constant SILOED_BORROWING_VIOLATION = 'SILOED_BORROWING_VIOLATION'; // 'User is trying to borrow multiple assets including a
  // siloed one'
  string public constant RESERVE_DEBT_NOT_ZERO = 'RESERVE_DEBT_NOT_ZERO'; // the total debt of the reserve needs to be 0
  string public constant FLASHLOAN_DISABLED = 'FLASHLOAN_DISABLED'; // FlashLoaning for this asset is disabled
}
