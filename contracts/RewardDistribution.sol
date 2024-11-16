// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Staking.sol";

contract RewardDistributionContract {
    StakingContract public stakingContract;

    event RewardsDistributed(uint courseId, uint totalReward, uint rewardPerParticipant);

    constructor(address _stakingContract) {
        stakingContract = StakingContract(_stakingContract);
    }

    // Distribute rewards to participants who completed the course on time
    function distributeRewards(uint courseId) public {
        StakingContract.Course memory course = stakingContract.courses(courseId);
        require(block.timestamp > course.deadline, "Deadline has not passed yet");

        uint totalReward = address(this).balance;
        uint completedCount = 0;

        // Count the number of participants who completed the course
        for (uint i = 0; i < course.participants.length; i++) {
            if (course.participantData[course.participants[i]].completed) {
                completedCount++;
            }
        }

        // Calculate reward per participant
        uint rewardPerParticipant = 0;
        if (completedCount > 0) {
            rewardPerParticipant = totalReward / completedCount;
        }

        // Distribute rewards
        for (uint i = 0; i < course.participants.length; i++) {
            if (course.participantData[course.participants[i]].completed) {
                payable(course.participants[i]).transfer(rewardPerParticipant);
            }
        }

        emit RewardsDistributed(courseId, totalReward, rewardPerParticipant);
    }

    // Fallback function to receive Ether
    receive() external payable {}
}