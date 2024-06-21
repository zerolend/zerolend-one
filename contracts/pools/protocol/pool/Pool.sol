// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {BorrowLogic} from '../libraries/logic/BorrowLogic.sol';
import {DataTypes} from '../libraries/types/DataTypes.sol';
import {Errors} from '../libraries/helpers/Errors.sol';
import {IAggregatorInterface} from '../../interfaces/IAggregatorInterface.sol';
import {FlashLoanLogic} from '../libraries/logic/FlashLoanLogic.sol';
import {Initializable} from '@openzeppelin/contracts/proxy/utils/Initializable.sol';
import {IPool} from '../../interfaces/IPool.sol';
import {IFactory} from '../../interfaces/IFactory.sol';
import {LiquidationLogic} from '../libraries/logic/LiquidationLogic.sol';
import {PoolLogic} from '../libraries/logic/PoolLogic.sol';
import {ReserveConfiguration} from '../libraries/configuration/ReserveConfiguration.sol';
import {ReserveLogic} from '../libraries/logic/ReserveLogic.sol';
import {SupplyLogic} from '../libraries/logic/SupplyLogic.sol';
import {TokenConfiguration} from '../libraries/configuration/TokenConfiguration.sol';

abstract contract Pool is Initializable, IPool {
  using ReserveLogic for DataTypes.ReserveData;
  using TokenConfiguration for address;

  /// @notice Map of reserves and their data (underlyingAssetOfReserve => reserveData)
  mapping(address asset => DataTypes.ReserveData data) internal _reserves;

  /// @notice Map of positions and their configuration data (userAddress => userConfiguration)
  mapping(bytes32 position => DataTypes.UserConfigurationMap config) internal _usersConfig;

  /// @notice Map of position's individual balances
  mapping(address asset => mapping(bytes32 position => uint256 balance)) internal _balances;

  /// @notice Map of position's individual debt positions
  mapping(address asset => mapping(bytes32 position => uint256 balance)) internal _debts;

  /// @notice Map of total supply of tokens
  mapping(address asset => uint256 totalSupply) internal _totalSupplies;

  /// @notice List of reserves as a map (reserveId => reserve).
  /// It is structured as a mapping for gas savings reasons, using the reserve id as index
  mapping(uint256 reserveId => address asset) internal _reservesList;

  /// @notice Total FlashLoan Premium, expressed in bps
  uint128 internal _flashLoanPremiumTotal;

  /// @notice Number of active reserves in the pool
  uint16 internal _reservesCount;

  /// @notice Map of asset price sources (asset => priceSource)
  mapping(address asset => IAggregatorInterface oracle) internal _assetsSources;

  /// @notice The pool configurator contract that can make changes
  address public configurator;

  /// @notice The original factory contract with protocol-level control variables
  IFactory public factory;

  /**
   * @notice Initializes the Pool.
   * @dev This function is invoked by the factory contract when the Pool is created
   */
  function initialize(IPool.InitParams memory params) public virtual reinitializer(1) {
    factory = IFactory(factory);
    configurator = params.configurator;

    for (uint i = 0; i < params.assets.length; i++) {
      _setReserveConfiguration(
        params.assets[i],
        params.rateStrategyAddresses[i],
        params.sources[i],
        params.configurations[i]
      );
      _reservesCount++;
      emit ReserveInitialized(params.assets[i], params.rateStrategyAddresses[i], params.sources[i]);
    }
  }

  /// @inheritdoc IPool
  function supply(address asset, uint256 amount, uint256 index) public virtual override {
    bytes32 positionId = msg.sender.getPositionId(index);
    SupplyLogic.executeSupply(
      msg.sender,
      _reserves,
      DataTypes.ExecuteSupplyParams({asset: asset, amount: amount, onBehalfOfPosition: positionId}),
      _balances,
      _totalSupplies
    );
  }

  /// @inheritdoc IPool
  function withdraw(
    address asset,
    uint256 amount,
    uint256 index
  ) public virtual override returns (uint256 withdrawalAmount) {
    bytes32 positionId = msg.sender.getPositionId(index);

    require(amount <= _balances[asset][positionId], 'Insufficient Balance!');
    withdrawalAmount = SupplyLogic.executeWithdraw(
      _reserves,
      _reservesList,
      _usersConfig[positionId],
      DataTypes.ExecuteWithdrawParams({
        user: msg.sender,
        asset: asset,
        amount: amount,
        position: positionId,
        reservesCount: _reservesCount,
        pool: address(this)
      }),
      _balances,
      _totalSupplies
    );
  }

  /// @inheritdoc IPool
  function borrow(address asset, uint256 amount, uint256 index) public virtual override {
    bytes32 positionId = msg.sender.getPositionId(index);
    BorrowLogic.executeBorrow(
      _reserves,
      _reservesList,
      _usersConfig[positionId],
      DataTypes.ExecuteBorrowParams({
        asset: asset,
        user: msg.sender,
        onBehalfOfPosition: positionId,
        amount: amount,
        reservesCount: _reservesCount,
        pool: address(this)
      }),
      _debts,
      _totalSupplies
    );
  }

  // @inheritdoc IPool
  function repay(
    address asset,
    uint256 amount,
    uint256 index
  ) public virtual returns (uint256 paybackAmount) {
    bytes32 positionId = msg.sender.getPositionId(index);
    paybackAmount = BorrowLogic.executeRepay(
      _reserves,
      DataTypes.ExecuteRepayParams({
        asset: asset,
        amount: amount,
        user: msg.sender,
        onBehalfOfPosition: positionId
      }),
      _debts,
      _totalSupplies
    );
  }

  /// @inheritdoc IPool
  function liquidate(
    address collateralAsset,
    address debtAsset,
    address user,
    uint256 debtToCover,
    uint256 index
  ) public virtual override {
    LiquidationLogic.executeLiquidationCall(
      _reserves,
      _reservesList,
      _balances,
      _debts,
      _usersConfig,
      DataTypes.ExecuteLiquidationCallParams({
        reservesCount: _reservesCount,
        debtToCover: debtToCover,
        collateralAsset: collateralAsset,
        debtAsset: debtAsset,
        position: user.getPositionId(index),
        pool: address(this)
      })
    );
  }

  /// @inheritdoc IPool
  function flashLoan(
    address receiverAddress,
    address asset,
    uint256 amount,
    bytes calldata params
  ) public virtual override {
    DataTypes.FlashloanSimpleParams memory flashParams = DataTypes.FlashloanSimpleParams({
      receiverAddress: receiverAddress,
      asset: asset,
      amount: amount,
      params: params,
      flashLoanPremiumToProtocol: factory.flashLoanPremiumToProtocol(),
      flashLoanPremiumTotal: _flashLoanPremiumTotal
    });
    FlashLoanLogic.executeFlashLoanSimple(_reserves[asset], flashParams);
  }

  /// @inheritdoc IPool
  function mintToTreasury(address[] calldata assets) external virtual override {
    PoolLogic.executeMintToTreasury(_reserves, assets);
  }

  /// @inheritdoc IPool
  function getReserveData(
    address asset
  ) external view virtual override returns (DataTypes.ReserveData memory) {
    return _reserves[asset];
  }

  /// @inheritdoc IPool
  function getUserAccountData(
    address user,
    uint256 index
  )
    external
    view
    virtual
    override
    returns (
      uint256 totalCollateralBase,
      uint256 totalDebtBase,
      uint256 availableBorrowsBase,
      uint256 currentLiquidationThreshold,
      uint256 ltv,
      uint256 healthFactor
    )
  {
    return
      PoolLogic.executeGetUserAccountData(
        _reserves,
        _reservesList,
        DataTypes.CalculateUserAccountDataParams({
          userConfig: _usersConfig[keccak256(abi.encodePacked(msg.sender, index))],
          reservesCount: _reservesCount,
          position: user.getPositionId(index),
          pool: address(this)
        })
      );
  }

  /// @inheritdoc IPool
  function getConfiguration(
    address asset
  ) external view virtual override returns (DataTypes.ReserveConfigurationMap memory) {
    return _reserves[asset].configuration;
  }

  /// @inheritdoc IPool
  function getUserConfiguration(
    address user,
    uint256 index
  ) external view virtual override returns (DataTypes.UserConfigurationMap memory) {
    return _usersConfig[user.getPositionId(index)];
  }

  /// @inheritdoc IPool
  function getReserveNormalizedIncome(
    address asset
  ) external view virtual override returns (uint256) {
    return _reserves[asset].getNormalizedIncome();
  }

  /// @inheritdoc IPool
  function getReserveNormalizedVariableDebt(
    address asset
  ) external view virtual override returns (uint256) {
    return _reserves[asset].getNormalizedDebt();
  }

  /// @inheritdoc IPool
  function getReservesList() external view virtual override returns (address[] memory) {
    address[] memory reservesList = new address[](_reservesCount);
    for (uint256 i = 0; i < _reservesCount; i++) reservesList[i] = _reservesList[i];
    return reservesList;
  }

  /// @inheritdoc IPool
  function getReservesCount() external view virtual override returns (uint256) {
    return _reservesCount;
  }

  /// @inheritdoc IPool
  function getReserveAddressById(uint16 id) external view returns (address) {
    return _reservesList[id];
  }

  // @inheritdoc IPool
  function _setReserveConfiguration(
    address asset,
    address rateStrategyAddress,
    address source,
    DataTypes.ReserveConfigurationMap memory configuration
  ) internal {
    require(asset != address(0), Errors.ZERO_ADDRESS_NOT_VALID);
    require(_reserves[asset].id != 0 || _reservesList[0] == asset, Errors.ASSET_NOT_LISTED);
    _reserves[asset].configuration = configuration;
    _reserves[asset].interestRateStrategyAddress = rateStrategyAddress;
    _assetsSources[asset] = IAggregatorInterface(source);

    // // validation of the parameters: the LTV can
    // // only be lower or equal than the liquidation threshold
    // // (otherwise a loan against the asset would cause instantaneous liquidation)
    // require(input[i].ltv <= input[i].liquidationThreshold, Errors.INVALID_RESERVE_PARAMS);

    // DataTypes.ReserveConfigurationMap memory currentConfig = cachedPool.getConfiguration(
    //   input[i].asset
    // );

    // if (input[i].liquidationThreshold != 0) {
    //   //liquidation bonus must be bigger than 100.00%, otherwise the liquidator would receive less
    //   //collateral than needed to cover the debt
    //   require(
    //     input[i].liquidationBonus > PercentageMath.PERCENTAGE_FACTOR,
    //     Errors.INVALID_RESERVE_PARAMS
    //   );

    //   //if threshold * bonus is less than PERCENTAGE_FACTOR, it's guaranteed that at the moment
    //   //a loan is taken there is enough collateral available to cover the liquidation bonus
    //   require(
    //     input[i].liquidationThreshold.percentMul(input[i].liquidationBonus) <=
    //       PercentageMath.PERCENTAGE_FACTOR,
    //     Errors.INVALID_RESERVE_PARAMS
    //   );

    //   currentConfig.setLtv(input[i].ltv);
    //   currentConfig.setLiquidationThreshold(input[i].liquidationThreshold);
    //   currentConfig.setLiquidationBonus(input[i].liquidationBonus);
    //   cachedPool.setConfiguration(input[i].asset, currentConfig);

    //   emit CollateralConfigurationChanged(
    //     input[i].asset,
    //     input[i].ltv,
    //     input[i].liquidationThreshold,
    //     input[i].liquidationBonus
    //   );
    // }
  }

  function setReserveConfiguration(
    address asset,
    address rateStrategyAddress,
    address source,
    DataTypes.ReserveConfigurationMap calldata configuration
  ) external virtual {
    require(msg.sender == address(factory.configurator()), 'only configurator');
    _setReserveConfiguration(asset, rateStrategyAddress, source, configuration);
  }

  function getAssetPrice(address asset) public view override returns (uint256) {
    return uint256(_assetsSources[asset].latestAnswer());
  }
}
