import { BigNumber, ContractTransaction } from 'ethers'
import { XXXFund2 } from '../../typechain-types/contracts/XXXFund2'
import { encodePath } from './path'
import { ethers } from 'hardhat'
import {
	NULL_ADDRESS,
	FeeAmount
} from "./constants"

export enum SwapType {
  EXACT_INPUT_SINGLE_HOP = 0,
  EXACT_INPUT_MULTI_HOP = 1,
  EXACT_OUTPUT_SINGLE_HOP = 2,
  EXACT_OUTPUT_MULTI_HOP = 3
}

export interface SwapParams {
  swapType: number
  investor: string
  tokenIn: string
  tokenOut: string
  recipient: string
  fee: number
  amountIn: BigNumber
  amountOut: BigNumber
  amountInMaximum: BigNumber
  amountOutMinimum: BigNumber
  sqrtPriceLimitX96: BigNumber
  path: string
}

export function exactInputSingleParams(
	investor: string,
  tokenIn: string,
  tokenOut: string,
  amountIn: BigNumber,
  amountOutMinimum: BigNumber,
  sqrtPriceLimitX96: BigNumber,
	fundAddress: string
): SwapParams[] {
	const params: SwapParams[] = [
		{
      swapType: SwapType.EXACT_INPUT_SINGLE_HOP,
      investor: investor,
      tokenIn: tokenIn,
      tokenOut: tokenOut,
      recipient: fundAddress,
      fee: FeeAmount.MEDIUM,
      amountIn,
      amountOut: BigNumber.from(0),
      amountInMaximum: BigNumber.from(0),
      amountOutMinimum,
      sqrtPriceLimitX96: sqrtPriceLimitX96 ?? BigNumber.from(0),
      path: '0x1234' // path is not used
		}
	]
	return params
}

export function exactOutputSingleParams(
	investor: string,
  tokenIn: string,
  tokenOut: string,
  amountOut: BigNumber,
  amountInMaximum: BigNumber,
  sqrtPriceLimitX96: BigNumber,
	fundAddress: string
): SwapParams[] {
	const params: SwapParams[] = [
		{
	    swapType: SwapType.EXACT_OUTPUT_SINGLE_HOP,
	    investor: investor,
	    tokenIn: tokenIn,
	    tokenOut: tokenOut,
	    recipient: fundAddress,
	    fee: FeeAmount.MEDIUM,
	    amountIn: BigNumber.from(0),
	    amountOut,
	    amountInMaximum,
	    amountOutMinimum: BigNumber.from(0),
	    sqrtPriceLimitX96: sqrtPriceLimitX96 ?? BigNumber.from(0),
	    path: '0x1234' // path is not used
		}
	]
	return params
}

export function exactInputParams(
	investor: string,
	tokens: string[],
  amountIn: BigNumber,
  amountOutMinimum: BigNumber,
	fundAddress: string
): SwapParams[] {
  const path = encodePath(tokens, new Array(tokens.length - 1).fill(FeeAmount.MEDIUM))
	const params: SwapParams[] = [
		{
			swapType: SwapType.EXACT_INPUT_MULTI_HOP,
			investor: investor,
			tokenIn: NULL_ADDRESS,
			tokenOut: NULL_ADDRESS,
			recipient: fundAddress,
			fee: 0,
      amountIn,
      amountOut: BigNumber.from(0),
      amountInMaximum: BigNumber.from(0),
      amountOutMinimum,
			sqrtPriceLimitX96: BigNumber.from(0),
			path: path
		}
	]
	return params
}

export function exactOutputParams(
	investor: string,
	tokens: string[],
	amountOut: BigNumber,
	amountInMaximum: BigNumber,
	fundAddress: string
): SwapParams[] {
	const path = encodePath(tokens.slice().reverse(), new Array(tokens.length - 1).fill(FeeAmount.MEDIUM))
	const params: SwapParams[] = [
		{
			swapType: SwapType.EXACT_OUTPUT_MULTI_HOP,
			investor: investor,
			tokenIn: NULL_ADDRESS,
			tokenOut: NULL_ADDRESS,
			recipient: fundAddress,
			fee: 0,
			amountIn: BigNumber.from(0),
			amountOut,
			amountInMaximum,
			amountOutMinimum: BigNumber.from(0),
			sqrtPriceLimitX96: BigNumber.from(0),
			path: path
		}
	]
	return params
}