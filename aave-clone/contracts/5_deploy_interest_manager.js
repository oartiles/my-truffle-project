const MyToken = artifacts.require('MyToken')
const InterestManager = artifacts.require('InterestManager')
const LendingProtocol = artifacts.require('LendingProtocol')

module.exports = async function (deployer) {
  const tokenInstance = await MyToken.deployed()

  await deployer.deploy(InterestManager, 500)
// 5% de interés anual
  const interestManagerInstance = await InterestManager.deployed()
  await deployer.deploy(LendingProtocol, tokenInstance.address, interestManagerInstance.address)
}

