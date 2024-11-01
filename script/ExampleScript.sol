// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {AccessControl} from '../src/contracts/AccessControl.sol';
import {IAccessControl} from '../src/interfaces/IAccessControl.sol';
import {Script} from 'forge-std/Script.sol';
import {console} from 'forge-std/console.sol';

contract ExampleScript is Script {
  function run() public {
    uint256 deployerPk = vm.envUint('SEPOLIA_DEPLOYER_PK');
    console.log('Deployer address', vm.addr(deployerPk));

    uint256 adminPk = vm.envUint('SEPOLIA_ADMIN_PK');
    address adminAddress = vm.addr(adminPk);
    console.log('Admin address', adminAddress);

    address user = address(8);
    console.log('User address', user);
    uint256 numOperationMP = 8;

    vm.startBroadcast(deployerPk);
    console.log('Connected with deployer: ', vm.addr(deployerPk));

    // Deploy AccessControl
    AccessControl myContract = new AccessControl(adminAddress);
    address myContractAddress = address(myContract);
    console.log('AccessControl contract address', myContractAddress);

    // Submit user
    myContract.submit(user, numOperationMP);
    console.log('User submitted');

    vm.stopBroadcast();

    vm.startBroadcast(adminPk);

    console.log('Connected with admin: ', vm.addr(adminPk));

    // Approve user
    myContract.approveUser(user);
    console.log('User approved');

    vm.stopBroadcast();
  }
}
