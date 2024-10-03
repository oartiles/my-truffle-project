const MyToken = artifacts.require('MyToken')
const LendingProtocol = artifacts.require('LendingProtocol')
const LiquidationContract = artifacts.require('LiquidationContract')

contract('LiquidationContract', (accounts) => {
  let tokenInstance
  let lendingProtocolInstance
  let liquidationContractInstance

  const [owner, borrower, liquidator] = accounts

  before(async () => {
    tokenInstance = await MyToken.new(web3.utils.toWei('1000', 'ether'))
    lendingProtocolInstance = await LendingProtocol.new(tokenInstance.address)
    liquidationContractInstance = await LiquidationContract.new(tokenInstance.address, lendingProtocolInstance.address)

    // Transfer some tokens to the borrower
    await tokenInstance.transfer(borrower, web3.utils.toWei('100', 'ether'), { from: owner })
  })

  it('should allow a user to borrow tokens', async () => {
    await tokenInstance.approve(lendingProtocolInstance.address, web3.utils.toWei('50', 'ether'), { from: borrower })
    await lendingProtocolInstance.borrow(web3.utils.toWei('50', 'ether'), { from: borrower })

    const loanAmount = await lendingProtocolInstance.loans(borrower)
    assert.equal(loanAmount.toString(), web3.utils.toWei('50', 'ether'), 'Loan amount should be 50 tokens')
  })

  it('should allow liquidation of a loan', async () => {
    await tokenInstance.transfer(liquidator, web3.utils.toWei('50', 'ether'), { from: owner })
    await tokenInstance.approve(liquidationContractInstance.address, web3.utils.toWei('50', 'ether'), { from: liquidator })

    await liquidationContractInstance.liquidate(borrower, { from: liquidator })

    const loanAmount = await lendingProtocolInstance.loans(borrower)
    assert.equal(loanAmount.toString(), '0', 'Loan amount should be 0 after liquidation')
  })
})
