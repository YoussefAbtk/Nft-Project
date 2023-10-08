//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    string tokenUri = "ipfs://Qmai4ku2tYtT47WNFVF36J9HTfnSkk8EHUvhXzkUof5kd4/?filename=shiba-inu.json";

    function mintMinNft(address mostRecentDeployed) public {
        vm.startBroadcast();
        BasicNft(mostRecentDeployed).mintNft(tokenUri);
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintMinNft(mostRecentDeployed);
    }
}
