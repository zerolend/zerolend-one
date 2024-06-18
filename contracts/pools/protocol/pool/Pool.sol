// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {BorrowLogic} from '../libraries/logic/BorrowLogic.sol';
import {DataTypes} from '../libraries/types/DataTypes.sol';
import {Errors} from '../libraries/helpers/Errors.sol';
import {IAggregatorInterface} from '../../interfaces/IAggregatorInterface.sol';
import {FlashLoanLogic} from '../libraries/logic/FlashLoanLogic.sol';
import {Initializable} from '@openzeppelin/contracts/proxy/utils/Initializable.sol';
import {IPool} from '../../interfaces/IPool.sol';
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

  /// @dev Total FlashLoan Premium, expressed in bps
  uint128 internal _flashLoanPremiumTotal;

  /// @dev Maximum number of active reserves there have been in the protocol. It is the upper bound of the reserves list
  uint16 internal _reservesCount;

  /// @dev Map of asset price sources (pool => asset => priceSource)
  mapping(address asset => IAggregatorInterface oracle) internal _assetsSources;

  /// @dev The pool configurator contract that can make changes
  address public configurator;

  uint256 public reserveFactor;

  /**
   * @notice Initializes the Pool.
   * @dev Function is invoked by the proxy contract when the Pool contract is added to the
   * PoolAddressesProvider of the market.
   * @dev Caching the address of the PoolAddressesProvider in order to reduce gas consumption on subsequent operations
   */
  function initialize(
    address _configurator,
    address[] memory assets,
    address[] memory rateStrategyAddresses,
    address[] memory sources,
    DataTypes.ReserveConfigurationMap[] memory configurations
  ) public virtual reinitializer(1) {
    configurator = _configurator;
    for (uint i = 0; i < assets.length; i++) {
      if (
        PoolLogic.executeInitReserve(
          _reserves,
          _reservesList,
          DataTypes.InitReserveParams({
            asset: assets[i],
            interestRateStrategyAddress: rateStrategyAddresses[i],
            reservesCount: _reservesCount
          })
        )
      ) {
        _reservesCount++;
      }

      _setReserveConfiguration(assets[i], rateStrategyAddresses[i], sources[i], configurations[i]);
    }
  }

  /// @inheritdoc IPool
  function supply(
    address asset,
    uint256 amount,
    address onBehalfOf,
    uint256 index
  ) public virtual override {
    bytes32 positionId = onBehalfOf.getPositionId(index);
    SupplyLogic.executeSupply(
      _reserves,
      DataTypes.ExecuteSupplyParams({asset: asset, amount: amount, onBehalfOfPosition: positionId})
    );

    _balances[asset][positionId] += amount;
    _totalSupplies[asset] += amount;
  }

  /// @inheritdoc IPool
  function withdraw(
    address asset,
    uint256 amount,
    address to,
    uint256 index
  ) public virtual override returns (uint256 withdrawalAmount) {
    bytes32 positionId = to.getPositionId(index);

    require(amount <= _balances[asset][positionId], "Insufficient Balance!");
    withdrawalAmount = SupplyLogic.executeWithdraw(
      _reserves,
      _reservesList,
      _usersConfig[keccak256(abi.encodePacked(msg.sender, index))],
      DataTypes.ExecuteWithdrawParams({
        user: to,
        asset: asset,
        amount: amount,
        position: positionId,
        reservesCount: _reservesCount,
        pool: address(this)
      })
    );
    // Move these kind of operations to the position contract
    _totalSupplies[asset] -= withdrawalAmount;
    _balances[asset][positionId] -= amount;
  }

  /// @inheritdoc IPool
  function borrow(
    address asset,
    uint256 amount,
    address onBehalfOf,
    uint256 index
  ) public virtual override {
    BorrowLogic.executeBorrow(
      _reserves,
      _reservesList,
      _usersConfig[keccak256(abi.encodePacked(onBehalfOf, index))],
      DataTypes.ExecuteBorrowParams({
        asset: asset,
        user: msg.sender,
        onBehalfOfPosition: onBehalfOf.getPositionId(index),
        amount: amount,
        releaseUnderlying: true,
        reservesCount: _reservesCount,
        pool: address(this)
      })
    );
  }

  // @inheritdoc IPool
  function repay(
    address asset,
    uint256 amount,
    address onBehalfOf,
    uint256 index
  ) public virtual returns (uint256) {
    return
      BorrowLogic.executeRepay(
        _reserves,
        _reservesList,
        _usersConfig[keccak256(abi.encodePacked(msg.sender, index))],
        DataTypes.ExecuteRepayParams({
          asset: asset,
          amount: amount,
          onBehalfOfPosition: onBehalfOf.getPositionId(index)
        })
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
      flashLoanPremiumToProtocol: 1000, //_flashLoanPremiumToProtocol,
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
    uint256 reservesListCount = _reservesCount;
    uint256 droppedReservesCount = 0;
    address[] memory reservesList = new address[](reservesListCount);

    for (uint256 i = 0; i < reservesListCount; i++) {
      if (_reservesList[i] != address(0)) {
        reservesList[i - droppedReservesCount] = _reservesList[i];
      } else {
        droppedReservesCount++;
      }
    }

    // Reduces the length of the reserves array by `droppedReservesCount`
    assembly {
      mstore(reservesList, sub(reservesListCount, droppedReservesCount))
    }
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
  }

  function setReserveConfiguration(
    address asset,
    address rateStrategyAddress,
    address source,
    DataTypes.ReserveConfigurationMap calldata configuration
  ) external virtual {
    require(msg.sender == configurator, 'only configurator');
    _setReserveConfiguration(asset, rateStrategyAddress, source, configuration);
  }

  function getAssetPrice(address asset) public view override returns (uint256) {
    return uint256(_assetsSources[asset].latestAnswer());
  }
}
