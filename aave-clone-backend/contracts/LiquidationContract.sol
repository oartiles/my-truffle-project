// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LendingProtocol {
    IERC20 public token;
    mapping(address => uint256) public loans;

    constructor(IERC20 _token) {
        token = _token;
    }

    function borrow(uint256 amount) public {
        // Implementar lógica de préstamo y colateral
        loans[msg.sender] += amount;
        require(token.transfer(msg.sender, amount), "Transfer failed");
    }

    function repay(uint256 amount) public {
        require(loans[msg.sender] >= amount, "Overpaying loan");
        loans[msg.sender] -= amount;
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
    }
}

contract LiquidationContract {IERC20 public token;
    LendingProtocol public lendingProtocol;

    constructor(IERC20 _token, LendingProtocol _lendingProtocol) {
        token = _token;
        lendingProtocol = _lendingProtocol;
    }

    function liquidate(address borrower) public {
        uint256 loanAmount = lendingProtocol.loans(borrower);
        require(token.transferFrom(msg.sender, address(this), loanAmount), "Transfer failed");
        lendingProtocol.repay(loanAmount);
    }
}
