// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {console} from "forge-std/console.sol";
// Base64 import to encode the files
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

/**
 * @title Deploy the Sv15Nft smart contract to the chain.
 * @author Soumil Vavikar
 * @notice NA
 */
contract DeployMoodNft is Script {
    // string for the baseUri for SVG format.
    string private baseUri = "data:image/svg+xml;base64,";

    /**
     * This function will run when the script is called.
     */
    function run() external returns (MoodNft) {
        vm.startBroadcast();

        MoodNft moodNft = new MoodNft(
            getSvgUri("./img/moodnft/happy-mood.svg"),
            getSvgUri("./img/moodnft/sad-mood.svg")
        );

        vm.stopBroadcast();
        return moodNft;
    }

    /**
     * This function will help convert the SVG file into Base64 encoded URI.
     * @param path path of the SVG file.
     */
    function getSvgUri(
        string memory path
    ) internal view returns (string memory) {
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(vm.readFile(path))))
        );
        return string(abi.encodePacked(baseUri, svgBase64Encoded));
    }
}
