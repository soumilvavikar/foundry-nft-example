// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {Sv15Nft} from "../src/Sv15Nft.sol";

/**
 * @title Mint the Sv15Nft by reading the latest deployed contract and passing the ipfs location of the metadata for the NFT.
 * @author Soumil Vavikar
 * @notice NA
 */
contract MintSv15Nft is Script {
    string public constant BIKE =
        "https://ipfs.io/ipfs/QmaiHoe6ThaoehhfoGaVtR3CrBtQ3Y42Tpm4P7z9MJiia4?filename=bike.json";

    /**
     * This function will execute when we run the script
     */
    function run() external {
        address mostRecentContract = DevOpsTools.get_most_recent_deployment(
            "Sv15Nft",
            block.chainid
        );
        mintSv15NftOnContract(mostRecentContract);
    }

    /**
     * This function will mint the Sv15Nft on the contract address passed in the parameter
     * @param contractAdd contract address which we want to mint
     */
    function mintSv15NftOnContract(address contractAdd) public {
        vm.startBroadcast();
        Sv15Nft(contractAdd).mintSv15Nft(BIKE);
        vm.stopBroadcast();
    }
}
