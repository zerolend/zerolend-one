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

import {INFTPositionManager} from '../../interfaces/INFTPositionManager.sol';
import {DataTypes, IPool, IPoolFactory} from '../../interfaces/IPoolFactory.sol';
import {IWETH} from '../../interfaces/IWETH.sol';
import {NFTRewardsDistributor} from './NFTRewardsDistributor.sol';
import {IERC20Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol';
import {SafeERC20Upgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol';
import {
  ERC721EnumerableUpgradeable,
  ERC721Upgradeable,
  IERC721Upgradeable
} from '@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol';
import {MulticallUpgradeable} from '@openzeppelin/contracts-upgradeable/utils/MulticallUpgradeable.sol';

/**
 * @title NFTPositionManager
 * @dev Manages the minting and burning of NFT positions, which represent liquidity positions in a pool.
 */
contract NFTPositionManager is NFTRewardsDistributor, MulticallUpgradeable, INFTPositionManager {
  using SafeERC20Upgradeable for IERC20Upgradeable;

  /**
   * @notice The pool factory contract that is used to create pools.
   */
  IPoolFactory public factory;

  /**
   * @notice The ID of the next token that will be minted. Starts from 1 to avoid using 0 as a token ID.
   */
  uint256 private _nextId;

  /**
   * @notice Mapping from token ID to the Position struct representing the details of the liquidity position.
   */
  mapping(uint256 tokenId => Position position) private _positions;

  /// @notice Address for the wrapped ether
  IWETH public weth;

  /// @custom:oz-upgrades-unsafe-allow constructor
  constructor() {
    _disableInitializers();
  }

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
   * @dev Modifier to check if the caller is pool or not.
   * @param pool Address of the pool.
   */
  modifier isPool(address pool) {
    if (!factory.isPool(pool)) {
      revert NotPool();
    }
    _;
  }

  /// @inheritdoc INFTPositionManager
  function initialize(address _factory, address _staking, address _owner, address _zero) external initializer {
    factory = IPoolFactory(_factory);
    __ERC721Enumerable_init();
    __ERC721_init('ZeroLend One Position', 'ZL-POS-ONE');
    __Ownable_init();
    __NFTRewardsDistributor_init(50_000_000, _staking, 14 days, _zero);
    _nextId = 1;

    _transferOwnership(_owner);
  }

  /// @inheritdoc INFTPositionManager
  function mint(MintParams calldata params) external isPool(params.pool) returns (uint256 tokenId) {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();

    tokenId = _nextId;
    _nextId++;

    _positions[tokenId].pool = params.pool;
    _positions[tokenId].operator = address(0);

    _handleLiquidity(LiquidityParams(params.asset, params.pool, params.amount, tokenId, params.data));
    _mint(msg.sender, tokenId);
  }

  /// @inheritdoc INFTPositionManager
  function supply(AssetOperationParams memory params) external {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();
    if (params.tokenId == 0) params.tokenId = _nextId - 1;
    IPool pool = IPool(_positions[params.tokenId].pool);

    _isAuthorizedForToken(params.tokenId);
    _handleLiquidity(LiquidityParams(params.asset, address(pool), params.amount, params.tokenId, params.data));
  }

  /// @inheritdoc INFTPositionManager
  function borrow(AssetOperationParams memory params) external isAuthorizedForToken(params.tokenId) {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();
    if (params.tokenId == 0) params.tokenId = _nextId - 1;

    IPool pool = IPool(_positions[params.tokenId].pool);
    IERC20Upgradeable asset = IERC20Upgradeable(params.asset);

    pool.borrow(params.asset, params.amount, params.tokenId, params.data);
    asset.safeTransfer(msg.sender, params.amount);
    emit BorrowIncreased(params.asset, params.amount, params.tokenId);

    // update incentives
    _handleDebt(address(pool), params.asset, params.tokenId);
  }

  /// @inheritdoc INFTPositionManager
  function withdraw(AssetOperationParams memory params) external isAuthorizedForToken(params.tokenId) {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();
    if (params.tokenId == 0) params.tokenId = _nextId - 1;

    IPool pool = IPool(_positions[params.tokenId].pool);
    IERC20Upgradeable asset = IERC20Upgradeable(params.asset);

    pool.withdraw(params.asset, params.amount, params.tokenId, params.data);
    asset.safeTransfer(msg.sender, params.amount);
    emit Withdrawal(params.asset, params.amount, params.tokenId);

    // update incentives
    _handleSupplies(address(pool), params.asset, params.tokenId);
  }

  /// @inheritdoc INFTPositionManager
  function burn(uint256 tokenId) external isAuthorizedForToken(tokenId) {
    if (tokenId == 0) tokenId = _nextId - 1;
    (, bool isBurnAllowed) = getPosition(tokenId);
    if (!isBurnAllowed) revert PositionNotCleared();
    delete _positions[tokenId];
    _burn(tokenId);
  }

  /// @inheritdoc INFTPositionManager
  function repay(AssetOperationParams memory params) external {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();
    if (params.tokenId == 0) params.tokenId = _nextId - 1;

    Position memory userPosition = _positions[params.tokenId];

    IPool pool = IPool(userPosition.pool);
    IERC20Upgradeable asset = IERC20Upgradeable(params.asset);

    asset.safeTransferFrom(msg.sender, address(this), params.amount);
    asset.forceApprove(userPosition.pool, params.amount);

    uint256 previousDebtBalance = pool.getDebt(params.asset, address(this), params.tokenId);
    DataTypes.SharesType memory repaid = pool.repay(params.asset, params.amount, params.tokenId, params.data);
    uint256 currentDebtBalance = pool.getDebt(params.asset, address(this), params.tokenId);

    if (previousDebtBalance - currentDebtBalance != repaid.assets) {
      revert BalanceMisMatch();
    }

    if (currentDebtBalance == 0 && repaid.assets < params.amount) {
      asset.safeTransfer(msg.sender, params.amount - repaid.assets);
    }

    // update incentives
    _handleDebt(address(pool), params.asset, params.tokenId);

    emit Repay(params.asset, params.amount, params.tokenId);
  }

  function wrapEther() external payable {
    weth.deposit{value: msg.value}();
  }

  /// @inheritdoc IERC721Upgradeable
  function getApproved(uint256 tokenId) public view override (ERC721Upgradeable, IERC721Upgradeable) returns (address) {
    require(_exists(tokenId), 'ERC721: approved query for nonexistent token');
    return _positions[tokenId].operator;
  }

  /// @inheritdoc INFTPositionManager
  function getPosition(uint256 tokenId) public view returns (Asset[] memory assets, bool isBurnAllowed) {
    Position memory position = _positions[tokenId];

    IPool pool = IPool(position.pool);
    address[] memory _assets = pool.getReservesList();
    uint256 length = _assets.length;
    isBurnAllowed = true;

    assets = new Asset[](length);
    for (uint256 i; i < length;) {
      address asset = assets[i].asset = _assets[i];
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

  /// @inheritdoc INFTPositionManager
  function positions(uint256 tokenId) external view returns (Position memory) {
    return _positions[tokenId];
  }

  /// @dev Overrides _approve to use the operator in the position, which is packed with the position permit nonce
  function _approve(address to, uint256 tokenId) internal override (ERC721Upgradeable) {
    _positions[tokenId].operator = to;
    emit Approval(ownerOf(tokenId), to, tokenId);
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

    pool.supply(params.asset, params.amount, params.tokenId, params.data);
    emit LiquidityIncreased(params.asset, params.tokenId, params.amount);

    // update incentives
    _handleSupplies(params.pool, params.asset, params.tokenId);
  }

  function _isAuthorizedForToken(uint256 tokenId) internal view {
    if (!_isApprovedOrOwner(msg.sender, tokenId)) revert NotTokenIdOwner();
  }
}
