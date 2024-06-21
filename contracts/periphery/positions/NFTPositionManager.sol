// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.8.19;

import {ERC721EnumerableUpgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol';
import {INFTPositionManager} from './INFTPositionManager.sol';
import {IPool} from './../../pools/interfaces/IPool.sol';
import {Multicall} from '../multicall/Multicall.sol';
import {SafeERC20Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol';
import {IERC20Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol';

/**
 * @title NFTPositionManager
 * @dev Manages the minting and burning of NFT positions, which represent liquidity positions in a pool.
 */
contract NFTPositionManager is Multicall, ERC721EnumerableUpgradeable, INFTPositionManager {
  using SafeERC20Upgradeable for IERC20Upgradeable;

  /**
   * @dev The ID of the next token that will be minted. Starts from 1 to avoid using 0 as a token ID.
   */
  uint256 private _nextId = 1;

  /**
   * @notice Mapping from token ID to the Position struct representing the details of the liquidity position.
   */
  mapping(uint256 tokenId => Position) public positions;

  /**
   * @dev Modifier to check if the caller is authorized (owner or approved operator) for the given token ID.
   * @param tokenId The ID of the token to check authorization for.
   */
  modifier isAuthorizedForToken(uint256 tokenId) {
    if (!_isApprovedOrOwner(msg.sender, tokenId)) {
      revert NotTokenIdOwner();
    }
    _;
  }

  /**
   * @dev Constructor to disable initializers.
   */
  constructor() {
    _disableInitializers();
  }

  /**
   * @notice Initializes the NFTPositionManager contract.
   */
  function initialize() external initializer {
    __ERC721Enumerable_init();
    __ERC721_init('ZeroLend Position V2', 'ZL-POS-V2');
  }

  /**
   * @notice Mints a new NFT representing a liquidity position.
   * @param params The parameters required for minting the position, including the pool, token, amount, and recipient.
   * @return tokenId The ID of the newly minted token.
   * @custom:error ZeroAddressNotAllowed error thrown if recipient or asset address is zero address.
   * @custom:error ZeroValueNotAllowed error thrown if the  amount is zero.
   * @custom:event NFTMinted is emitted for each new asset.
   */
  function mint(MintParams calldata params) external returns (uint256 tokenId) {
    // TODO: verify that pool is a part of protocol deployed via PoolFactory.

    if (params.recipient == address(0) || params.asset == address(0))
      revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();

    uint256 idToMint = _nextId;
    _handleLiquidity(
      LiquidityParams({
        asset: params.asset,
        pool: params.pool,
        user: address(this),
        amount: params.amount,
        tokenId: idToMint
      })
    );

    _mint(params.recipient, (tokenId = _nextId++));

    emit NFTMinted(params.recipient, tokenId);
  }

  /**
   * @notice Allow User to increase liquidity in the postion
   * @param params  The parameters required for increase liquidity the position, including the token, amount, and recipient and asset.
   * @custom:error ZeroAddressNotAllowed error thrown if recipient or asset address is zero address.
   * @custom:error ZeroValueNotAllowed error thrown if the  amount is zero.
   * @custom:event LiquidityIncreased emitted whenever user supply asset
   */
  function increaseLiquidity(
    AddLiquidityParams memory params
  ) external isAuthorizedForToken(params.tokenId) {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();

    _handleLiquidity(
      LiquidityParams({
        asset: params.asset,
        pool: positions[params.tokenId].pool,
        user: address(this),
        amount: params.amount,
        tokenId: params.tokenId
      })
    );

    emit LiquidityIncreased(params.asset, params.tokenId, params.amount);
  }

  /**
   * @notice Allow user to borrow the underlying assets
   * @param params The params required for borrow the position which includes tokenId, market and amount
   * @custom:error ZeroAddressNotAllowed error thrown asset address is zero address.
   * @custom:error ZeroValueNotAllowed error thrown if the  amount is zero.
   * @custom:error BalanceMisMatch error thrown if difference of currentDebtBalance and previousDebtBalance is not equal to amount
   */
  function borrow(BorrowParams memory params) external isAuthorizedForToken(params.tokenId) {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();

    Position storage userPosition = positions[params.tokenId];
    bytes32 positionId = _getPositionId(params.tokenId);

    IPool pool = IPool(userPosition.pool);
    IERC20Upgradeable asset = IERC20Upgradeable(params.asset);

    uint256 previousContractBalance = asset.balanceOf(address(this));
    uint256 previousDebtBalance = pool.getDebt(params.asset, positionId);
    uint256 currentDebtBalance = pool.getDebt(params.asset, positionId);
    pool.borrow(params.asset, params.amount, params.tokenId);
    uint256 currentContractBalance = asset.balanceOf(address(this));

    if (
      currentDebtBalance - previousDebtBalance != params.amount ||
      currentContractBalance - previousContractBalance != params.amount
    ) {
      revert BalanceMisMatch();
    }

    // params.amount will be equal to balance differences
    _modifyAsset(userPosition, params.asset, params.amount, OperationType.Borrow, ActionType.Add);
    asset.safeTransfer(msg.sender, params.amount);
  }

  /**
   * @notice Allow user to withdraw their underlying assets.
   * @param params The parameters required for withdrawing from the position, including tokenId, asset, and amount.
   * @custom:error ZeroAddressNotAllowed error thrown if asset or user address is zero address.
   * @custom:error ZeroValueNotAllowed error thrown if the  amount is zero.
   * @custom:error InvalidAssetAddress error thrown if asset address is not found in the position asset array list
   * @custom:error BalanceMisMatch error thrown if difference of previousSupplyBalance currentSupplyBalance and  is not equal to amount
   */

  function withdraw(WithdrawParams memory params) external isAuthorizedForToken(params.tokenId) {
    if (params.asset == address(0) || params.user == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();

    Position storage userPosition = positions[params.tokenId];
    Asset[] storage assets = userPosition.assets;

    uint256 length = assets.length;
    int256 index = _validateAsset(assets, params.asset, length);

    IPool pool = IPool(userPosition.pool);
    bytes32 positionId = _getPositionId(params.tokenId);

    uint256 previousSupplyBalance = pool.getBalance(params.asset, positionId);
    pool.withdraw(params.asset, params.amount, params.tokenId);
    uint256 currentSupplyBalance = pool.getBalance(params.asset, positionId);

    if (previousSupplyBalance - currentSupplyBalance != params.amount) revert BalanceMisMatch();

    assets[uint256(index)].balance -= params.amount;
  }

  /**
   * @notice Burns a token, removing it from existence.
   * @param tokenId The ID of the token to burn.
   * @custom:error PositionNotCleared thrown if user postion is not cleared in the position map
   * @custom:event NFTBurned emitted when user want to burn their NFT
   */
  function burn(uint256 tokenId) external isAuthorizedForToken(tokenId) {
    Asset[] memory assets = positions[tokenId].assets;
    uint256 length = assets.length;

    for (uint256 i; i < length; ) {
      if (assets[i].balance != 0 || assets[i].debt != 0) {
        revert PositionNotCleared();
      }
      unchecked {
        ++i;
      }
    }
    _burn(tokenId);
    emit NFTBurned(tokenId);
  }

  /**
   * @notice Allow user to repay thier debt.
   * @param params The params required for repaying the position which includes tokenId, asset and amount.
   * @custom:error ZeroAddressNotAllowed error thrown if asset address is zero address.
   * @custom:error ZeroValueNotAllowed error thrown if the  amount is zero.
   * @custom:error InvalidAssetAddress error thrown if asset address is not found in the position asset array list
   * @custom:error BalanceMisMatch error thrown if difference of previousDebtBalance currentDebtBalance and is not equal to amount
   */
  function repay(RepayParams memory params) external {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();

    Position storage userPosition = positions[params.tokenId];
    Asset[] storage assets = userPosition.assets;

    uint256 length = assets.length;
    int256 index = _validateAsset(assets, params.asset, length);

    IPool pool = IPool(userPosition.pool);
    IERC20Upgradeable asset = IERC20Upgradeable(params.asset);

    asset.safeTransferFrom(msg.sender, address(this), params.amount);
    asset.forceApprove(userPosition.pool, params.amount);

    bytes32 positionId = _getPositionId(params.tokenId);

    uint256 previousContractBalance = asset.balanceOf(address(this));
    uint256 previousDebtBalance = pool.getDebt(params.asset, positionId);
    uint256 finalRepayAmout = pool.repay(params.asset, params.amount, params.tokenId);
    uint256 currentDebtBalance = pool.getDebt(params.asset, positionId);
    uint256 currentContractBalance = asset.balanceOf(address(this));

    if (previousDebtBalance - currentDebtBalance != finalRepayAmout) {
      revert BalanceMisMatch();
    }

    // Send back the extra tokens user senr
    if (currentDebtBalance == 0 && finalRepayAmout < params.amount) {
      asset.safeTransfer(msg.sender, params.amount - finalRepayAmout);
    }

    assets[uint256(index)].debt -= previousDebtBalance - currentDebtBalance;
  }

  /**
   * @notice Handles the liquidity operations including transferring tokens, approving the pool, and updating balances.
   * @param params The liquidity parameters including asset, pool, user, amount, and tokenId.
   * @return balanceDiff The difference in balance after the supply action.
   */
  function _handleLiquidity(LiquidityParams memory params) private returns (uint256 balanceDiff) {
    bytes32 positionId = _getPositionId(params.tokenId);

    IERC20Upgradeable(params.asset).safeTransferFrom(msg.sender, address(this), params.amount);
    IERC20Upgradeable(params.asset).forceApprove(params.pool, params.amount);

    IPool pool = IPool(params.pool);
    uint256 previousSupplyBalance = pool.getBalance(params.asset, positionId);
    pool.supply(params.asset, params.amount, params.tokenId);
    uint256 currentSupplyBalance = pool.getBalance(params.asset, positionId);

    balanceDiff = currentSupplyBalance - previousSupplyBalance;

    // _modifyAsset(params.tokenId, params.asset, balanceDiff, true, true);
    _modifyAsset(
      positions[params.tokenId],
      params.asset,
      balanceDiff,
      OperationType.Supply,
      ActionType.Add
    );
  }

  /**
   * @dev Modify the balance or debt of a given asset within a position.
   * @param userPosition The user's position to modify.
   * @param asset The address of the asset.
   * @param amount The amount to modify the balance or debt by.
   * @param operationType The type of operation (Supply or Borrow).
   * @param actionType The action to perform (Add or Subtract).
   */
  function _modifyAsset(
    Position storage userPosition,
    address asset,
    uint256 amount,
    OperationType operationType,
    ActionType actionType
  ) private {
    Asset[] storage assets = userPosition.assets;
    uint256 length = assets.length;

    for (uint256 i; i < length; ) {
      if (assets[i].asset == asset) {
        if (operationType == OperationType.Supply) {
          if (actionType == ActionType.Add) {
            assets[i].balance += amount;
          } else {
            assets[i].balance -= amount;
          }
        } else {
          if (actionType == ActionType.Add) {
            assets[i].debt += amount;
          } else {
            assets[i].debt -= amount;
          }
        }
        return;
      }
      unchecked {
        ++i;
      }
    }

    // If the asset is not found, add a new entry with the appropriate initial values
    if (operationType == OperationType.Supply) {
      assets.push(Asset({asset: asset, debt: 0, balance: amount}));
    } else {
      assets.push(Asset({asset: asset, debt: amount, balance: 0}));
    }
  }

  /**
   * @notice Validates if a given asset exists in the array of assets.
   * @dev This function iterates over the provided assets array to check if the specified asset address exists.
   * If the asset is found, its index in the array is returned. If not, the function reverts with an error.
   * @param assets The storage array of `Asset` structs to search within.
   * @param asset The address of the asset to validate.
   * @param len The length of the `assets` array.
   * @return index The index of the asset in the array if found, otherwise reverts.
   * @custom:error InvalidAssetAddress if the asset is not found in the array.
   */
  function _validateAsset(
    Asset[] storage assets,
    address asset,
    uint256 len
  ) private pure returns (int256 index) {
    index = -1;
    Asset[] memory assetsCache = assets;
    for (uint256 i = 0; i < len; ) {
      if (asset == assetsCache[i].asset) {
        index = int256(i);
        break;
      }
      unchecked {
        ++i;
      }
    }

    if (index == -1) revert InvalidAssetAddress();
  }

  /**
   * @dev Get the Postion Id based on tokenID and Contract address.
   * @param index NFT token ID.
   */
  function _getPositionId(uint256 index) private view returns (bytes32) {
    return keccak256(abi.encodePacked(address(this), 'index', index));
  }
}
