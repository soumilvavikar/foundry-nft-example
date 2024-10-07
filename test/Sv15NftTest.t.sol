// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Test} from "forge-std/Test.sol";
import {DeploySv15Nft} from "../script/DeploySv15Nft.s.sol";
import {Sv15Nft} from "../src/Sv15Nft.sol";

/**
 * @title The test class to test the Sv15Nft token.
 * @author Soumil Vavikar
 * @notice NA
 */
contract Sv15NftTest is Test {
    DeploySv15Nft public deployer;
    Sv15Nft public sv15Nft;

    address public USER = makeAddr("user");
    string public constant BIKE =
        "https://ipfs.io/ipfs/QmaiHoe6ThaoehhfoGaVtR3CrBtQ3Y42Tpm4P7z9MJiia4?filename=bike.json";

    function setUp() public {
        deployer = new DeploySv15Nft();
        sv15Nft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Sv15Nft";
        string memory actualName = sv15Nft.name();

        // == operator doesn't work for strings. Hence the following line won't work and throw compile time error.
        // assert (expectedName == actualName);

        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testSymbolIsCorrect() public view {
        string memory expectedSymbol = "Bike";
        string memory actualSymbol = sv15Nft.symbol();

        assert(
            keccak256(abi.encodePacked(expectedSymbol)) ==
                keccak256(abi.encodePacked(actualSymbol))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        sv15Nft.mintSv15Nft(BIKE);

        assert(sv15Nft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(BIKE)) ==
                keccak256(abi.encodePacked(sv15Nft.tokenURI(0)))
        );
    }
}
