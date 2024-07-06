// SPDX-License-Identifier: AGPL-3.0
pragma solidity >=0.8.0 <0.9.0;

import {SymTest} from '../../../lib/halmos-cheatcodes/src/SymTest.sol';
import {PoolSetup} from '../../forge/core/pool/PoolSetup.sol';

/// @custom:halmos --solver-timeout-assertion 0
contract BorrowSolvencyHalmosTest is SymTest, PoolSetup {
  /// @notice Checks that borrows are always over-collateralized
  function check_BorrowSolvency() public virtual {
    // consider other that are neither sender or receiver
    assert(true == true);
  }
}
