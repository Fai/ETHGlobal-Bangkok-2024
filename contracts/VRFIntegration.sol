// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract VRFIntegrationContract is VRFConsumerBase {
    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public randomResult;

    event RandomnessRequested(bytes32 requestId);
    event RandomnessFulfilled(bytes32 requestId, uint256 randomness);

    constructor(address _vrfCoordinator, address _link, bytes32 _keyHash, uint256 _fee) 
        VRFConsumerBase(_vrfCoordinator, _link) {
        keyHash = _keyHash;
        fee = _fee;
    }

    // Chainlink VRF function to get a random number
    function getRandomNumber() public returns (bytes32 requestId) {
        require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK - fill contract with LINK");
        requestId = requestRandomness(keyHash, fee);
        emit RandomnessRequested(requestId);
    }

    // Chainlink VRF callback function
    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        randomResult = randomness;
        emit RandomnessFulfilled(requestId, randomness);
    }

    // Fallback function to receive Ether
    receive() external payable {}
}