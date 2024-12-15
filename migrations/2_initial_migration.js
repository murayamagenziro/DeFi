// eslint-disable-next-line no-undef
const JamToken = artifacts.require('JamToken')
// eslint-disable-next-line no-undef
const StellartToken = artifacts.require('StellartToken')
// eslint-disable-next-line no-undef
const TokenFarm = artifacts.require('TokenFarm')

module.exports = async function(deployer, network, accounts) {
    
    // Despliegue del JamToken
    await deployer.deploy(JamToken);
    const jamToken = await JamToken.deployed()


    // Despliegue del StellartToken
    await deployer.deploy(StellartToken);
    const stellartToken = await StellartToken.deployed()

    await deployer.deploy(TokenFarm, stellartToken.address, jamToken.address);
    const tokenFarm = await TokenFarm.deployed()

    // Transferir tokens a TokenFarm (1_000_000 de tokens)
    await stellartToken.transfer(tokenFarm.address, 1e18.toString())

    // Transferencia de los tokens para el Staking
    await jamToken.transfer(accounts[1], 1e18.toString())

}