// SPDX-License-Identifier: GPL-2.0-or-later
// Inspired by Uniswap
pragma solidity =0.7.6;
pragma abicoder v2;

import '@uniswap/swap-router-contracts/contracts/interfaces/ISwapRouter02.sol';

interface IXXXFund2 {

    struct Token {
        address tokenAddress;
        uint256 amount;
    }

    event Initialize(address manager);
    event ManagerDeposit(
        address indexed manager, 
        address token, 
        uint256 amount, 
        uint256 amountETH, 
        uint256 amountUSD
    );
    event ManagerWithdraw(
        address indexed manager, 
        address token, 
        uint256 amount, 
        uint256 amountETH, 
        uint256 amountUSD
    );
    event ManagerFeeIn(
        address indexed investor, 
        address indexed manager, 
        address token, 
        uint256 amount, 
        uint256 amountETH, 
        uint256 amountUSD
    );
    event ManagerFeeOut(
        address indexed manager,
        address token, 
        uint256 amount, 
        uint256 amountETH, 
        uint256 amountUSD
    );
    event InvestorDeposit(
        address indexed investor, 
        address token, 
        uint256 amount, 
        uint256 amountETH, 
        uint256 amountUSD
    );
    event InvestorWithdraw(
        address indexed investor, 
        address token, 
        uint256 amount, 
        uint256 feeAmount, 
        uint256 amountETH, 
        uint256 amountUSD
    );
    event Swap(
        address indexed manager,
        address indexed investor,
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOut,
        uint256 amountETH, 
        uint256 amountUSD
    );
    
    enum V3TradeType{
        EXACT_INPUT,
        EXACT_OUTPUT
    }

    enum V3SwapType{
        SINGLE_HOP,
        MULTI_HOP
    }

    // /**
    //  * V3TradeParams for producing the arguments to send calls to the router.
    //  */
    struct V3TradeParams {
        V3TradeType tradeType;
        V3SwapType swapType;
        address investor;
        address tokenIn;
        address tokenOut;
        address recipient;
        uint24 fee;
        uint256 amountIn;
        uint256 amountOut;
        uint256 amountInMaximum;
        uint256 amountOutMinimum;
        uint160 sqrtPriceLimitX96;
        bytes path;
    }

    function initialize(address _manager) external;    

    function deposit(address _token, uint256 _amount) external payable;
    function withdraw(address _token, uint256 _amount) external payable;
    function swap(
        V3TradeParams[] calldata trades
    ) external payable;

    function feeOut(address _token, uint256 _amount) external payable;

    function getManagerTokenCount() external returns (uint256);
    function getManagerTokens() external returns (Token[] memory);
    function getFeeTokens() external returns (Token[] memory);

    function getInvestorTokenCount(address investor) external returns (uint256);
    function getInvestorTokens(address investor) external returns (Token[] memory);

    function getTokenAmount(address investor, address token) external returns (uint256);
}