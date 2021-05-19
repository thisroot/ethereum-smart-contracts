Web3 = require('web3')
const fs = require('fs')
web3 = new Web3("http://localhost:8545") //node_modules/.bin/ganache-cli
web3.eth.getAccounts().then(accounts => {
    if (accounts.length == 0) return

    const bytecode = fs.readFileSync('__contracts_Voting_sol_Voting.bin').toString()
    const abi = JSON.parse(fs.readFileSync('__contracts_Voting_sol_Voting.abi').toString())

    const deployedContract = new web3.eth.Contract(abi)
    const listOfCandidates = [ "Roma", "Igor", "Denis" ]

    deployedContract.deploy({
        data: bytecode,
        arguments: [ listOfCandidates.map(i => web3.utils.asciiToHex(i)) ]
    }).send({
        from: accounts[0],
        gas: 1500000,
        gasPrice: web3.utils.toWei('0.00003', "ether")
    }).then(newContractInstance => {
        deployedContract.options.address = newContractInstance.options.address
        console.log(newContractInstance.options.address)
    })
})
