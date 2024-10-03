const MyToken = artifacts.require('MyToken')
const LendingProtocol = artifacts.require('LendingProtocol')
const LiquidationContract = artifacts.require('LiquidationContract')

module.exports = async function (deployer) {
  deployer.deploy(MyToken, web3.utils.toWei('1000', 'ether'))
  const tokenInstance = await MyToken.deployed()

// Desplegar el protocolo de préstamos
  await deployer.deploy(LendingProtocol, tokenInstance.address)
  const lendingProtocolInstance = await LendingProtocol.deployed()

// Desplegar el contrato de liquidación
  await deployer.deploy(LiquidationContract, tokenInstance.address, lendingProtocolInstance.address)
}
