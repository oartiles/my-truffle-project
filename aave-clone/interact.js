const Web3 = require('web3')
const MyToken = artifacts.require('MyToken')
const DepositContract = artifacts.require('DepositContract')

module.exports = async function (callback) {
  try {
    const web3 = new Web3('http://127.0.0.1:7545')
    // Asegúrate de que este puerto coincida con el de tu red local (por ejemplo, Ganache)
    const accounts = await web3.eth.getAccounts()
    const user = accounts[1]

    const tokenInstance = await MyToken.deployed()
    const depositInstance = await DepositContract.deployed()

// Aprobar y depositar tokens
    await tokenInstance.approve(depositInstance.address, web3.utils.toWei('100', 'ether'), { from: user })
    await depositInstance.deposit(web3.utils.toWei('100', 'ether'), { from: user })

// Verificar el balance después del depósito
    let balance = await depositInstance.balances(user)
    console.log('Balance after deposit:', balance.toString())

// Retirar tokens
    await depositInstance.withdraw(web3.utils.toWei('50', 'ether'), { from: user })

// Verificar el balance después del retiro
    balance = await depositInstance.balances(user)
    console.log('Balance after withdrawal:', balance.toString())

    callback()
  } catch (error) {
    console.error(error)
    callback(error)
  }
}
