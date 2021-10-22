# BORA Ecosystem Smart Contract

This repository is a collection of files containing the BORA token Solidity file, as well as various scripts that can be utilized to test the BORA contract. If you want to read more about the BORA Ecosystem, please take a look at our [official project website](https://bora.boraecosystem.com).

## Testing

If you want to verify the BORA token contract using the test code in this repository, installation of caver-js library will be required. You must also register and log into the [KAS API console](https://console.klaytnapi.com) to receive your KAS credentials (namely the access key ID as well as the secret access key). After that, you must configure the `kasConfig` and `walletConfig` variable in test/deploy.js file

### Installation of Testing Tools

Running test suites require NPM (version v8.9.4 or later).


```sh
# 1. Installation
cd PATH-TO-CODE
npm install
```

```sh
# 2. Testing
cd PATH-TO-CODE

npm run test
```

### Overview of Directories

* contracts  : Directory for Solidity contracts.
* test : Directory for test suites of the smart contracts.
* truffle-config.js : Truffle configuration file.


### Relevant URLs for Tools

- [klaytn](https://docs.klaytn.com)
- [kas api](https://docs.klaytnapi.com)
- [kas api console](https://console.klaytnapi.com)

## License and Intellectual Property included in this Contracts

Code released under the [MIT License](https://github.com/BoraEcosystem/bora-token-klaytn/blob/master/LICENSE).

BORA Ecosystem Token Contract and test suites include code from [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-solidity) under the MIT license.