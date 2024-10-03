const MyToken = artifacts.require('MyToken')
const InterestManager = artifacts.require('InterestManager')
const LendingProtocol = artifacts.require('LendingProtocol')
const ChainlinkOracle = artifacts.require('ChainlinkOracle')

module.exports = async function (deployer) {
  const initialSupply = web3.utils.toWei('1000', 'ether')
  await deployer.deploy(MyToken, initialSupply)
  const token = await MyToken.deployed()

  await deployer.deploy(InterestManager)
  const interestManager = await InterestManager.deployed()

  const priceFeedAddress = '0x...'
  // Dirección del contrato de Chainlink para ETH/USD
  await deployer.deploy(ChainlinkOracle, priceFeedAddress)
  const oracle = await ChainlinkOracle.deployed()

  await deployer.deploy(LendingProtocol, token.address, interestManager.address, oracle.address)
}
