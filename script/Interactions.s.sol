// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {Sv15Nft} from "../src/Sv15Nft.sol";

contract MintSv15Nft is Script {
    string public constant BIKE =
        "https://ipfs.io/ipfs/QmaiHoe6ThaoehhfoGaVtR3CrBtQ3Y42Tpm4P7z9MJiia4?filename=bike.json";

    function run() external {
        address mostRecentContract = DevOpsTools.get_most_recent_deployment(
            "Sv15Nft",
            block.chainid
        );
        mintSv15NftOnContract(mostRecentContract);
    }

    function mintSv15NftOnContract(address contractAdd) public {
        vm.startBroadcast();
        Sv15Nft(contractAdd).mintSv15Nft(BIKE);
        vm.stopBroadcast();
    }
}
