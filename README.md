# ETHGlobal-Bangkok-2024

## Project Name

MaLearnThon

## Short Description

Learn, stake, and win! 🎓💸 
Our decentralized education platform gamifies learning with staking. Complete projects on time to reclaim your stake and earn bonuses. Fail, and your stake powers the prize pool. Learn skills, stay accountable, and win rewards!

## Description

MaLearnThon revolutionizes education through decentralization and gamification, making learning more engaging and rewarding.

Here’s how it works:

1. Staking to Learn:
Users commit to courses by staking an entry fee. This creates accountability and ensures active participation.
2. Time-Bound Projects:
Each course includes a project with a clear deadline. Learners must submit their work before the deadline to qualify for rewards.
3. Incentives for Completion:
    - Winners who complete projects on time reclaim their staked amount and receive bonuses from the prize pool, which grows based on the difficulty of the course.
    - Losers who fail to meet the deadline forfeit their stake, which contributes to the prize pool and rewards instructors or contributors.
4. Decentralized Validation:
Smart contracts ensure fairness and transparency in staking, deadlines, and payouts. Projects are validated through peer reviews or pre-defined criteria.
5. Skill-Driven Growth:
Focused on Web3, Ethereum, zk, and other emerging technologies, the platform empowers users with cutting-edge skills while rewarding their commitment to learning.

MaLearnThon aim to create a decentralized learning ecosystem where individuals can invest in their education, stay motivated, and earn while they learn. By aligning financial incentives with skill development, foster accountability, collaboration, and innovation.

Perfect for the Web3 community and beyond, this platform bridges education and blockchain, making learning rewarding and fun! 🎉

- Automated Time Validation:
Used blockchain timestamps to enforce deadlines, ensuring no manipulation of submission times.
- Dynamic Pool Scaling:
Implemented a tiered system where harder courses contribute higher stakes and bonuses, creating incentives for users to tackle advanced challenges.
- Real-Time Updates with The Graph:
Integrated The Graph to index blockchain data, enabling users to track their progress, pool contributions, and course status in real time.
- Peer Review Integration:
Built a decentralized peer review mechanism where learners evaluate submissions via governance tokens, ensuring high-quality validation without relying on centralized authorities.

Planned Partner Technologies and Their Benefits

- Polygon: Provided scalability and low-cost transactions, ensuring a smooth user experience for staking and payouts. 
- IPFS/Filecoin: Ensured secure and decentralized storage for project files.
- Chainlink: Added fairness and reliability to reward distribution mechanics.
- Web3Auth: Simplified wallet onboarding, making the platform accessible to non-crypto-savvy users.

By blending blockchain principles with gamification, we built a platform that’s not only functional but also enjoyable, motivating users to learn and succeed in a decentralized manner.

## How it made

We built our project using a combination of cutting-edge Web3 technologies and frameworks to create a seamless, decentralized education experience. Here's a breakdown of the tech stack and process:

Core Components

We built our project using a combination of cutting-edge Web3 technologies and frameworks to create a seamless, decentralized education experience. Here's a breakdown of the tech stack and process:

1. Smart Contracts (Solidity + Cairo) - Implemented
* The backbone of our platform, deployed on the Ethereum or L2 network for scalability and low gas fees.
* Smart contracts handle staking, prize pool management, deadlines, and reward distribution with complete transparency.

2. Frontend + Backend (Next.js) - Implemented
* User interface for learners to explore courses, stake funds, and track progress., handling project submissions and storing metadata (like submission deadlines), connect to smart contract

3. Decentralized Identity (Web3Auth) - Plan
* Users log in with their wallets using Web3Auth for secure, seamless onboarding.

4. Reward Mechanism (Chainlink) - Implemented
* Used Chainlink VRF (Verifiable Random Function) to ensure fair distribution of bonus rewards from the prize pool, particularly for multi-winner projects.

5. Gamification Logic - Plan
* Deadlines and difficulty levels are encoded in the smart contracts, determining how much of the prize pool is allocated based on project difficulty.
* Stake forfeits automatically upon failure, adding to the reward pool for winners and contributors.

By blending blockchain principles with gamification, we built a platform that’s not only functional but also enjoyable, motivating users to learn and succeed in a decentralized manner.

## Installation and Usage

```
npm init -y
npm install --save-dev hardhat
npx hardhat init
npm install --save-dev @nomiclabs/hardhat-ethers ethers chai
npm install --save-dev @nomiclabs/hardhat-ethers ethers @nomiclabs/hardhat-waffle chai
npm install --save-dev @nomicfoundation/hardhat-toolbox
npm install @chainlink/contracts
npm install --save-dev typescript
npm install --save-dev ts-node
npx hardhat test
```
