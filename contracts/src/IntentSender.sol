// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IAvsLogic.sol";


contract IntentSender is IAvsLogic {
    struct Intent {
        uint256 chainId;
        address to;
        bytes data;
    }

    address public attestationCenter;

    constructor (address _attestationCenter) {
        attestationCenter = _attestationCenter;
    }

    Intent[] public intents;

    uint public relayerId;

    event IntentSent(uint256 block, uint256 relayerId);

    function sendIntent(uint256 chainId, address _to, bytes calldata _data) public {
        intents.push(Intent(chainId, _to, _data));

        emit IntentSent(block.number, relayerId);
        
    }   

    function afterTaskSubmission(uint16 /* _taskDefinitionId */, address /* _performerAddr */, string calldata _proofOfTask, bool /* _isApproved */, bytes calldata /* _tpSignature */, uint256[2] calldata /* _taSignature */, uint256[] calldata /* _operatorIds */) external {
        require(msg.sender == attestationCenter, "Not allowed");

        relayerId = uint(keccak256(abi.encode(block.timestamp))) ^
            uint(keccak256(abi.encode(block.prevrandao))) ^
            uint(keccak256(bytes(_proofOfTask)));
    }

    function beforeTaskSubmission(uint16 _taskDefinitionId, address _performerAddr, string calldata _proofOfTask, bool _isApproved, bytes calldata _tpSignature, uint256[2] calldata _taSignature, uint256[] calldata _operatorIds) external {
        // No implementation
    }
}