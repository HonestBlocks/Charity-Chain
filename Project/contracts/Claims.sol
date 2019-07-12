pragma solidity ^0.5.0;

/**
 * @title ClaimsRegistry
 * @dev This is based on the ERC-780 Ethereum Claims Registry (https://github.com/ethereum/EIPs/issues/780)
 * This implementation adds an ability to approve certain claims by an additional entity in the most minimal form.
 * One claim could have multiple approvals.
 */
contract ClaimsRegistry {

    struct foo {
        bytes32 key;
        bytes32 value;
        bool approved;
    }
    mapping(address => mapping(address => mapping(bytes32 => foo))) public registry;
    
    
    event ClaimSet(
        address indexed issuer,
        address indexed subject,
        bytes32 indexed key,
        bytes32 value,
        uint updatedAt);


    event ClaimApproved(
        address approver,
        address indexed issuer,
        address indexed subject,
        bytes32 indexed key,
        bytes32 value,
        uint approvedAt);

    event ClaimRemoved(
        address indexed issuer,
        address indexed subject,
        bytes32 indexed key,
        uint removedAt);

    // create or update claims
    function setClaim(address subject, bytes32 key, bytes32 value) public {
        registry[msg.sender][subject][key].value = value;
        registry[msg.sender][subject][key].approved=false;
        emit ClaimSet(msg.sender, subject, key, value, now);
    }

    function setSelfClaim(bytes32 key, bytes32 value) public {
        setClaim(msg.sender, key, value);
    }

    function getClaim(address issuer, address subject, bytes32 key) public view returns(bytes32) {
        return registry[issuer][subject][key].value;
    }

    function removeClaim(address subject, bytes32 key) public {
        delete registry[msg.sender][subject][key];
        emit ClaimRemoved(msg.sender, subject, key, now);
    }

    // Explicit approvals are not currently used, claims are approved implicitly
    // by Project.validateOutcome function.

    function approveClaim(address issuer, address subject, bytes32 key) public {
        bytes32 value = getClaim(issuer, subject, key);
        registry[msg.sender][subject][key].value = value;
        registry[msg.sender][subject][key].approved=true;

        emit ClaimApproved(msg.sender, issuer, subject, key, value, now);
    }

    function isApproved(address issuer, address subject, bytes32 key) public view returns(bool) {
        return registry[issuer][subject][key].approved;
    }
}
