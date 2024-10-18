// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Script} from 'forge-std/Script.sol';

abstract contract Deploy is Script {
  // Deployer EOA
  address public owner;
  uint256 internal _deployerPk;

  function setUp() public virtual {
    // Sepolia
    _deployerPk = vm.envUint('DEPLOYER_PK');
    owner = vm.envAddress('SEPOLIA_DEPLOYER_ADDRESS');
  }

  function run() public {
    vm.startBroadcast();
    vm.stopBroadcast();
  }
}
