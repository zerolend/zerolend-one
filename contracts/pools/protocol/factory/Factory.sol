// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import {IBeacon} from '@openzeppelin/contracts/proxy/beacon/IBeacon.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';
import {BeaconProxy} from './BeaconProxy.sol';

contract Factory is IBeacon, Ownable {
  mapping(address => mapping(address => address)) public getPool;
  address[] public allPools;
  address public implementation;

  event PoolCreated(address indexed pool, uint256 indexed index, address creator);
  event ImplementationUpdated(address indexed oldImpl, address indexed newImpl, address owner);

  constructor(address impl) {
    setImplementation(impl);
  }

  function poolsLength() external view returns (uint) {
    return allPools.length;
  }

  function createPool(bytes memory _data) external returns (address pool) {
    pool = address(new BeaconProxy(implementation, msg.sender, _data));
    allPools.push(pool);
    emit PoolCreated(pool, allPools.length, msg.sender);
  }

  function setImplementation(address impl) public onlyOwner {
    address old = implementation;
    implementation = impl;
    emit ImplementationUpdated(old, impl, msg.sender);
  }
}
