import logo from './logo.svg'
import './App.css'

function App () {

  if (typeof window.ethereum !== 'undefined') {
    window.web3 = new Web3(window.ethereum)
    window.ethereum.enable()
  } else {
    console.log('No Ethereum browser detected. You should consider trying MetaMask!')
  }

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

  document.getElementById('getBalance').addEventListener('click', async () => {
    const accounts = await web3.eth.getAccounts()
    const balance = await myTokenContract.methods.getBalance(accounts[0]).call()
    document.getElementById('balance').innerText = web3.utils.fromWei(balance, 'ether')
  })
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo"/>
      </header>
      <body>
      </body>
    </div>
  )
}

export default App
