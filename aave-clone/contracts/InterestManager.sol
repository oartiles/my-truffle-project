// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract InterestManager {
    uint256 public annualInterestRate; // Porcentaje de interés anual en base 10000 (p.ej., 500 = 5%)

    constructor(uint256 _annualInterestRate) {
        annualInterestRate = _annualInterestRate;
    }

    function calculateInterest(uint256 principal, uint256 timeInDays) public view returns (uint256) {
        // Interés simple: (principal * tasa * tiempo) / (100 * 365)
        return (principal * annualInterestRate * timeInDays) / (10000 * 365);
    }
}

