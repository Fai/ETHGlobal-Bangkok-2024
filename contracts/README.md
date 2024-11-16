# Smart contract

Staking Contract: Manages participant stakes.
Reward Distribution Contract: Handles reward calculations and distribution.
VRF Integration Contract: Manages randomness and Chainlink requests.

Usage:

Start Course: Participants call startCourse with the stake amount and deadline.

Finish Course: Participants call finishCourse before the deadline to mark their course as completed.

Distribute Rewards: After the deadline, call distributeRewards to distribute the pool money among those who completed the course.

Installation

```
npm install --save-dev hardhat
npm install @chainlink/contracts --save
npx hardhat
```

Chainlink Automation (Keepers)
To automate the reward distribution after the deadline:

Use Chainlink Keepers to automate calling the distributeRewards() function once the deadline is reached.

This removes the need for manual interaction and makes the process fully decentralized.

How to integrate:

Register your contract with the Chainlink Keepers network.
Implement the required checkUpkeep and performUpkeep functions.
Call distributeRewards() in performUpkeep.

Layer 2 Integration
To reduce gas fees for participants staking and claiming rewards:

Deploy your contract on a Layer 2 solution 