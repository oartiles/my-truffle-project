// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

/// @title ChainlinkOracle
/// @dev Este contrato utiliza Chainlink para obtener el precio de ETH en USD.
contract ChainlinkOracle {AggregatorV3Interface internal priceFeed;

/// @dev Constructor que inicializa el contrato con la dirección del contrato de Chainlink.
/// @param _priceFeed La dirección del contrato de Chainlink.
    constructor(address _priceFeed) {
        priceFeed = AggregatorV3Interface(_priceFeed);
    }

/// @dev Obtiene el precio actual de ETH en USD.
/// @return El precio actual de ETH en USD.
    function getLatestPrice() public view returns (int) {
        (
/*uint80 roundID*/,
            int price,
/*uint startedAt*/,
/*uint timeStamp*/,
/*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }
}
