// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MemePortal {
    uint256 totalMemes;

    uint256 private seed;

    event NewMeme(address indexed from, uint256 timestamp, string ipfsFileUrl);

    struct Meme {
        address memer; //address of user who sent meme
        string ipfsFileUrl; //the url of the meme image sent
        uint256 timestamp; //the timestamp when the user sent the meme
    }

    Meme[] memes;

    mapping(address => uint256) public lastMemedAt;

    constructor() payable {
        console.log("I AM SMART CONTRACT. POG.");

        seed = (block.timestamp + block.difficulty) % 100;
    }

    function sendMeme(string memory _ipsfFileUrl) public {
        require(
            lastMemedAt[msg.sender] + 30 seconds < block.timestamp,
            "Must wait 30 seconds before send a meme again."
        );

        lastMemedAt[msg.sender] = block.timestamp;

        totalMemes += 1;
        console.log("%s has sent you a meme!", msg.sender);

        memes.push(Meme(msg.sender, _ipsfFileUrl, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        if (seed <= 30) {
            uint256 prizeAmount = 0.000218 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

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
