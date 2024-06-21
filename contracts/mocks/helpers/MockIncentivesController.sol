// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {IAaveIncentivesController} from '../../core/interfaces/IAaveIncentivesController.sol';

contract MockIncentivesController is IAaveIncentivesController {
  function handleAction(address, uint256, uint256) external override {}
}
