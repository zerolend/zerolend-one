// SPDX-License-Identifier: AGPL-3.0
pragma solidity >=0.8.0 <0.9.0;

import {SymTest} from '../../../lib/halmos-cheatcodes/src/SymTest.sol';
import {PoolSetup} from '../../forge/core/pool/PoolSetup.sol';

contract BorrowSolvencyHalmosTest is SymTest, PoolSetup {
  /// @notice Checks that borrows are always over-collateralized
  function checkBorrowSolvency() public virtual {
    // consider other that are neither sender or receiver
  }
}
