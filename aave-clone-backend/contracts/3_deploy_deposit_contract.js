const MyToken = artifacts.require('MyToken')
const DepositContract = artifacts.require('DepositContract')

module.exports = async function (deployer) {
  await deployer.deploy(MyToken, web3.utils.toWei('1000', 'ether'))
  const tokenInstance = await MyToken.deployed()
  await deployer.deploy(DepositContract, tokenInstance.address)
}
