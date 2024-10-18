// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

interface IAccessControl {
    error NotRegistered(address usuario);
    error NotAdmin(address usuario);

    function isRegistered(address user) external view returns (bool);
    function isRegisteredBefore(address user, uint256 timestamp) external view returns (bool);
    function getRegisteredUsersCount() external view returns (uint256);
    function isAdmin(address user) external view returns (bool);
    function submit(address user, uint256) external;
    function approveUser(address user) external;
    function disapproveUser(address user) external;
}
