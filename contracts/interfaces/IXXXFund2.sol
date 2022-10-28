// SPDX-License-Identifier: GPL-2.0-or-later
// Inspired by Uniswap
pragma solidity =0.7.6;
pragma abicoder v2;

import './IToken.sol';

interface IXXXFund2 is IToken {

    enum SwapType{
        EXACT_INPUT_SINGLE_HOP,
        EXACT_INPUT_MULTI_HOP,
        EXACT_OUTPUT_SINGLE_HOP,
        EXACT_OUTPUT_MULTI_HOP
    }

    struct SwapParams {
        SwapType swapType;
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

    // position deposit
    /// @notice Represents the deposit of an NFT
    struct pDeposit {
        address owner;
        uint128 liquidity;
        address token0;
        address token1;
    }

    struct MintPositionParams {
        address investor;
        address token0;
        address token1;
        uint24 fee;
        int24 tickLower;
        int24 tickUpper;
        uint256 amount0Desired;
        uint256 amount1Desired;
        uint256 amount0Min;
        uint256 amount1Min;
        uint256 deadline;
    }
        
    struct IncreaseLiquidityParams {
        address investor;
        uint256 tokenId;
        uint256 amount0Desired;
        uint256 amount1Desired;
        uint256 amount0Min;
        uint256 amount1Min;
        uint256 deadline;
    }

    struct CollectFeeParams {
        address investor;
        uint256 tokenId;
        uint128 amount0Max;
        uint128 amount1Max;
    }

    struct DecreaseLiquidityParams {
        address investor;
        uint256 tokenId;
        uint128 liquidity;
        uint256 amount0Min;
        uint256 amount1Min;
        uint256 deadline;
    }

    event Initialize(address indexed fund, address manager);
    event ManagerFeeIn(
        address indexed fund,
        address indexed investor,
        address indexed manager,
        address token,
        uint256 amount,
        uint256 amountETH
    );
    event ManagerFeeOut(
        address indexed fund,
        address indexed manager,
        address token,
        uint256 amount,
        uint256 amountETH
    );
    event Deposit(
        address indexed fund,
        address indexed manager,
        address indexed investor,
        address token,
        uint256 amount,
        uint256 amountETH
    );
    event Withdraw(
        address indexed fund,
        address indexed manager,
        address indexed investor,
        address token,
        uint256 amount,
        uint256 feeAmount,
        uint256 amountETH
    );
    event Swap(
        address indexed fund,
        address indexed manager,
        address indexed investor,
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOut,
        uint256 amountETH
    );

    function manager() external view returns (address);

    function initialize(address _manager) external;    
    function deposit(address _token, uint256 _amount) external payable;
    function withdraw(address _token, uint256 _amount) external payable;
    function swap(
        SwapParams[] memory trades
    ) external payable;
    function mintNewPosition(MintLiquidityParams calldata params) external returns (uint256 tokenId, uint128 liquidity, uint256 amount0, uint256 amount1);
    function increaseLiquidity(IncreaseLiquidityParams calldata params) external returns (uint128 liquidity, uint256 amount0, uint256 amount1);
    function collectAllFees(CollectLiquidityParams calldata params) external returns (uint256 amount0, uint256 amount1);
    function decreaseLiquidity(DecreaseLiquidityParams calldata params) external returns (uint256 amount0, uint256 amount1);

    function feeOut(address _token, uint256 _amount) external payable;

    function getInvestorTokens(address investor) external returns (Token[] memory);
    function getFeeTokens() external returns (Token[] memory);
    function getInvestorTokenAmount(address investor, address token) external returns (uint256);

    function getInvestorTotalValueLockedETH(address investor) external returns (uint256);
    function getManagerFeeTotalValueLockedETH() external returns (uint256);
    function getETHPriceInUSD() external returns (uint256);
}