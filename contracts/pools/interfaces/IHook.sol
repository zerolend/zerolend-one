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

  function beforeLiquidate(
    address liquidator,
    address user,
    bytes32 position,
    address collateralAsset,
    address debtAsset,
    uint256 debtToCover,
    address pool,
    bytes calldata hookData
  ) external;

  function afterLiquidate(
    address liquidator,
    address user,
    bytes32 position,
    address collateralAsset,
    address debtAsset,
    uint256 debtToCover,
    address pool,
    bytes calldata hookData
  ) external;
}
