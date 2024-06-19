// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.8.19;

import {ERC721EnumerableUpgradeable} from '@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol';
import {INFTPositionManager} from './INFTPositionManager.sol';
import {IPool} from './../../pools/interfaces/IPoolNew.sol';

/**
 * @title NFTPositionManager
 * @dev Manages the minting and burning of NFT positions, which represent liquidity positions in a pool.
 */
contract NFTPositionManager is ERC721EnumerableUpgradeable, INFTPositionManager {
  /// @dev The ID of the next token that will be minted. Starts from 1 to avoid using 0 as a token ID.
  uint256 private _nextId = 1;

  /// @notice Mapping from token ID to the Position struct representing the details of the liquidity position.
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

  constructor() {
    _disableInitializers();
  }

  function initialize() external reinitializer(1) {
    __ERC721Enumerable_init();
    __ERC721_init('ZeroLend Position V2', 'ZL-POS-V2');
  }

  /**
   * @notice Mints a new NFT representing a liquidity position.
   * @param params The parameters required for minting the position, including the pool, token, amount, and recipient.
   * @return tokenId The ID of the newly minted token.
   */
  function mint(MintParams calldata params) external returns (uint256 tokenId) {
    // TODO: verify that pool is a part of protocol deployed via PoolFactory.

    if (params.recipient == address(0) || params.asset == address(0))
      revert ZeroAddressNotAllowed();

    if (params.amount == 0) revert ZeroValueNotAllowed();

    uint256 idToMint = _nextId;
    bytes32 positionId = _getPositionId(idToMint);

    IPool pool = IPool(params.pool);

    uint256 previousSupplyBalance = pool.balances(params.asset, positionId);
    pool.supply(params.asset, params.amount, params.recipient, idToMint);
    uint256 currentSupplyBalance = pool.balances(params.asset, positionId);

    Asset[] memory marketPair = new Asset[](1);

    marketPair[0] = Asset({
      asset: params.asset,
      balance: currentSupplyBalance - previousSupplyBalance,
      debt: 0
    });

    positions[idToMint] = Position({assets: marketPair, pool: params.pool, operator: address(0)});

    _mint(params.recipient, (tokenId = _nextId++));

    emit NFTMinted(params.recipient, tokenId);
  }

  /**
   * @notice Allow User to increase liquidity in the postion
   * @param params  The parameters required for increase liquidity the position, including the token, amount, and recipient and market.
   */
  function increaseLiquidity(
    AddLiquidityParams memory params
  ) external isAuthorizedForToken(params.tokenId) {
    if (params.user == address(0) || params.asset == address(0)) revert ZeroAddressNotAllowed();

    if (params.amount == 0) revert ZeroValueNotAllowed();

    Position storage userPosition = positions[params.tokenId];

    IPool pool = IPool(userPosition.pool);

    // if(address(pool) == address(0)) revert InvalidTokenId(); // can be removed
    bytes32 positionId = _getPositionId(params.tokenId);

    uint256 previousSupplyBalance = pool.balances(params.asset, positionId);
    pool.supply(params.asset, params.amount, params.user, params.tokenId);
    uint256 currentSupplyBalance = pool.balances(params.asset, positionId);

    _addSupplyMarketOrIncreaseSupply(
      userPosition,
      params.asset,
      currentSupplyBalance - previousSupplyBalance
    );
  }

  /**
   * @notice Allow user to borrow the underlying assets
   * @param params The params required for borrow the position which includes tokenId, market and amount
   */
  function borrow(BorrowParams memory params) external isAuthorizedForToken(params.tokenId) {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();

    Position storage userPosition = positions[params.tokenId];

    IPool pool = IPool(userPosition.pool);

    // if(address(pool) == address(0)) revert InvalidTokenId(); // can be removed
    bytes32 positionId = _getPositionId(params.tokenId);

    uint256 previousDebtBalance = pool.debts(params.asset, positionId);
    pool.borrow(params.asset, params.amount, address(this), params.tokenId);
    uint256 currentDebtBalance = pool.debts(params.asset, positionId);

    _addBorrowMarketOrIncreaseBorrow(
      userPosition,
      params.asset,
      currentDebtBalance - previousDebtBalance
    );
  }

  function withdraw(WithdrawParams memory params) external isAuthorizedForToken(params.tokenId) {
    if (params.asset == address(0) || params.user == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();

    Position storage userPosition = positions[params.tokenId];
    Asset[] storage supplyMarket = userPosition.assets;
    uint256 len = supplyMarket.length;
    int256 index = -1;

    for (uint256 i; i < len; ) {
      if (params.asset == supplyMarket[i].asset) {
        index = int256(i);
        break;
      }
      unchecked {
        ++i;
      }
    }

    if (index == -1) revert InvalidMarketAddress();
    IPool pool = IPool(userPosition.pool);
    bytes32 positionId = _getPositionId(params.tokenId);
    uint256 previousSupplyBalance = pool.balances(params.asset, positionId);
    pool.withdraw(params.asset, params.amount, params.user, params.tokenId);
    uint256 currentSupplyBalance = pool.balances(params.asset, positionId);
    supplyMarket[uint256(index)].balance = currentSupplyBalance - previousSupplyBalance;
    // TODO: add burn nft logic
  }

  /**
   * @notice Allow user to repay thier debt
   * @param params The params required for repaying the position which includes tokenId, market and amount
   */
  function repay(RepayParams memory params) external {
    if (params.asset == address(0)) revert ZeroAddressNotAllowed();
    if (params.amount == 0) revert ZeroValueNotAllowed();

    Position storage userPosition = positions[params.tokenId];
    Asset[] storage debtMarket = userPosition.assets;
    uint256 len = debtMarket.length;

    int256 index = -1;
    for (uint256 i; i < len; ) {
      if (params.asset == debtMarket[i].asset) {
        index = int256(i);
        break;
      }
      unchecked {
        ++i;
      }
    }

    if (index == -1) revert InvalidMarketAddress();

    IPool pool = IPool(userPosition.pool);
    bytes32 positionId = _getPositionId(params.tokenId);
    uint256 previousDebtBalance = pool.debts(params.asset, positionId);
    uint256 finalRepayAmout = pool.repay(
      params.asset,
      params.amount,
      address(this),
      params.tokenId
    );
    uint256 currentDebtBalance = pool.debts(params.asset, positionId);

    debtMarket[uint256(index)].balance = previousDebtBalance - currentDebtBalance;
  }

  /**
   * @dev Check for if the market is already created or not
   * @param userPosition Take the user Position
   * @param market address of the market
   * @param balanceToIncrease amount of the balance to increase for supply market
   */
  function _addSupplyMarketOrIncreaseSupply(
    Position storage userPosition,
    address market,
    uint256 balanceToIncrease
  ) private {
    Asset[] storage supplyMarkets = userPosition.assets;
    uint256 length = supplyMarkets.length;

    for (uint256 i; i < length; ) {
      if (supplyMarkets[i].asset == market) {
        supplyMarkets[i].balance += balanceToIncrease;
        return;
      }
      unchecked {
        ++i;
      }
    }

    supplyMarkets.push(Asset({asset: market, debt: 0, balance: balanceToIncrease}));
  }

  /**
   * @dev Check for if the market is already created or not
   * @param userPosition Take the user Position
   * @param asset address of the asset
   * @param balanceToIncrease amount of the balance to increase for debt market
   */
  function _addBorrowMarketOrIncreaseBorrow(
    Position storage userPosition,
    address asset,
    uint256 balanceToIncrease
  ) private {
    Asset[] storage debtMarkets = userPosition.assets;
    uint256 length = debtMarkets.length;

    for (uint256 i; i < length; ) {
      if (debtMarkets[i].asset == asset) {
        debtMarkets[i].balance += balanceToIncrease;
        return;
      }
      unchecked {
        ++i;
      }
    }

    debtMarkets.push(Asset({asset: asset, debt: 0, balance: balanceToIncrease}));
  }

  /**
   * @dev Get the Postion Id based on tokenID and Contract address
   * @param index NFT token ID
   */
  function _getPositionId(uint256 index) private view returns (bytes32) {
    return keccak256(abi.encodePacked(address(this), 'index', index));
  }
}
