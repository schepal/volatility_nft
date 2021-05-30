// this code is used to push the smart contract code to the kovan testnet
const VolNFT = artifacts.require('VolNFT')
module.exports = async (deployer, network, [defaultAccount]) => {
    deployer.deploy(VolNFT)
}
