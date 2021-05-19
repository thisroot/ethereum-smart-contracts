const Voting = artifacts.require("Voting")
const Greetings = artifacts.require("Greetings")

module.exports = function (deployer) {
    deployer.deploy(Voting, [ "Rome", "Oleg", "Igor" ].map(name => web3.utils.asciiToHex(name)))
    deployer.deploy(Greetings)
}
