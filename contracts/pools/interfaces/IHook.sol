// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

interface IHook {
  function afterInitialize(address sender, address pool) external returns (bytes4);

  function beforeSupply(
    address sender,
    bytes32 position,
    address asset,
    address pool,
    uint256 amount,
    bytes calldata hookData
  ) external;

  function afterSupply(
    address sender,
    bytes32 position,
    address asset,
    address pool,
    uint256 amount,
    bytes calldata hookData
  ) external;

  function beforeWithdraw(
    address sender,
    bytes32 position,
    address asset,
    address pool,
    uint256 amount,
    bytes calldata hookData
  ) external;

  function afterWithdraw(
    address sender,
    bytes32 position,
    address asset,
    address pool,
    uint256 amount,
    bytes calldata hookData
  ) external;

  function beforeRepay(
    address sender,
    bytes32 position,
    address asset,
    address pool,
    uint256 amount,
    bytes calldata hookData
  ) external;

  function afterRepay(
    address sender,
    bytes32 position,
    address asset,
    address pool,
    uint256 amount,
    bytes calldata hookData
  ) external;

  function beforeBorrow(
    address sender,
    bytes32 position,
    address asset,
    address pool,
    uint256 amount,
    bytes calldata hookData
  ) external;

  function afterBorrow(
    address sender,
    bytes32 position,
    address asset,
    address pool,
    uint256 amount,
    bytes calldata hookData
  ) external;

  function beforeLiquidate(
    address liquidator,
    bytes32 position,
    address collateralAsset,
    address debtAsset,
    uint256 debtToCover,
    address pool,
    bytes calldata hookData
  ) external;

  function afterLiquidate(
    address liquidator,
    bytes32 position,
    address collateralAsset,
    address debtAsset,
    uint256 debtToCover,
    address pool,
    bytes calldata hookData
  ) external;
}
