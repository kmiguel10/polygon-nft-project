# Dynamic SVG NFT

A homemade ERC721-compliant NFT smart contract.

[`DynamicSvgNft`](src/contracts/mocks/dynamic-svgt-nft.sol) - creates an NFT based on the price of ethereum. If the price of ETH is more than a given value then a smiley face is created while a frowny face will be created if it is lower than a given value.

The smart contract utilizes [`Chainlink ETH pricefeed`](https://docs.chain.link/docs/ethereum-addresses/) to get a secure and accurate data.

# Modules needed

- For hardhat:

```
npm install --save-dev hardhat
```

- For Chainlink:

```
npm install @chainlink/contracts
```

- For testing:

```
npm install --save-dev @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers ethers
```

# Structure

All contracts and tests files are in the src folder. There are two implementations:

- [`nf-token.sol`](src/contracts/tokens/nf-token.sol) is the base ERC-721 token implementation with ERC-165 support

- [`nf-token-metadata.sol`](src/contracts/tokens/nf-token-metadata.sol) implements optional ERC-721 metadata features for the token contract. It implements a token name, a symbol and a distinct URI pointing to a publicly exposed ERC-721 JSON metadata file.

Other files in the [tokens](src/contracts/tokens) and [utils](src/contracts/utils) directories named `erc*.sol` are interfaces and define the respective standards.

Mock contracts showing basic contract usage are available in the [mocks](src/contracts/mocks) folder.

# Test

- After installing the packages

```
npm run test
```

# Deployment to Rinkeby Testnet

1. Set up environment variables

You'll want to set your `RINKEBY_RPC_URL` and `PRIVATE_KEY` as environment variables. You can add them to a `.env` file

- `PRIVATE_KEY`: The private key of your account (like from [metamask](https://metamask.io/)).
- `RINKEBY_RPC_URL`: This is url of the rinkeby testnet node you're working with. You can get setup with one for free from [Alchemy](https://alchemy.com/?a=673c802981)

2. Get testnet ETH

Head over to [faucets.chain.link](https://faucets.chain.link/) and get some tesnet ETH & LINK. You should see the ETH and LINK show up in your metamask. [You can read more on setting up your wallet with LINK.](https://docs.chain.link/docs/deploy-your-first-contract/#install-and-fund-your-metamask-wallet)

3. Mint NFT

Then run:

```
npx hardhat deploy --network rinkeby
```

# Verify

Once minted, you can verify the contract in:

1. [`Etherscan Rinkeby Testnet`](https://rinkeby.etherscan.io)

- paste contract address

2. [`ERC-721 Validator`](https://erc721validator.org)

- Choose "Ethereum Rinkeby" as Network

3. [`OpenSea testnet`](https://testnets.opensea.io)
