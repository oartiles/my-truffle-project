import logo from './logo.svg'
import './App.css'
import { useState } from 'react'

function App () {
  const [currentBalance, setCurrentBalance] = useState(0)

  window.web3 = new Web3(window.ethereum)
  window.ethereum.enable()

  const contractAddress = 'TU_DIRECCION_DE_CONTRATO'
  const contractABI =
    [{
      'constant': true,
      'inputs': [{ 'name': 'user', 'type': 'address' }],
      'name': 'getBalance',
      'outputs': [{ 'name': '', 'type': 'uint256' }],
      'payable': false,
      'stateMutability': 'view',
      'type': 'function'
    }]

  const myTokenContract = new web3.eth.Contract(contractABI, contractAddress)

  const handlerGetBalance = async () => {
    const accounts = await web3.eth.getAccounts()
    const balance = await myTokenContract.methods.getBalance(accounts[0]).call()
    setCurrentBalance(balance)
  }

  return (
    <div className="App">
      <h1>Balance: {currentBalance}</h1>
      <button onClick={handlerGetBalance}>Get Balance</button>
    </div>
  )
}

export default App
