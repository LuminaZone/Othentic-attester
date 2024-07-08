// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntentReceiver {
    struct Intent {
        address to;
        bytes data;
    }

    struct TaskInfo {
        string proofOfTask;
        bytes data;
        address taskPerformer;
        uint16 taskDefinitionId;
    }

    Intent[] public intents;

     function afterTaskSubmission(TaskInfo calldata taskInfo, bool /* _isApproved */, bytes calldata /* _tpSignature */, uint256[2] calldata /* _taSignature */, uint256[] calldata /* _operatorIds */) external {
        require(msg.sender == address(0xBd807c381ac67616618819D05300cccfD2aAB6d0), "Not allowed");

        (uint chainId, address to, bytes memory data)= abi.decode(taskInfo.data, (uint, address, bytes));

        storeIntent(to, data);
        executeIntent();
    }

    function storeIntent(address _to, bytes memory _data) public {
        intents.push(Intent(_to, _data));
    }

    function executeIntent() public returns (bool) {
        (bool success, ) = intents[0].to.call(intents[0].data);
        return success;
    }
}
