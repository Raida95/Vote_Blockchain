/**
* @type import('hardhat/config').HardhatUserConfig
*/

require('dotenv').config();
require("@nomiclabs/hardhat-ethers");

const { API_URL, PRIVATE_KEY } = process.env;

console.log(API_URL)

module.exports = {
   solidity: "0.8.11",
   defaultNetwork: "volta",
   networks: {
      hardhat: {},
      volta: {
         url: API_URL,
         accounts: [`0x${PRIVATE_KEY}`],
         gas: 500000, // Limite de gaz ajustée
         gasPrice: 1000000000, // Prix du gaz ajusté (1 Gwei)
      }
   },
}