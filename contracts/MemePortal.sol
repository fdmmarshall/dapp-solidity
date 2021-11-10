// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MemePortal {
    uint256 totalMemes;
    string ipfsHash;

    constructor() {
        console.log("I love Tacos");
    }

    function set(string memory x) public {
        ipfsHash = x;
    }

    function get() public view returns (string memory) {
        return ipfsHash;
    }

    function sendMeme() public {
        totalMemes += 1;
        console.log("%s has sent you a meme!", msg.sender);
    }

    function getTotalMemes() public view returns (uint256) {
        console.log("We have %d total memes!", totalMemes);
        return totalMemes;
    }
}
