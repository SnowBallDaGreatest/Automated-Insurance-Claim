// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IOracle {
    function isEventVerified(uint256 claimId) external view returns (bool);
}

// === Mock Oracle for testing ===
contract MockOracle is IOracle {
    mapping(uint256 => bool) public eventVerified;

    function setEventVerified(uint256 claimId, bool status) external {
        eventVerified[claimId] = status;
    }

    function isEventVerified(uint256 claimId) external view override returns (bool) {
        return eventVerified[claimId];
    }
}

// === Main Insurance Contract ===
contract AutomatedInsuranceClaims {
    struct Policy {
        address payable holder;
        uint256 premium;
        uint256 coverageAmount;
        bool isActive;
    }
    struct Claim {
        uint256 policyId;
        uint256 payoutAmount;
        bool isVerified;
        bool isSettled;
    }

    mapping(uint256 => Policy) public policies;
    mapping(uint256 => Claim) public claims;
    uint256 public nextPolicyId = 1;
    uint256 public nextClaimId = 1;
    address public insurer;
    IOracle public oracle;

    event PolicyPurchased(uint256 policyId, address holder, uint256 coverage);
    event ClaimSubmitted(uint256 claimId, uint256 policyId);
    event ClaimSettled(uint256 claimId, uint256 payout);

    constructor(address _oracle) {
        insurer = msg.sender;
        oracle = IOracle(_oracle);
    }

    function purchasePolicy() external payable {
        require(msg.value > 0, "Premium required");
        policies[nextPolicyId] = Policy({
            holder: payable(msg.sender),
            premium: msg.value,
            coverageAmount: msg.value * 10,
            isActive: true
        });
        emit PolicyPurchased(nextPolicyId, msg.sender, msg.value * 10);
        nextPolicyId++;
    }

    function submitClaim(uint256 policyId) external {
        Policy storage policy = policies[policyId];
        require(policy.isActive, "Policy inactive");
        require(policy.holder == msg.sender, "Not policyholder");
        claims[nextClaimId] = Claim({
            policyId: policyId,
            payoutAmount: policy.coverageAmount,
            isVerified: false,
            isSettled: false
        });
        emit ClaimSubmitted(nextClaimId, policyId);
        nextClaimId++;
    }

    function settleClaim(uint256 claimId) external {
        Claim storage claim = claims[claimId];
        Policy storage policy = policies[claim.policyId];
        require(policy.isActive, "Policy inactive");
        require(!claim.isSettled, "Already settled");
        bool verified = oracle.isEventVerified(claimId);
        require(verified, "Event not verified");
        claim.isVerified = true;
        claim.isSettled = true;
        policy.isActive = false; // Disable policy after payout
        policy.holder.transfer(claim.payoutAmount);
        emit ClaimSettled(claimId, claim.payoutAmount);
    }
}
