// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import {Script} from "forge-std/Script.sol";
import {Sv15Nft} from "../src/Sv15Nft.sol";
import {console} from "forge-std/console.sol";

/**
 * @title Deploy the Sv15Nft smart contract to the chain.
 * @author Soumil Vavikar
 * @notice NA
 */
contract DeploySv15Nft is Script {
    /**
     * This function will run when the script is called.
     */
    function run() external returns (Sv15Nft) {
        vm.startBroadcast();
        Sv15Nft sv15Nft = new Sv15Nft();
        vm.stopBroadcast();
        return sv15Nft;
    }
}
