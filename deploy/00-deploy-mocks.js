const { network, ethers } = require("hardhat");

module.exports = async function (hre) {
  let { getNamedAccounts, deployments } = hre;
  let { deploy, log } = deployments;
  let { deployer } = await getNamedAccounts();
  let chainId = network.config.chainId;

  const DECIMALS = "18";
  const INITIAL_ANSWERS = ethers.utils.parseEther("2000");

  //if we are in a local chain
  if ((chainId = 31337)) {
    await deploy("MockV3Aggregator", {
      from: deployer,
      log: true,
      args: [DECIMALS, INITIAL_ANSWERS],
    });
  }
};

module.exports.tags = ["all", "mocks"];
