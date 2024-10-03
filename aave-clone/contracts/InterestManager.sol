// SPDX-License-Identifier: MIT pragma solidity ^0.8.0;

contract InterestManager {
    uint256 public interestRate;

    constructor(uint256 _interestRate) {
        interestRate = _interestRate;
    }

    function calculateInterest(uint256 principal, uint256 timeInYears) public view returns (uint256) {
        return (principal * interestRate * timeInYears) / 100;
    }
}
