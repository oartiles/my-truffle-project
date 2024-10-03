// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./LendingProtocol.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LiquidationManager {
    IERC20 public token;
    LendingProtocol public lendingProtocol;

    constructor(IERC20 _token, LendingProtocol _lendingProtocol) {
        token = _token;
        lendingProtocol = _lendingProtocol;
    }

    function liquidate(address borrower) public {
        // Implementar lógica de liquidación
        uint256 loanAmount = lendingProtocol.loans(borrower);
        require(token.transferFrom(msg.sender, address(this), loanAmount), "Transfer failed");
        lendingProtocol.repay(loanAmount);
    }
}
