//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "base64-sol/base64.sol";
import "../tokens/nf-token-metadata.sol";
import "../ownership/ownable.sol";
import "./nf-token-metadata-mock.sol";
import "hardhat/console.sol";

/**
 * @dev creates an NFT based on the price of ethereum. If the price of ETH is more than a given value then a smiley face is created while a frowny face will be created if it is lower than a given value.
 */
contract DynamicSvgNft is NFTokenMetadata, Ownable {
    uint public s_tokenCounter;
    string public s_lowImageURI;
    string public s_highImageURI;
    int256 public immutable i_highValue;
    AggregatorV3Interface public immutable i_priceFeed;
    string public s_name;
    string public s_nftSymbol;
    event CreatedNFT(uint256 indexed tokenId, int256 highValue);

    constructor(
        address priceFeedAddress,
        string memory lowSvg,
        string memory highSvg,
        int256 highValue,
        string memory _name,
        string memory _symbol
    ) ERC721() {
        s_tokenCounter = 0;
        s_lowImageURI = svgToImageURI(lowSvg);
        s_highImageURI = svgToImageURI(highSvg);
        i_priceFeed = AggregatorV3Interface(priceFeedAddress);
        i_highValue = highValue;
        s_name = _name;
        s_nftSymbol = _symbol;
    }

    ///returns imageURIs
    function svgToImageURI(string memory svg)
        public
        pure
        returns (string memory)
    {
        string memory baseImageURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );

        return string(abi.encodePacked(baseImageURL, svgBase64Encoded));
    }

    function mint() external onlyOwner {
        emit CreatedNFT(s_tokenCounter, i_highValue);
        super._mint(msg.sender, s_tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
    }

    ///Returns string to be used from converting svg -> base64
    function _baseURI() internal pure returns (string memory) {
        return "data:application/json;base64,";
    }

    ///override tokenURI inherited function from ERC721
    function tokenURI(
        uint /*tokenId*/
    ) public view override returns (string memory) {
        //How do we base64 encode this string -> URL/URI
        //How do we get the image?
        (, int256 price, , , ) = i_priceFeed.latestRoundData();
        string memory imageUri = s_lowImageURI;

        if (price >= i_highValue) {
            imageUri = s_highImageURI;
        }

        bytes memory metaDataTemplate = (
            abi.encodePacked(
                '{"name":"Dynamic SVG", "description":"An NFT that changes based on the Chainlink Feed", ',
                '"attributes": [{"trait_type": "coolness", "value": 100}], "image":"',
                imageUri,
                '"}'
            )
        );

        bytes memory metaDataTemplateinBytes = bytes(metaDataTemplate);
        string memory encodedMetadata = Base64.encode(metaDataTemplateinBytes);
        return (string(abi.encodePacked(_baseURI(), encodedMetadata))); //concatenate string
    }

    /**
     * @dev returns low svg
     */
    function getLowSVG() public view returns (string memory) {
        return s_lowImageURI;
    }

    /**
     * @dev returns high svg
     */
    function getHighSVG() public view returns (string memory) {
        return s_highImageURI;
    }

    /**
     * @dev returns price feed
     */
    function getPriceFeed() public view returns (AggregatorV3Interface) {
        return i_priceFeed;
    }

    /**
     * @dev returns token counter
     */
    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }

    /**
     * @dev Returns name
     */
    function getName() public view returns (string memory) {
        return s_name;
    }

    /**
     * @dev Returns nftSymbol
     */
    function getNftSymbol() public view returns (string memory) {
        return s_nftSymbol;
    }
}
