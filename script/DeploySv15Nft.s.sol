// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import {Script} from "forge-std/Script.sol";
import {Sv15Nft} from "../src/Sv15Nft.sol";
import {console} from "forge-std/console.sol";

contract DeploySv15Nft is Script {
    uint256 public DEFAULT_ANVIL_PRIVATE_KEY =
        0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 public deployerKey;

    function run() external returns (Sv15Nft) {
        vm.startBroadcast();
        Sv15Nft sv15Nft = new Sv15Nft();
        vm.stopBroadcast();
        return sv15Nft;
    }
}
