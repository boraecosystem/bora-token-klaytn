# BORA Ecosystem Smart Contract

This is Smart Contract for utilizing in BORA Ecosystem. If you want to understand BORA Ecosystem, please refer to our [project official site](https://bora.boraecosystem.com).

## Testing

If you want to verify BORA token contract using test code in this repository, you need to install truffle and ganache client for your convenience.

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

```sh
# 3. Flattening
npm run flattener
```


### Overview of Directories

* contracts  : Directory for Solidity Contracts.
* migrations : Directory for deployment files.
* test : Directory for test suites of the Smart Contracts.
* truffle-config.js : Truffle configuration file.


### Relevant URLs for Tools

- [truffle install](https://www.trufflesuite.com/docs/truffle/getting-started/installation)
- [ganache-cli install](https://www.npmjs.com/package/ganache-cli)
- [install Ganache win ver.](https://www.trufflesuite.com/ganache)


## License and Intellectual Property included in this Contracts

Code released under the [MIT License](https://github.com/BoraEcosystem/bora-token-klaytn/blob/master/LICENSE).

BORA Ecosystem Token Contract and test suites include code from [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-solidity) under the MIT license.
