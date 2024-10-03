const ChainlinkOracle = artifacts.require('ChainlinkOracle')

module.exports = function (deployer) {
  const priceFeedAddress = '0x...'
// Dirección del contrato de Chainlink para ETH/USD
  deployer.deploy(ChainlinkOracle, priceFeedAddress)
}
