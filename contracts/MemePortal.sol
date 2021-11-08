// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MemePortal {
    uint256 totalMemes;

    constructor() {
        console.log("I love Tacos");
    }

    function sendMeme() public {
        totalMemes += 1;
        console.log('%s has sent you a meme!', msg.sender);
    }

    function getTotalMemes() public view returns (uint256) {
        console.log('We have %d total memes!', totalMemes);
        return totalMemes;
    }
}