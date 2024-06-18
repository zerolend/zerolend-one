// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.8.19;

import {INFTPositionManager} from './INFTPositionManager.sol';
import {ERC721PositionManager} from './ERC721PositionManager.sol';
import {IPool} from './../../pools/interfaces/IPoolNew.sol';

contract NFTPositionManager is INFTPositionManager, ERC721PositionManager {
  /// @dev The ID of the next token that will be minted. Skips 0
  uint256 private _nextId = 1;
  mapping(uint256 tokenId => Position) public positions;

  constructor(string memory _name, string memory _symbol) ERC721PositionManager(_name, _symbol) {}

  function mint(MintParams calldata params) external returns (uint256 tokenId) {
    IPool pool = IPool(params.pool);

    pool.supply(params.token, params.amount, params.recipient, _nextId);

    _mint(params.recipient, (tokenId = _nextId++));
    Pair[] memory marketPair = new Pair[](1);
    Pair[] memory debtPair;
    marketPair[0] = Pair({market: params.token, amount: params.amount});

    positions[tokenId] = Position({
      markets: marketPair,
      debts: debtPair,
      pool: params.pool,
      operator: address(0)
    });
  }
}
