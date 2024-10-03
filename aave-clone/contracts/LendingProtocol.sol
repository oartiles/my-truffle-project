// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./InterestManager.sol";
import "./ChainlinkOracle.sol";

/// @title LendingProtocol
/// @dev Este contrato maneja los préstamos y los pagos de intereses.
contract LendingProtocol {
    IERC20 public token;
    InterestManager public interestManager;
    ChainlinkOracle public oracle;
    mapping(address => uint256)
    public loans;
    mapping(address => uint256)
    public loanStartTimes;
    mapping(address => uint256)
    public collaterals;

/// @dev Constructor que inicializa el contrato con la dirección del token ERC20, el contrato de gestión de intereses y el oráculo.
/// @param _token La dirección del contrato del token ERC20.
/// @param _interestManager La dirección del contrato de gestión de intereses.
/// @param _oracle La dirección del contrato del oráculo.
    constructor(IERC20 _token, InterestManager _interestManager, ChainlinkOracle _oracle) {
        token = _token;
        interestManager = _interestManager;
        oracle = _oracle;
    }

/// @dev Permite a los usuarios pedir prestado tokens proporcionando un colateral.
/// @param amount La cantidad de tokens a pedir prestado.
/// @param collateralAmount La cantidad de tokens a proporcionar como colateral.
    function borrow(uint256 amount, uint256 collateralAmount) public {
        int assetPrice = oracle.getLatestPrice();
        uint256 collateralValue = collateralAmount * uint256(assetPrice);
        require(collateralValue >= amount, "Collateral value must be at least equal to the loan amount");
        require(token.transferFrom(msg.sender, address(this), collateralAmount), "Collateral transfer failed");

        loans[msg.sender] += amount;
        collaterals[msg.sender] += collateralAmount;
        loanStartTimes[msg.sender] = block.timestamp;
        require(token.transfer(msg.sender, amount), "Loan transfer failed");
    }

/// @dev Permite a los usuarios devolver los tokens prestados junto con los intereses y recuperar su colateral.
/// @param amount La cantidad de tokens a devolver.
    function repay(uint256 amount) public {
        uint256 loanDuration = (block.timestamp - loanStartTimes[msg.sender]) / 1 days;
        uint256 interest = interestManager.calculateInterest(loans[msg.sender], loanDuration);
        uint256 totalRepayment = loans[msg.sender] + interest;

        require(amount >= totalRepayment, "Insufficient amount to repay loan and interest");
        loans[msg.sender] = 0;
        loanStartTimes[msg.sender] = 0;
        require(token.transferFrom(msg.sender, address(this), totalRepayment), "Repayment transfer failed");

        uint256 collateralToReturn = collaterals[msg.sender];
        collaterals[msg.sender] = 0;
        require(token.transfer(msg.sender, collateralToReturn), "Collateral return failed");
    }
}
