import Web3 from "web3"
import votingArtifact from "./build/contracts/Voting.json"

let candidates = {
    "Rome": "candidate-1", "Oleg": "candidate-2",
    "Igor": "candidate-3"
}
const App = {
    web3: null,
    account: null,
    voting: null,
    start: async function () {
        const { web3 } = this
        try {
            const networkId = await web3.eth.net.getId()
            const deployedNetwork = votingArtifact.networks[networkId]
            this.voting = new web3.eth.Contract(
              votingArtifact.abi,
              deployedNetwork.address,
            )
            const accounts = await web3.eth.getAccounts()
            this.account = accounts[0]
            this.loadCandidatesAndVotes()
        } catch (error) {
            console.error("Нет подключения", error)
        }
    },
    loadCandidatesAndVotes: async function () {
        const { totalVotesFor } = this.voting.methods
        let candidateNames = Object.keys(candidates)
        for (var i = 0; i < candidateNames.length; i++) {
            let name = candidateNames[i]
            var count = totalVotesFor(this.web3.utils.asciiToHex(name)).call()
            $("#" + candidates[name]).html(count)
        }
    },
    voteForCandidate: async function () {
        let candidateName = $("#candidate").val()
        $("#msg").html("Голос засчитан!")

        $("#candidate").val("")
        const {
            totalVotesFor,
            voteForCandidate
        } = this.voting.methods
        await voteForCandidate(this.web3.utils.asciiToHex(candidateName)).send(
          { gas: 140000, from: this.account })
        let div_id = candidates[candidateName]
        var count = await totalVotesFor(this.web3.utils.asciiToHex(candidateName)).call()
        $("#" + div_id).html(count)
        $("#msg").html("")
    }
}
window.App = App
window.addEventListener("load", function () {
    if (window.ethereum) {
        App.web3 = new Web3(window.ethereum)
        window.ethereum.enable()
    } else {
        console.warn("Нет web3 провайдера!",
        )
        App.web3 = new Web3(
          new Web3.providers.HttpProvider("http://127.0.0.1:8545"),
        )
    }
    App.start()
})
