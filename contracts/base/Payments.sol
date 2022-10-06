// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;
pragma abicoder v2;

import '../interfaces/IERC20.sol';
import '../interfaces/external/IWETH9.sol';
import './Constants.sol';

abstract contract Payments is Constants {

    function _withdraw(address _token, uint256 _amount) internal {
        if (_token == WETH9) {
            IWETH9(WETH9).withdraw(_amount);
            (bool success, ) = payable(msg.sender).call{value: _amount}(new bytes(0));
            require(success, 'withdraw() => sending ETH to manager failed');
        } else {
            IERC20(_token).transfer(msg.sender, _amount);
        }
    }
}