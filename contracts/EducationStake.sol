// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract EducationStake is VRFConsumerBase {
    address public owner;
    uint public stakeAmount;
    uint public deadline;
    bytes32 internal keyHash;
    uint256 internal fee;

    address[] public participants;
    mapping(address => uint) public stakes;
    mapping(address => bool) public completedCourses;

    // VRF variables
    bytes32 public requestId;
    uint256 public randomResult;

    // Events
    event CourseStarted(address indexed user, uint stakeAmount, uint deadline);
    event CourseCompleted(address indexed user, bool success);
    event RewardsDistributed(uint totalReward, uint rewardPerParticipant);

    constructor(address _vrfCoordinator, address _link, bytes32 _keyHash, uint256 _fee) 
        VRFConsumerBase(_vrfCoordinator, _link) {
        owner = msg.sender;
        keyHash = _keyHash;
        fee = _fee;
    }

    // Start a new course with staking
    function startCourse(uint _stakeAmount, uint _deadline) public payable {
        require(stakes[msg.sender] == 0, "You have already staked");
        require(msg.value == _stakeAmount, "Incorrect stake amount");
        stakes[msg.sender] = _stakeAmount;
        participants.push(msg.sender);
        stakeAmount = _stakeAmount;
        deadline = block.timestamp + _deadline;
        emit CourseStarted(msg.sender, _stakeAmount, deadline);
    }

    // Finish the course and check if completed on time
    function finishCourse() public {
        require(block.timestamp <= deadline, "Deadline has passed");
        require(stakes[msg.sender] > 0, "No stake found");
        completedCourses[msg.sender] = true;
        emit CourseCompleted(msg.sender, true);
    }

    // Distribute rewards to participants who completed the course on time
    function distributeRewards() public {
        require(block.timestamp > deadline, "Deadline has not passed yet");
        uint totalReward = address(this).balance;
        uint completedCount = 0;

        // Count the number of participants who completed the course
        for (uint i = 0; i < participants.length; i++) {
            if (completedCourses[participants[i]]) {
                completedCount++;
            }
        }

        // Calculate reward per participant
        uint rewardPerParticipant = 0;
        if (completedCount > 0) {
            rewardPerParticipant = totalReward / completedCount;
        }

        // Distribute rewards
        for (uint i = 0; i < participants.length; i++) {
            if (completedCourses[participants[i]]) {
                payable(participants[i]).transfer(rewardPerParticipant);
            }
        }

        emit RewardsDistributed(totalReward, rewardPerParticipant);
    }

    // Fallback function to receive Ether
    receive() external payable {}
}