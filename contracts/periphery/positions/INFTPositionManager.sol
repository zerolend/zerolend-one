// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.8.19;

interface INFTPositionManager {
  /// @notice Error indicating that the caller is not the owner or approved operator of the token ID.
  error NotTokenIdOwner();
  /// @notice Error indicating that it is an Zero Address which is not allowed
  error ZeroAddressNotAllowed();
  /// @notice Error indicating that value that is passed is zero which is not allowed
  error ZeroValueNotAllowed();

  /// @notice Error indicating that value that the address is invalid and not present in debt market
  error InvalidMarketAddress();

  /**
   * @notice Emitted when an NFT is minted.
   * @param recipient The address that received the minted NFT.
   * @param tokenId The ID of the minted NFT.
   */
  event NFTMinted(address indexed recipient, uint256 indexed tokenId);
  /**
   * @notice Emitted when an NFT is burned.
   * @param tokenId The ID of the burned NFT.
   */
  event NFTBurned(uint256 indexed tokenId);

  struct MintParams {
    address market;
    address recipient;
    address pool;
    uint256 amount;
  }

  struct Pair {
    address market;
    uint256 balance;
  }

  struct Position {
    Pair[] supplyMarkets;
    Pair[] debtMarkets;
    address pool;
    address operator;
  }

  struct AddLiquidityParams {
    uint256 tokenId;
    address market;
    address recipient;
    uint256 amount;
  }

  struct BorrowParams {
    uint256 tokenId;
    address market;
    uint256 amount;
  }

  struct RepayParams {
    uint256 tokenId;
    address market;
    uint256 amount;
  }

  struct WithdrawParams {
    uint256 tokenId;
    address market;
    address recipient;
    uint256 amount;
  }
}
