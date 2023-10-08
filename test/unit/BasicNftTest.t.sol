//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address user = makeAddr("user");
    uint256 STARTING_USER_BALANCE = 10 ether;
    string public constant SHIBA =
        "ipfs://Qmai4ku2tYtT47WNFVF36J9HTfnSkk8EHUvhXzkUof5kd4/?filename=shiba-inu.json";

    function setUp() external {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();

        assert(keccak256(abi.encodePacked(actualName)) == keccak256(abi.encodePacked(expectedName)));
    }

    function testSymboleIsCorrect() public view {
        string memory expectedSymbol = "DOG";
        string memory actualSymbole = basicNft.symbol();
        assert(keccak256(abi.encodePacked(expectedSymbol)) == keccak256(abi.encodePacked(actualSymbole)));
    }
    function testCanMintAndHaveABalance() public {
        vm.prank(user); 
        basicNft.mintNft(SHIBA);
        assert(basicNft.balanceOf(user)==1);
        assert(keccak256(abi.encodePacked(SHIBA))== keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }

    function testMintedCorrectly() public {
        vm.prank(user);
        basicNft.mintNft(SHIBA);
        uint256 counter = basicNft.getTokenCounter();
        assert(counter == 1);
        assert(basicNft.balanceOf(user) == 1);
        assert(keccak256(abi.encodePacked(SHIBA)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }
}
