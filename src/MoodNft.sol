// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// Base64 import to encode the files
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

/**
 * @title Mood NFT - Dynamic NFT
 * @author Soumil Vavikar
 * @notice NA
 */
contract MoodNft is ERC721 {
    // Errors
    error MoodNft__CantFlipMoodIfNotOwner();

    // Counter for the MoodNft
    uint256 private s_tokenCounter;
    // The sad and happy mood svg uri information
    string private s_sadSvgUri;
    string private s_happySvgUri;

    // Enum for Moods
    enum NFTState {
        HAPPY,
        SAD
    }

    // Mapping for tokenId to the mood
    mapping(uint256 => NFTState) private s_tokenIdToState;

    // Events
    event CreatedNFT(uint256 indexed tokenId);

    /**
     * The NFT constructor.
     * @param happySvgUri the uri for the happy mood svg
     * @param sadSvgUri the uri for the sad mood svg
     */
    constructor(
        string memory happySvgUri,
        string memory sadSvgUri
    ) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_happySvgUri = happySvgUri;
        s_sadSvgUri = sadSvgUri;
    }

    /**
     * This function would mind the NFT
     */
    function mintNft() public {
        uint256 tokenCounter = s_tokenCounter;
        _safeMint(msg.sender, tokenCounter);
        // Defaulting to happy nmood when minting.
        s_tokenIdToState[tokenCounter] = NFTState.HAPPY;
        s_tokenCounter = s_tokenCounter + 1;
        emit CreatedNFT(tokenCounter);
    }

    /**
     * This function will flip the mood of the token id passed in the request.
     * @param tokenId token id
     */
    function flipMood(uint256 tokenId) public {
        // Check if the requester is either the owner of the NFT or is approved to change it.
        if (!_isApprovedOrOwner(msg.sender, tokenId)) {
            revert MoodNft__CantFlipMoodIfNotOwner();
        }

        // Flip the mood of the NFT based on the incoming tokenId
        if (s_tokenIdToState[tokenId] == NFTState.HAPPY) {
            s_tokenIdToState[tokenId] = NFTState.SAD;
        } else {
            s_tokenIdToState[tokenId] = NFTState.HAPPY;
        }
    }

    /**
     * This function will generate the tokenURI for the NFT
     * @param tokenId token Id
     */
    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        // Defaulting to the happy mood
        string memory imageUri = s_happySvgUri;

        // If the token has sad mood, slipping the uri to sad mood uri
        if (s_tokenIdToState[tokenId] == NFTState.SAD) {
            imageUri = s_sadSvgUri;
        }

        string memory tokenMetadata = string.concat(
            '{"name":"',
            name(), // You can add whatever name here
            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
            imageUri,
            '"}'
        );

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(bytes(abi.encodePacked(tokenMetadata)))
                )
            );
    }

    /**
     * This function will return the base URI for the metadata
     */
    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    /**
     * This function will check if the msg sender is the owner or approved to work with the token
     * @param sender message sender
     * @param tokenId the token sender wants to work with
     */
    function _isApprovedOrOwner(
        address sender,
        uint256 tokenId
    ) internal view returns (bool) {
        address owner = ERC721.ownerOf(tokenId);
        return owner == sender || ERC721.getApproved(tokenId) == sender;
    }

    /** Getter functions */
    function getHappySVG() public view returns (string memory) {
        return s_happySvgUri;
    }

    function getSadSVG() public view returns (string memory) {
        return s_sadSvgUri;
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}
