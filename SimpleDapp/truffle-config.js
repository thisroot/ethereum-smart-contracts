const HDWalletProvider = require("@truffle/hdwallet-provider");

const mnemonicPhrase = "lonely wrong govern spell air any gain input fetch exhibit elegant clarify";

module.exports = {
    networks: {
        development: {
            host: "localhost",
            port: 8545,
            network_id: "*" // Match any network id
        },
        ropsten: {
            // must be a thunk, otherwise truffle commands may hang in CI
            provider: () =>
              new HDWalletProvider({
                  mnemonic: {
                      phrase: mnemonicPhrase
                  },
                  providerOrUrl: "https://ropsten.infura.io/v3/02febdd0138b471ba6fe1f0a477d3e8e",
                  numberOfAddresses: 1,
                  shareNonce: true,
                  derivationPath: "m/44'/1'/0'/0/"
              }),
            network_id: '3',
        }
    }
};
