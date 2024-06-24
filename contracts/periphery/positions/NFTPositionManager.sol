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

import {ERC721EnumerableUpgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol';
import {INFTPositionManager} from './INFTPositionManager.sol';
import {IPool, IFactory} from './../../core/interfaces/IFactory.sol';
import {Multicall} from '../multicall/Multicall.sol';
import {SafeERC20Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol';
import {IERC20Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol';

/**
 * @title NFTPositionManager
 * @dev Manages the minting and burning of NFT positions, which represent liquidity positions in a pool.
 */
contract NFTPositionManager is Multicall, ERC721EnumerableUpgradeable, INFTPositionManager {
  using SafeERC20Upgradeable for IERC20Upgradeable;

  IFactory factory;

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
   *  @dev Modifier to check if the caller is pool or not.
   *  @param pool Address of the pool.
   */
  modifier isPool(address pool) {
    if (!factory.isPool(pool)) {
      revert NotPool();
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
  function initialize(address _factory) external initializer {
    factory = IFactory(_factory);
    __ERC721Enumerable_init();
    __ERC721_init('ZeroLend Position V2', 'ZL-POS-V2');
  }

  /**
   * @notice Mints a new NFT representing a liquidity position.
   * @param params The parameters required for minting the position, including the pool,token and amount.
   * @return tokenId The ID of the newly minted token.
   * @custom:error ZeroAddressNotAllowed error thrown if asset address is zero address.
   * @custom:error ZeroValueNotAllowed error thrown if the  amount is zero.
   * @custom:event NFTMinted is emitted for each new asset.
   */
  function mint(MintParams calldata params) external isPool(params.pool) returns (uint256 tokenId) {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();

    tokenId = _nextId;
    _nextId++;

    _handleLiquidity(LiquidityParams(params.asset, params.pool, params.amount, tokenId));
    _mint(msg.sender, tokenId);
  }

  /**
   * @notice Allow User to increase liquidity in the postion
   * @param params  The parameters required for increase liquidity the position, including the token, pool, amount and asset.
   * @custom:error ZeroAddressNotAllowed error thrown if asset address is zero address.
   * @custom:error ZeroValueNotAllowed error thrown if the  amount is zero.
   */
  function increaseLiquidity(
    LiquidityParams memory params
  ) external isAuthorizedForToken(params.tokenId) {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();

    _handleLiquidity(LiquidityParams(params.asset, params.pool, params.amount, params.tokenId));
  }

  /**
   * @notice Allow user to borrow the underlying assets
   * @param params The params required for borrow the position which includes tokenId, market and amount
   * @custom:error ZeroAddressNotAllowed error thrown asset address is zero address.
   * @custom:error ZeroValueNotAllowed error thrown if the  amount is zero.
   * @custom:error BalanceMisMatch error thrown if difference of currentDebtBalance and previousDebtBalance is not equal to amount
   * @custom:event BorrowIncreased emitted whenever user borrows asset
   */
  function borrow(
    AssetOperationParams memory params
  ) external isAuthorizedForToken(params.tokenId) {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();

    IPool pool = IPool(positions[params.tokenId].pool);
    IERC20Upgradeable asset = IERC20Upgradeable(params.asset);

    uint256 previousContractBalance = asset.balanceOf(address(this));
    pool.borrow(params.asset, params.amount, params.tokenId);
    uint256 currentContractBalance = asset.balanceOf(address(this));

    if (currentContractBalance - previousContractBalance != params.amount) {
      revert BalanceMisMatch();
    }

    asset.safeTransfer(msg.sender, params.amount);
    emit BorrowIncreased(params.asset, params.amount, params.tokenId);
  }

  /**
   * @notice Allow user to withdraw their underlying assets.
   * @param params The parameters required for withdrawing from the position, including tokenId, asset, and amount.
   * @custom:error ZeroAddressNotAllowed error thrown if asset or user address is zero address.
   * @custom:error ZeroValueNotAllowed error thrown if the  amount is zero.
   * @custom:error BalanceMisMatch error thrown if difference of previousSupplyBalance currentSupplyBalance and  is not equal to amount
   * @custom:event Withdrawal emitted whenever user withdraws asset
   */

  function withdraw(
    AssetOperationParams memory params
  ) external isAuthorizedForToken(params.tokenId) {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();

    IPool pool = IPool(positions[params.tokenId].pool);
    IERC20Upgradeable asset = IERC20Upgradeable(params.asset);

    uint256 previousContractBalance = asset.balanceOf(address(this));
    pool.withdraw(params.asset, params.amount, params.tokenId);
    uint256 currentContractBalance = asset.balanceOf(address(this));

    if (currentContractBalance - previousContractBalance != params.amount) {
      revert BalanceMisMatch();
    }
    asset.safeTransfer(msg.sender, params.amount);
    emit Withdrawal(params.asset, params.amount, params.tokenId);
  }

  /**
   * @notice Burns a token, removing it from existence.
   * @param tokenId The ID of the token to burn.
   * @custom:error PositionNotCleared thrown if user postion is not cleared in the position map
   */
  function burn(uint256 tokenId) external isAuthorizedForToken(tokenId) {
    (, bool isBurnAllowed) = getPosition(tokenId);
    if (!isBurnAllowed) revert PositionNotCleared();
    delete positions[tokenId];
    _burn(tokenId);
  }

  /**
   * @notice Allow user to repay thier debt.
   * @param params The params required for repaying the position which includes tokenId, asset and amount.
   * @custom:error ZeroAddressNotAllowed error thrown if asset address is zero address.
   * @custom:error ZeroValueNotAllowed error thrown if the  amount is zero.
   * @custom:error BalanceMisMatch error thrown if difference of previousDebtBalance currentDebtBalance and is not equal to amount
   * @custom:event Repay emitted whenever user repays asset
   */
  function repay(AssetOperationParams memory params) external {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();

    Position memory userPosition = positions[params.tokenId];

    IPool pool = IPool(userPosition.pool);
    IERC20Upgradeable asset = IERC20Upgradeable(params.asset);

    asset.safeTransferFrom(msg.sender, address(this), params.amount);
    asset.forceApprove(userPosition.pool, params.amount);

    bytes32 positionId = _getPositionId(params.tokenId);

    uint256 previousDebtBalance = pool.getDebt(params.asset, positionId);
    uint256 finalRepayAmout = pool.repay(params.asset, params.amount, params.tokenId);
    uint256 currentDebtBalance = pool.getDebt(params.asset, positionId);

    if (previousDebtBalance - currentDebtBalance != finalRepayAmout) {
      revert BalanceMisMatch();
    }

    // Send back the extra tokens user send
    if (currentDebtBalance == 0 && finalRepayAmout < params.amount) {
      asset.safeTransfer(msg.sender, params.amount - finalRepayAmout);
    }

    emit Repay(params.asset, params.amount, params.tokenId);
  }

  /**
   * @notice Handles the liquidity operations including transferring tokens, approving the pool, and updating balances.
   * @param params The liquidity parameters including asset, pool, user, amount, and tokenId.
   * @custom:event LiquidityIncreased emitted whenever user supply asset
   */
  function _handleLiquidity(LiquidityParams memory params) private {
    IERC20Upgradeable(params.asset).safeTransferFrom(msg.sender, address(this), params.amount);
    IERC20Upgradeable(params.asset).forceApprove(params.pool, params.amount);

    IPool pool = IPool(params.pool);
    pool.supply(params.asset, params.amount, params.tokenId);
    emit LiquidityIncreased(params.asset, params.tokenId, params.amount);
  }

  /**
   * @dev Get the Postion Id based on tokenID and Contract address.
   * @param index NFT token ID.
   */
  function _getPositionId(uint256 index) private view returns (bytes32) {
    return keccak256(abi.encodePacked(address(this), 'index', index));
  }

  /**
   * @notice Retrieves the details of a position identified by the given token ID.
   * @param tokenId The ID of the position token.
   * @return assets An array of Asset structs representing the balances and debts of the position's assets.
   */
  function getPosition(
    uint256 tokenId
  ) public view returns (Asset[] memory assets, bool isBurnAllowed) {
    Position memory position = positions[tokenId];

    IPool pool = IPool(position.pool);
    address[] memory _assets = pool.getReservesList();
    uint256 length = _assets.length;
    isBurnAllowed = true;

    assets = new Asset[](length);
    for (uint256 i; i < length; ) {
      address asset = _assets[i];
      uint256 balance = assets[i].balance = pool.getBalance(asset, address(this), tokenId);
      uint256 debt = assets[i].debt = pool.getDebt(asset, address(this), tokenId);
      if ((balance > 0 || debt > 0) && isBurnAllowed) {
        isBurnAllowed = false;
      }

      unchecked {
        ++i;
      }
    }

    return (assets, isBurnAllowed);
  }
}
