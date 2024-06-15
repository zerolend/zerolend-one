// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {IPool} from '../../../interfaces/IPool.sol';
import {IInitializableAToken} from '../../../interfaces/IInitializableAToken.sol';
import {IInitializableDebtToken} from '../../../interfaces/IInitializableDebtToken.sol';
import {ReserveConfiguration} from '../configuration/ReserveConfiguration.sol';
import {DataTypes} from '../types/DataTypes.sol';
import {ConfiguratorInputTypes} from '../types/ConfiguratorInputTypes.sol';

/**
 * @title ConfiguratorLogic library
 * @author Aave
 * @notice Implements the functions to initialize reserves and update aTokens and debtTokens
 */
library ConfiguratorLogic {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  // See `IPoolConfigurator` for descriptions
  event ReserveInitialized(address indexed asset, address interestRateStrategyAddress);
  event ATokenUpgraded(
    address indexed asset,
    address indexed proxy,
    address indexed implementation
  );
  event VariableDebtTokenUpgraded(
    address indexed asset,
    address indexed proxy,
    address indexed implementation
  );

  /**
   * @notice Initialize a reserve by creating and initializing aToken, stable debt token and variable debt token
   * @dev Emits the `ReserveInitialized` event
   * @param pool The Pool in which the reserve will be initialized
   * @param input The needed parameters for the initialization
   */
  function executeInitReserve(
    IPool pool,
    ConfiguratorInputTypes.InitReserveInput calldata input
  ) public {
    pool.initReserve(input.underlyingAsset, input.interestRateStrategyAddress);

    DataTypes.ReserveConfigurationMap memory currentConfig = DataTypes.ReserveConfigurationMap(0);

    currentConfig.setDecimals(input.underlyingAssetDecimals);
    currentConfig.setFrozen(false);

    pool.setConfiguration(input.underlyingAsset, currentConfig);

    emit ReserveInitialized(input.underlyingAsset, input.interestRateStrategyAddress);
  }
}
