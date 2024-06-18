// SPDX-License-Identifier: AGPL-3.0
pragma solidity 0.8.19;
import '@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol';

abstract contract ERC721PositionManager is ERC721Enumerable {
  constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

  // The following functions are overrides required by Solidity.

  function supportsInterface(
    bytes4 interfaceId
  ) public view override(ERC721Enumerable) returns (bool) {
    return super.supportsInterface(interfaceId);
  }
}
