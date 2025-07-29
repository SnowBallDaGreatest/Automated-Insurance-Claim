Automated Insurance Claims: Use smart contracts to automatically verify and settle insurance claims by pulling in third-party data, reducing fraud and speeding up payouts
Project Description
This project demonstrates how smart contracts on the Ethereum blockchain can be used to automate the entire insurance claims process. By leveraging oracles to fetch third-party data, the contract can autonomously verify insured events, reduce fraud, and facilitate instant, trustless payouts.

Project Vision
To create a fair, transparent, and efficient insurance ecosystem where claims are settled instantly and reliably based on verifiable external data, removing manual intervention, increasing trust, and cutting operational costs for both insurers and policyholders.

Key Features
-Automated Policy Issuance: Users can purchase insurance policies directly through the contract.

-Simplified Claims Process: Policyholders can submit claims seamlessly.

-Oracle-powered Verification: Claims settlements occur only after third-party data (provided via oracles) confirms that an insurable event occurred.

-Fraud Prevention: Only verified events can trigger payouts, minimizing risk.

-Transparency: All actions are auditable on-chain.

Core Smart Contract Functions
-purchasePolicy(): Allows users to buy an insurance policy by paying a premium.

-submitClaim(policyId): Lets a policyholder submit a claim for an existing active policy.

-settleClaim(claimId): Automatically checks with the oracle, then pays out if the event is verified.

Future Scope
-Integration with real-world decentralized oracle networks (e.g., Chainlink) for live data feeds.

-Support for multiple types of insurance products (weather, travel, health, etc.).

-Improved claim assessment using multiple oracles and consensus mechanisms.

-Regulatory and compliance feature extensions.

-Mobile/web front-end interface for ease of use.

How to use:

. Deploy the contract, passing the oracle contract address.

. Users purchasePolicy() with ETH to get insured.

. Users call submitClaim() if an event occurs.

. Anyone can call settleClaim(), which checks the oracle; if verified, an instant payout is made.

Getting Started

. Clone the repository

. Install dependencies: npm install

. Compile contracts: npx hardhat compile

. Deploy to testnet: npx hardhat run scripts/deploy.js --network sepolia

. Verify contract: npx hardhat verify --network sepolia 0xCfD6C4188A59D860258445E0b676338B40965AA5

<img width="1795" height="825" alt="image" src="https://github.com/user-attachments/assets/dd9f4b06-cc17-4d65-9fe7-fa08e7de7d82" />
