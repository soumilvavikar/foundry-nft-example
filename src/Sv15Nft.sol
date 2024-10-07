// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/**
 * @title Sv15Nft - Non Fungible Token
 * @author Soumil Vavikar
 * @notice This contract is a NFT implemented on the ERC721
 * // https://ipfs.io/ipfs/QmXW1JcRvBuzW7v5KkxyWxrsWWtJJiGQNTdCuUceYC2Nw2?filename=bike.png
 */
contract Sv15Nft is ERC721 {
    // Counter for the Sv15Nft
    uint256 private s_tokenCounter;

    mapping(uint256 => string) private s_tokenIdToUri;

    /**
     * @dev Initializes the contract by setting a `name` and a `symbol` to the ERC721 constructor
     */
    constructor() ERC721("Sv15Nft", "Bike") {
        s_tokenCounter = 0;
    }

    /**
     * This function will be used to mint the NFT.
     * @param tokenUri the token uri
     */
    function mintSv15Nft(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    /**
     * This function will return the tokenUri corresponding to the tokenId passed in the request
     * @param tokenId the token id
     */
    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }
}
