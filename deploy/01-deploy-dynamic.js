const { network, ethers } = require("hardhat");
const fs = require("fs");

module.exports = async function (hre) {
  const { getNamedAccounts, deployemnts } = hre;
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  const chainId = network.config.chainId;

  let ethUsdPriceFeedAddress;

  if (chainId == 31337) {
    const ethUsdAggregator = await ethers.getContract("MockV3Aggregator");
    ethUsdPriceFeedAddress = ethUsdAggregator.address;
  } else {
    //Rinkeby Testnet ETH/USD
    ethUsdPriceFeedAddress = "0x8A753747A1Fa494EC906cE90E9f37563A8AF630e";
  }

  const highValue = 180000000000;
  const lowSvg = await fs.readFileSync("./img/frown.svg", { encoding: "utf8" });
  const highSvg = await fs.readFileSync("./img/happy.svg", {
    encoding: "utf8",
  });
  args = [
    ethUsdPriceFeedAddress,
    lowSvg,
    highSvg,
    highValue,
    "DynamicSVGNfts",
    "SVG",
  ];
  const dynamicSvgNft = await deploy("DynamicSvgNft", {
    from: deployer,
    args: args,
    log: true,
  });

  const dynamicContract = await ethers.getContract("DynamicSvgNft");
  await dynamicContract.mint();
  log("Minted NFT!");
};

module.exports.tags = ["all", "dynamicsvg"];
