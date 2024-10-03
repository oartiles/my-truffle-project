// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./InterestManager.sol";

contract LendingProtocol {
    IERC20 public token;
    InterestManager public interestManager;
    mapping(address => uint256) public loans;
    mapping(address => uint256) public loanStartTimes;

    constructor(IERC20 _token, InterestManager _interestManager) {
        token = _token;
        interestManager = _interestManager;
    }

    function borrow(uint256 amount) public {
        // Implementar lógica de préstamo y colateral
        loans[msg.sender] += amount;
        loanStartTimes[msg.sender] = block.timestamp;
        require(token.transfer(msg.sender, amount), "Transfer failed");
    }

    function repay(uint256 amount) public {
        uint256 loanDuration = (block.timestamp - loanStartTimes[msg.sender]) / 1 days;
        uint256 interest = interestManager.calculateInterest(loans[msg.sender], loanDuration);
        uint256 totalRepayment = loans[msg.sender] + interest;

        require(amount >= totalRepayment, "Insufficient amount to repay loan and interest");
        loans[msg.sender] = 0;
        loanStartTimes[msg.sender] = 0;
        require(token.transferFrom(msg.sender, address(this), totalRepayment), "Transfer failed");
    }
}
