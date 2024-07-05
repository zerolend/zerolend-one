// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import './helpers/IntegrationVaultTest.sol';

import '../../../../contracts/core/vaults/CuratedVaultFactory.sol';
import '../../../../contracts/core/vaults/CuratedVault.sol';

contract CuratedVaultFactoryTest is IntegrationVaultTest {
  event VaultCreated(
    ICuratedVault indexed vault,
    uint256 indexed index,
    address creator,
    address initialOwner,
    address initialProxyOwner,
    uint256 initialTimelock,
    address asset,
    string name,
    string symbol,
    bytes32 salt
  );

  function testCreateVault(address initialOwner, uint256 initialTimelock, string memory name, string memory symbol, bytes32 salt) public {
    vm.assume(address(initialOwner) != address(0));
    initialTimelock = bound(initialTimelock, 1 days, 2 weeks);

    bytes32 initCodeHash = hashInitCode(type(RevokableBeaconProxy).creationCode, abi.encode(address(vaultFactory), initialOwner));
    address expectedAddress = computeCreate2Address(salt, initCodeHash, address(vaultFactory));

    vm.expectEmit(address(vaultFactory));
    emit VaultCreated(
      ICuratedVault(expectedAddress),
      uint256(2),
      address(this),
      initialOwner,
      initialOwner,
      initialTimelock,
      address(loanToken),
      name,
      symbol,
      salt
    );

    ICuratedVault vault = vaultFactory.createVault(initialOwner, initialOwner, initialTimelock, address(loanToken), name, symbol, salt);

    assertEq(expectedAddress, address(vault), 'computeCreate2Address');
    assertTrue(vaultFactory.isVault(address(vault)), 'isvault');
    assertTrue(vault.isOwner(initialOwner), 'owner');
    assertEq(vault.timelock(), initialTimelock, 'timelock');
    assertEq(vault.asset(), address(loanToken), 'asset');
    assertEq(vault.name(), name, 'name');
    assertEq(vault.symbol(), symbol, 'symbol');
  }
}
