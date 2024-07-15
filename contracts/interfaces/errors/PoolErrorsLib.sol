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
  string public constant ACL_ADMIN_CANNOT_BE_ZERO = 'ACL_ADMIN_CANNOT_BE_ZERO';
  string public constant ADDRESSES_PROVIDER_ALREADY_ADDED = 'ADDRESSES_PROVIDER_ALREADY_ADDED';
  string public constant ADDRESSES_PROVIDER_NOT_REGISTERED = 'ADDRESSES_PROVIDER_NOT_REGISTERED';
  string public constant AMOUNT_BIGGER_THAN_MAX_LOAN_SIZE_STABLE = 'AMOUNT_BIGGER_THAN_MAX_LOAN_SIZE_STABLE';
  string public constant ASSET_NOT_LISTED = 'ASSET_NOT_LISTED';
  string public constant BORROW_CAP_EXCEEDED = 'BORROW_CAP_EXCEEDED';
  string public constant BORROWING_NOT_ENABLED = 'BORROWING_NOT_ENABLED';
  string public constant BRIDGE_PROTOCOL_FEE_INVALID = 'BRIDGE_PROTOCOL_FEE_INVALID';
  string public constant CALLER_MUST_BE_POOL = 'CALLER_MUST_BE_POOL';
  string public constant CALLER_NOT_ASSET_LISTING_OR_POOL_ADMIN = 'CALLER_NOT_ASSET_LISTING_OR_POOL_ADMIN';
  string public constant CALLER_NOT_ATOKEN = 'CALLER_NOT_ATOKEN';
  string public constant CALLER_NOT_BRIDGE = 'CALLER_NOT_BRIDGE';
  string public constant CALLER_NOT_EMERGENCY_ADMIN = 'CALLER_NOT_EMERGENCY_ADMIN';
  string public constant CALLER_NOT_POOL_ADMIN = 'CALLER_NOT_POOL_ADMIN';
  string public constant CALLER_NOT_POOL_CONFIGURATOR = 'CALLER_NOT_POOL_CONFIGURATOR';
  string public constant CALLER_NOT_POOL_OR_EMERGENCY_ADMIN = 'CALLER_NOT_POOL_OR_EMERGENCY_ADMIN';
  string public constant CALLER_NOT_RISK_OR_POOL_ADMIN = 'CALLER_NOT_RISK_OR_POOL_ADMIN';
  string public constant COLLATERAL_BALANCE_IS_ZERO = 'COLLATERAL_BALANCE_IS_ZERO';
  string public constant COLLATERAL_CANNOT_BE_LIQUIDATED = 'COLLATERAL_CANNOT_BE_LIQUIDATED';
  string public constant COLLATERAL_CANNOT_COVER_NEW_BORROW = 'COLLATERAL_CANNOT_COVER_NEW_BORROW';
  string public constant COLLATERAL_SAME_AS_BORROWING_CURRENCY = 'COLLATERAL_SAME_AS_BORROWING_CURRENCY';
  string public constant DEBT_CEILING_EXCEEDED = 'DEBT_CEILING_EXCEEDED';
  string public constant DEBT_CEILING_NOT_ZERO = 'DEBT_CEILING_NOT_ZERO';
  string public constant FLASHLOAN_DISABLED = 'FLASHLOAN_DISABLED';
  string public constant FLASHLOAN_PREMIUM_INVALID = 'FLASHLOAN_PREMIUM_INVALID';
  string public constant HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD = 'HEALTH_FACTOR_LOWER_THAN_LIQUIDATION_THRESHOLD';
  string public constant HEALTH_FACTOR_NOT_BELOW_THRESHOLD = 'HEALTH_FACTOR_NOT_BELOW_THRESHOLD';
  string public constant INCONSISTENT_EMODE_CATEGORY = 'INCONSISTENT_EMODE_CATEGORY';
  string public constant INCONSISTENT_FLASHLOAN_PARAMS = 'INCONSISTENT_FLASHLOAN_PARAMS';
  string public constant INCONSISTENT_PARAMS_LENGTH = 'INCONSISTENT_PARAMS_LENGTH';
  string public constant INTEREST_RATE_REBALANCE_CONDITIONS_NOT_MET = 'INTEREST_RATE_REBALANCE_CONDITIONS_NOT_MET';
  string public constant INVALID_ADDRESSES_PROVIDER = 'INVALID_ADDRESSES_PROVIDER';
  string public constant INVALID_ADDRESSES_PROVIDER_ID = 'INVALID_ADDRESSES_PROVIDER_ID';
  string public constant INVALID_AMOUNT = 'INVALID_AMOUNT';
  string public constant INVALID_BORROW_CAP = 'INVALID_BORROW_CAP';
  string public constant INVALID_BURN_AMOUNT = 'INVALID_BURN_AMOUNT';
  string public constant INVALID_DEBT_CEILING = 'INVALID_DEBT_CEILING';
  string public constant INVALID_DECIMALS = 'INVALID_DECIMALS';
  string public constant INVALID_EMODE_CATEGORY = 'INVALID_EMODE_CATEGORY';
  string public constant INVALID_EXPIRATION = 'INVALID_EXPIRATION';
  string public constant INVALID_FLASHLOAN_EXECUTOR_RETURN = 'INVALID_FLASHLOAN_EXECUTOR_RETURN';
  string public constant INVALID_INTEREST_RATE_MODE_SELECTED = 'INVALID_INTEREST_RATE_MODE_SELECTED';
  string public constant INVALID_LIQ_BONUS = 'INVALID_LIQ_BONUS';
  string public constant INVALID_LIQ_THRESHOLD = 'INVALID_LIQ_THRESHOLD';
  string public constant INVALID_LIQUIDATION_PROTOCOL_FEE = 'INVALID_LIQUIDATION_PROTOCOL_FEE';
  string public constant INVALID_LTV = 'INVALID_LTV';
  string public constant INVALID_MINT_AMOUNT = 'INVALID_MINT_AMOUNT';
  string public constant INVALID_OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO = 'INVALID_OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO';
  string public constant INVALID_OPTIMAL_USAGE_RATIO = 'INVALID_OPTIMAL_USAGE_RATIO';
  string public constant INVALID_RESERVE_FACTOR = 'INVALID_RESERVE_FACTOR';
  string public constant INVALID_RESERVE_INDEX = 'INVALID_RESERVE_INDEX';
  string public constant INVALID_RESERVE_PARAMS = 'INVALID_RESERVE_PARAMS';
  string public constant INVALID_SIGNATURE = 'INVALID_SIGNATURE';
  string public constant INVALID_SUPPLY_CAP = 'INVALID_SUPPLY_CAP';
  string public constant INVALID_UNBACKED_MINT_CAP = 'INVALID_UNBACKED_MINT_CAP';
  string public constant LTV_VALIDATION_FAILED = 'LTV_VALIDATION_FAILED';
  string public constant LTV_ZERO = 'LTV_ZERO';
  string public constant NO_DEBT_OF_SELECTED_TYPE = 'NO_DEBT_OF_SELECTED_TYPE';
  string public constant NO_EXPLICIT_AMOUNT_TO_REPAY_ON_BEHALF = 'NO_EXPLICIT_AMOUNT_TO_REPAY_ON_BEHALF';
  string public constant NO_MORE_RESERVES_ALLOWED = 'NO_MORE_RESERVES_ALLOWED';
  string public constant NO_OUTSTANDING_STABLE_DEBT = 'NO_OUTSTANDING_STABLE_DEBT';
  string public constant NO_OUTSTANDING_VARIABLE_DEBT = 'NO_OUTSTANDING_VARIABLE_DEBT';
  string public constant NOT_CONTRACT = 'NOT_CONTRACT';
  string public constant NOT_ENOUGH_AVAILABLE_USER_BALANCE = 'NOT_ENOUGH_AVAILABLE_USER_BALANCE';
  string public constant OPERATION_NOT_SUPPORTED = 'OPERATION_NOT_SUPPORTED';
  string public constant POOL_ADDRESSES_DO_NOT_MATCH = 'POOL_ADDRESSES_DO_NOT_MATCH';
  string public constant PRICE_ORACLE_SENTINEL_CHECK_FAILED = 'PRICE_ORACLE_SENTINEL_CHECK_FAILED';
  string public constant RESERVE_ALREADY_ADDED = 'RESERVE_ALREADY_ADDED';
  string public constant RESERVE_ALREADY_INITIALIZED = 'RESERVE_ALREADY_INITIALIZED';
  string public constant RESERVE_DEBT_NOT_ZERO = 'RESERVE_DEBT_NOT_ZERO';
  string public constant RESERVE_FROZEN = 'RESERVE_FROZEN';
  string public constant RESERVE_INACTIVE = 'RESERVE_INACTIVE';
  string public constant RESERVE_LIQUIDITY_NOT_ZERO = 'RESERVE_LIQUIDITY_NOT_ZERO';
  string public constant RESERVE_PAUSED = 'RESERVE_PAUSED';
  string public constant SILOED_BORROWING_VIOLATION = 'SILOED_BORROWING_VIOLATION';
  string public constant SPECIFIED_CURRENCY_NOT_BORROWED_BY_USER = 'SPECIFIED_CURRENCY_NOT_BORROWED_BY_USER';
  string public constant STABLE_BORROWING_ENABLED = 'STABLE_BORROWING_ENABLED';
  string public constant STABLE_BORROWING_NOT_ENABLED = 'STABLE_BORROWING_NOT_ENABLED';
  string public constant STABLE_DEBT_NOT_ZERO = 'STABLE_DEBT_NOT_ZERO';
  string public constant SUPPLY_CAP_EXCEEDED = 'SUPPLY_CAP_EXCEEDED';
  string public constant UNBACKED_MINT_CAP_EXCEEDED = 'UNBACKED_MINT_CAP_EXCEEDED';
  string public constant UNDERLYING_BALANCE_ZERO = 'UNDERLYING_BALANCE_ZERO';
  string public constant UNDERLYING_CANNOT_BE_RESCUED = 'UNDERLYING_CANNOT_BE_RESCUED';
  string public constant UNDERLYING_CLAIMABLE_RIGHTS_NOT_ZERO = 'UNDERLYING_CLAIMABLE_RIGHTS_NOT_ZERO';
  string public constant VARIABLE_DEBT_SUPPLY_NOT_ZERO = 'VARIABLE_DEBT_SUPPLY_NOT_ZERO';
  string public constant ZERO_ADDRESS_NOT_VALID = 'ZERO_ADDRESS_NOT_VALID';
}
