// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

// import '../../../lib/morpho-blue/src/interfaces/IMorpho.sol';

import {WAD, MathLib} from '../../../../../contracts/core/vaults/libraries/MathLib.sol';
import {ICuratedVault} from '../../../../../contracts/interfaces/vaults/ICuratedVault.sol';
import {ICuratedVault} from '../../../../../contracts/interfaces/vaults/ICuratedVault.sol';
import {IPool} from '../../../../../contracts/interfaces/IPool.sol';

import {MintableERC20} from '../../../../../contracts/mocks/MintableERC20.sol';
import {MockAggregator} from '../../../../../contracts/mocks/MockAggregator.sol';
import {DefaultReserveInterestRateStrategy} from '../../../../../contracts/periphery/ir/DefaultReserveInterestRateStrategy.sol';

import {DataTypes, PoolSetup} from '../../pool/PoolSetup.sol';

uint256 constant BLOCK_TIME = 1;
uint256 constant MIN_TEST_ASSETS = 1e8;
uint256 constant MAX_TEST_ASSETS = 1e28;
uint184 constant CAP = type(uint128).max;
uint256 constant NB_MARKETS = 30 + 1;

contract BaseTest is PoolSetup {
  using MathLib for uint256;

  address internal OWNER = makeAddr('Owner');
  address internal SUPPLIER = makeAddr('Supplier');
  address internal BORROWER = makeAddr('Borrower');
  address internal REPAYER = makeAddr('Repayer');
  address internal ONBEHALF = makeAddr('OnBehalf');
  address internal RECEIVER = makeAddr('Receiver');
  address internal ALLOCATOR = makeAddr('Allocator');
  address internal CURATOR = makeAddr('Curator');
  address internal GUARDIAN = makeAddr('Guardian');
  address internal FEE_RECIPIENT = makeAddr('FeeRecipient');
  address internal SKIM_RECIPIENT = makeAddr('SkimRecipient');
  address internal MORPHO_OWNER = makeAddr('MorphoOwner');
  address internal MORPHO_FEE_RECIPIENT = makeAddr('MorphoFeeRecipient');

  ICuratedVault internal vault = ICuratedVault(deployCode('CuratedVault.sol'));

  IPool[] internal allMarkets;
  IPool internal idleMarket;

  function setUp() public virtual override {
    super.setUp();
    setupIdleMarket();
    // vm.label(address(morpho), 'Morpho');
    // vm.label(address(loanToken), 'Loan');
    // vm.label(address(collateralToken), 'Collateral');
    // vm.label(address(oracle), 'Oracle');
    // vm.label(address(irm), 'Irm');
    // oracle.setPrice(ORACLE_PRICE_SCALE);
    // irm.setApr(0.5 ether); // 50%.

    // vm.startPrank(MORPHO_OWNER);
    // morpho.enableIrm(address(irm));
    // morpho.setFeeRecipient(MORPHO_FEE_RECIPIENT);

    // morpho.enableLltv(0);
    // vm.stopPrank();

    // morpho.createMarket(idleParams);

    // for (uint256 i; i < NB_MARKETS; ++i) {
    //   uint256 lltv = 0.8 ether / (i + 1);

    //   MarketParams memory marketParams = MarketParams({
    //     loanToken: address(loanToken),
    //     collateralToken: address(collateralToken),
    //     oracle: address(oracle),
    //     irm: address(irm),
    //     lltv: lltv
    //   });

    //   vm.prank(MORPHO_OWNER);
    //   morpho.enableLltv(lltv);

    //   morpho.createMarket(marketParams);

    //   allMarkets.push(marketParams);
    // }

    // allMarkets.push(idleParams); // Must be pushed last.

    // vm.startPrank(SUPPLIER);
    // loanToken.approve(address(morpho), type(uint256).max);
    // collateralToken.approve(address(morpho), type(uint256).max);
    // vm.stopPrank();

    // vm.prank(BORROWER);
    // collateralToken.approve(address(morpho), type(uint256).max);

    // vm.prank(REPAYER);
    // loanToken.approve(address(morpho), type(uint256).max);
  }

  function setupIdleMarket() private {
    address[] memory idleAssets = new address[](1);
    address[] memory idleStrategies = new address[](1);
    address[] memory idleOracles = new address[](1);
    DataTypes.InitReserveConfig[] memory configurationLocal = new DataTypes.InitReserveConfig[](1);

    idleAssets[0] = address(tokenA);
    idleStrategies[0] = address(irStrategy);
    idleOracles[0] = address(oracleA);
    configurationLocal[0] = basicConfig;

    idleMarket = IPool(
      poolFactory.createPool(
        DataTypes.InitPoolParams({
          hook: address(0),
          assets: idleAssets,
          rateStrategyAddresses: idleStrategies,
          sources: idleOracles,
          configurations: configurationLocal
        })
      )
    );
  }

  /// @dev Rolls & warps the given number of blocks forward the blockchain.
  function _forward(uint256 blocks) internal {
    vm.roll(block.number + blocks);
    vm.warp(block.timestamp + blocks * BLOCK_TIME); // Block speed should depend on test network.
  }

  /// @dev Bounds the fuzzing input to a realistic number of blocks.
  function _boundBlocks(uint256 blocks) internal view returns (uint256) {
    return bound(blocks, 2, type(uint24).max);
  }

  // /// @dev Bounds the fuzzing input to a non-zero address.
  // /// @dev This function should be used in place of `vm.assume` in invariant test handler functions:
  // /// https://github.com/foundry-rs/foundry/issues/4190.
  // function _boundAddressNotZero(address input) internal view virtual returns (address) {
  //   return address(uint160(bound(uint256(uint160(input)), 1, type(uint160).max)));
  // }

  // function _accrueInterest(MarketParams memory market) internal {
  //   collateralToken.setBalance(address(this), 1);
  //   morpho.supplyCollateral(market, 1, address(this), hex'');
  //   morpho.withdrawCollateral(market, 1, address(this), address(10));
  // }

  // /// @dev Returns a random market params from the list of markets enabled on Blue (except the idle market).
  // function _randomMarketParams(uint256 seed) internal view returns (MarketParams memory) {
  //   return allMarkets[seed % (allMarkets.length - 1)];
  // }

  // function _randomCandidate(address[] memory candidates, uint256 seed) internal pure returns (address) {
  //   if (candidates.length == 0) return address(0);

  //   return candidates[seed % candidates.length];
  // }

  // function _removeAll(address[] memory inputs, address removed) internal pure returns (address[] memory result) {
  //   result = new address[](inputs.length);

  //   uint256 nbAddresses;
  //   for (uint256 i; i < inputs.length; ++i) {
  //     address input = inputs[i];

  //     if (input != removed) {
  //       result[nbAddresses] = input;
  //       ++nbAddresses;
  //     }
  //   }

  //   assembly {
  //     mstore(result, nbAddresses)
  //   }
  // }

  // function _randomNonZero(address[] memory users, uint256 seed) internal pure returns (address) {
  //   users = _removeAll(users, address(0));

  //   return _randomCandidate(users, seed);
  // }
}
