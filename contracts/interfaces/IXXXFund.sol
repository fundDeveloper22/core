// SPDX-License-Identifier: GPL-2.0-or-later
// Inspired by Uniswap
pragma solidity =0.7.6;
pragma abicoder v2;

import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';

interface IXXXFund {

    struct Token {
        address tokenAddress;
        uint256 amount;
    }

    struct ReservedTokenHistory {
    	string date;
        address tokenAddress;
        uint256 amount;
    }

    struct ManagerHistory {
        string date;
        uint256 fundPrincipalUSD;
        uint256 totalValueUSD;
        uint256 totalValueETH;
        uint256 profitRate;
    }

    event Deposit(address indexed investor, address _token, uint256 _amount);
    event Withdraw(address indexed investor, address _token, uint256 _amount);
    event Swap(
        address indexed manager,
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOut
    );

    function initialize(address _manager) external;
    
    function deposit(address investor, address _token, uint256 _amount) external;
    function withdraw(address _token, address to, uint256 _amount) external;

    function swapExactInputSingle(ISwapRouter.ExactInputSingleParams calldata _params) external returns (uint256 amountOut);
    function swapExactOutputSingle(ISwapRouter.ExactOutputSingleParams calldata _params) external returns (uint256 amountIn);
    //function swapExactInputMultihop(address _token, address to) external;
    //function swapExactOutputMultihop(address _token, address to) external;

    function addReservedTokenHistory() external;
    function getReservedTokenHistory() external returns (ReservedTokenHistory[] calldata);
    function addManagerHistory() external;
    function getManagerHistory() external returns (ManagerHistory[] calldata);
}