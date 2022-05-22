require("@nomiclabs/hardhat-waffle");
require("hardhat-abi-exporter");
require("solidity-coverage");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.7",
  networks: {
    hardhat: {
      initialBaseFeePerGas: 0, // hardhat london fork error fix for coverage
    },
  },
  paths: {
    sources: "./src/*",
    artifacts: "./build",
    tests: "./src/test/*",
  },
};