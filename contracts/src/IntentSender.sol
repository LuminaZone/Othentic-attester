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

    struct TaskInfo {
        string proofOfTask;
        bytes data;
        address taskPerformer;
        uint16 taskDefinitionId;
    }

    Intent[] public intents;

    uint public relayerId;

    event IntentSent(uint256 block, uint256 relayerId, uint256 chainId, address _to, bytes _data);

    function sendIntent(uint256 chainId, address _to, bytes calldata _data) public {
        intents.push(Intent(chainId, _to, _data));

        emit IntentSent(block.number, relayerId, chainId, _to, _data);
        
    }   

    function beforeTaskSubmission(uint16 _taskDefinitionId, address _performerAddr, string calldata _proofOfTask, bool _isApproved, bytes calldata _tpSignature, uint256[2] calldata _taSignature, uint256[] calldata _operatorIds) external {
        // No implementation
    }
}