// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {
  CuratedErrorsLib,
  CuratedEventsLib,
  CuratedVault,
  PendingAddress,
  PendingUint192
} from '../../../../../contracts/core/vaults/CuratedVault.sol';
import {CuratedVaultFactory, ICuratedVaultFactory} from '../../../../../contracts/core/vaults/CuratedVaultFactory.sol';
import './BaseVaultTest.sol';

uint256 constant TIMELOCK = 1 weeks;

abstract contract IntegrationVaultTest is BaseVaultTest {
  using MathLib for uint256;

  ICuratedVault internal vault;
  ICuratedVaultFactory internal vaultFactory;

  function setUp() public virtual override {
    super.setUp();

    CuratedVault instance = new CuratedVault();
    vaultFactory = ICuratedVaultFactory(new CuratedVaultFactory(address(instance)));

    vault = vaultFactory.createVault(
      OWNER, // address initialOwner,
      OWNER, // address initialProxyOwner,
      TIMELOCK, // uint256 initialTimelock,
      address(loanToken), // address asset,
      'TEST Vault', // string memory name,
      'TV', // string memory symbol,
      keccak256('salty') // bytes32 salt
    );

    vm.startPrank(OWNER);
    vault.grantCuratorRole(CURATOR);
    vault.grantAllocatorRole(ALLOCATOR);
    vault.setFeeRecipient(FEE_RECIPIENT);
    vault.setSkimRecipient(SKIM_RECIPIENT);
    vm.stopPrank();

    _setCap(idleMarket, type(uint184).max);

    loanToken.approve(address(vault), type(uint256).max);
    collateralToken.approve(address(vault), type(uint256).max);

    vm.startPrank(SUPPLIER);
    loanToken.approve(address(vault), type(uint256).max);
    collateralToken.approve(address(vault), type(uint256).max);
    vm.stopPrank();

    vm.startPrank(ONBEHALF);
    loanToken.approve(address(vault), type(uint256).max);
    collateralToken.approve(address(vault), type(uint256).max);
    vm.stopPrank();
  }

  function _idle() internal view returns (uint256) {
    return idleMarket.supplyAssets(address(loanToken), vault.positionId());
  }

  function _setTimelock(uint256 newTimelock) internal {
    uint256 timelock = vault.timelock();
    if (newTimelock == timelock) return;

    // block.timestamp defaults to 1 which may lead to an unrealistic state: block.timestamp < timelock.
    if (block.timestamp < timelock) vm.warp(block.timestamp + timelock);

    PendingUint192 memory pendingTimelock = vault.pendingTimelock();
    if (pendingTimelock.validAt == 0 || newTimelock != pendingTimelock.value) {
      vm.prank(OWNER);
      vault.submitTimelock(newTimelock);
    }

    if (newTimelock > timelock) return;

    vm.warp(block.timestamp + timelock);
    vault.acceptTimelock();
    assertEq(vault.timelock(), newTimelock, '_setTimelock');
  }

  function _setGuardian(address newGuardian) internal {
    vm.prank(OWNER);
    vault.grantGuardianRole(newGuardian);
  }

  function _setFee(uint256 newFee) internal {
    uint256 fee = vault.fee();
    if (newFee == fee) return;

    vm.prank(OWNER);
    vault.setFee(newFee);

    assertEq(vault.fee(), newFee, '_setFee');
  }

  function _setCap(IPool pool, uint256 newCap) internal {
    uint256 cap = vault.config(pool).cap;
    bool isEnabled = vault.config(pool).enabled;
    if (newCap == cap) return;

    PendingUint192 memory pendingCap = vault.pendingCap(pool);
    if (pendingCap.validAt == 0 || newCap != pendingCap.value) {
      vm.prank(CURATOR);
      vault.submitCap(pool, newCap);
    }

    if (newCap < cap) return;

    vm.warp(block.timestamp + vault.timelock());

    vault.acceptCap(pool);

    assertEq(vault.config(pool).cap, newCap, '_setCap');

    if (newCap > 0) {
      if (!isEnabled) {
        IPool[] memory newSupplyQueue = new IPool[](vault.supplyQueueLength() + 1);
        for (uint256 k; k < vault.supplyQueueLength(); k++) {
          newSupplyQueue[k] = vault.supplyQueue(k);
        }
        newSupplyQueue[vault.supplyQueueLength()] = pool;
        vm.prank(ALLOCATOR);
        vault.setSupplyQueue(newSupplyQueue);
      }
    }
  }

  function _sortSupplyQueueIdleLast() internal {
    IPool[] memory supplyQueue = new IPool[](vault.supplyQueueLength());

    uint256 supplyIndex;
    for (uint256 i; i < supplyQueue.length; ++i) {
      IPool id = vault.supplyQueue(i);
      if (id == idleMarket) continue;

      supplyQueue[supplyIndex] = id;
      ++supplyIndex;
    }

    supplyQueue[supplyIndex] = idleMarket;
    ++supplyIndex;

    assembly {
      mstore(supplyQueue, supplyIndex)
    }

    vm.prank(ALLOCATOR);
    vault.setSupplyQueue(supplyQueue);
  }
}
