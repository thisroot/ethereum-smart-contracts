const Dice = artifacts.require("Dice.sol")
require("chai").use(require("chai-bignumber")(web3.bignumber)).should()

contract("Dice", function ([ account ]) {
    let diceContract = null

    it("should check the manager is valid", async () => {
        diceContract = await Dice.deployed()
        const manager = await diceContract.manager.call()
        manager.should.be.bignumber.eql(account)
    })
})
