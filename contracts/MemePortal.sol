// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MemePortal {
    uint256 totalMemes;

    event NewMeme(address indexed from, uint256 timestamp, string ipfsFileUrl);

    struct Meme {
        address memer; //address of user who sent meme
        string ipfsFileUrl; //the url of the meme image sent
        uint256 timestamp; //the timestamp when the user sent the meme
    }

    Meme[] memes;

    constructor() {
        console.log("I AM SMART CONTRACT. POG.");
    }

    function sendMeme(string memory _ipsfFileUrl) public {
        totalMemes += 1;
        console.log("%s has sent you a meme!", msg.sender);

        memes.push(Meme(msg.sender, _ipsfFileUrl, block.timestamp));

        emit NewMeme(msg.sender, block.timestamp, _ipsfFileUrl);
    }

    function getAllMemes() public view returns (Meme[] memory) {
        return memes;
    }

    function getTotalMemes() public view returns (uint256) {
        console.log("We have %d total memes!", totalMemes);
        return totalMemes;
    }
}
