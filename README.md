# DeFi

A Staking DApp (Blockchain Bootcamp)

## Technologies

-   Solidity
-   Truffle
-   Ganache
-   React
-   JavaScript

## How to run

```bash
set NODE_OPTIONS=--openssl-legacy-provider && npm start
```

### Contracts

The project contains three contracts:
- JamToken.sol ==> which represents an ERC20 token, although it doesn't strictly follows the ERC20 standard.
- StellartToken.sol ==> which represents another ERC20 token, which will be used for rewards if a user stakes their JamToken.
- TokenFarm.sol ==> Central contract that manages the staking of JamToken and the distribution of StellartToken as rewards.

### How to run the project

In a command line, just do the following:

```bash
truffle migrate --reset --compile-all
npm start
```

This will deploy the contracts. You need to have Ganashe running in the background, since the project is configured to use the local blockchain.

If you want to use another network, you can change the configuration in the truffle-config.js file.