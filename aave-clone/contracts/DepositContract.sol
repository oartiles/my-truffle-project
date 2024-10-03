// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title DepositContract
/// @dev Este contrato maneja los depósitos y retiros de tokens ERC20.
contract DepositContract {
    IERC20 public token;
    mapping(address => uint256)
    public balances;

/// @dev Constructor que inicializa el contrato con la dirección del token ERC20.
/// @param _token La dirección del contrato del token ERC20.
    constructor(IERC20 _token) {
        token = _token;
    }

/// @dev Permite a los usuarios depositar tokens en el contrato.
/// @param amount La cantidad de tokens a depositar.
    function deposit(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        token.transferFrom(msg.sender, address(this), amount);
        balances[msg.sender] += amount;
    }

/// @dev Permite a los usuarios retirar tokens del contrato.
/// @param amount La cantidad de tokens a retirar.
    function withdraw(uint256 amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amount;
        token.transfer(msg.sender, amount);
    }

/// @dev Devuelve el balance de un usuario.
/// @param user La dirección del usuario.
/// @return El balance del usuario.
    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }
}
