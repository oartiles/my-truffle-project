// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

/// @title Oracle
/// @dev Este contrato proporciona el valor actual de los activos.
contract Oracle {
    mapping(string => uint256)
    public assetPrices;

/// @dev Establece el precio de un activo.
/// @param asset El nombre del activo.
/// @param price El precio del activo.
    function setAssetPrice(string memory asset, uint256 price) public {
        assetPrices[asset] = price;
    }

/// @dev Obtiene el precio de un activo.
/// @param asset El nombre del activo.
/// @return El precio del activo.
    function getAssetPrice(string memory asset) public view returns (uint256) {
        return assetPrices[asset];
    }
}
