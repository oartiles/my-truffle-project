const AaveClone = artifacts.require('AaveClone')

contract('AaveClone', (accounts) => {
  it('debería permitir depósitos', async () => {
    const instance = await AaveClone.deployed()
    await instance.deposit({ from: accounts[0], value: web3.utils.toWei('1', 'ether') })
    const balance = await instance.getBalance({ from: accounts[0] })
    assert.equal(balance.toString(), web3.utils.toWei('1', 'ether'))
  })

  it('debería permitir retiros', async () => {
    const instance = await AaveClone.deployed()
    await instance.withdraw(web3.utils.toWei('0.5', 'ether'), { from: accounts[0] })
    const balance = await instance.getBalance({ from: accounts[0] })
    assert.equal(balance.toString(), web3.utils.toWei('0.5', 'ether'))
  })
})
