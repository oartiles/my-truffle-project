// SPDX-License-Identifier: MIT pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LendingProtocol {
    IERC20 public token;
    mapping(address => uint256) public deposits;
    mapping(address => uint256) public loans;

    constructor(IERC20 _token) {
        token = _token;
    }

    function deposit(uint256 amount) public {
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        deposits[msg.sender] += amount;
    }

    function withdraw(uint256 amount) public {
        require(deposits[msg.sender] >= amount, "Insufficient balance");
        deposits[msg.sender] -= amount;
        require(token.transfer(msg.sender, amount), "Transfer failed");
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
