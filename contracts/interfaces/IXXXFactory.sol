// SPDX-License-Identifier: GPL-2.0-or-later
// Inspired by Uniswap
pragma solidity =0.7.6;
pragma abicoder v2;

interface IXXXFactory {

    /// @notice Emitted when the owner of the factory is changed
    /// @param oldOwner The owner before the owner was changed
    /// @param newOwner The owner after the owner was changed
    event OwnerChanged(address indexed oldOwner, address indexed newOwner);
    event Subscribe(address indexed fund, address indexed manager, address indexed investor);
    event FundCreated(address indexed fund, address indexed manager);

    /// @notice Returns the current owner of the factory
    /// @dev Can be changed by the current owner via setOwner
    /// @return The address of the factory owner
    function owner() external view returns (address);
    function managerFee() external view returns (uint256);
    function minWETHVolume() external view returns (uint256);
    function whiteListTokens(address _token) external view returns (bool);

    function createFund() external returns (address fund);

    /// @notice Updates the owner of the factory
    /// @dev Must be called by the current owner
    /// @param _owner The new owner of the factory
    function setOwner(address _owner) external;
    function setMinWETHVolume(uint256 volume) external;
    function setManagerFee(uint256 _managerFee) external;

    function isSubscribed(address investor, address fund) external view returns (bool);
    function subscribedFunds(address investor) external view returns (address[] memory);
    function subscribe(address fund) external;

    function setWhiteListToken(address _token) external;
    function resetWhiteListToken(address _token) external;
}