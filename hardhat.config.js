require("@nomiclabs/hardhat-waffle");
require("hardhat-abi-exporter");
require("solidity-coverage");
require("dotenv").config();
require("hardhat-deploy");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: {
    compilers: [{ version: "0.8.7" }, { version: "0.6.6" }],
  },
  namedAccounts: {
    deployer: {
      default: 0,
    },
  },
  networks: {
    hardhat: {
      initialBaseFeePerGas: 0, // hardhat london fork error fix for coverage
      chainId: 31337,
    },
    rinkeby: {
      url: process.env.RINKEBY_RPC_URL,
      accounts: [process.env.PRIVATE_KEY],
      chainId: 4,
    },
  },
  paths: {
    sources: "./src/*",
    artifacts: "./build",
    tests: "./src/test/*",
  },
};
