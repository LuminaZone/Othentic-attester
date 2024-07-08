// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntentReceiver {
    struct Intent {
        address to;
        bytes data;
    }

    Intent[] public intents;

     function afterTaskSubmission(TaskInfo calldata taskInfo, bool /* _isApproved */, bytes calldata /* _tpSignature */, uint256[2] calldata /* _taSignature */, uint256[] calldata /* _operatorIds */) external {
        require(msg.sender == attestationCenter, "Not allowed");

        //
        taskInfo.taskPerformer = msg.sender;
        (uint chainId, address to, bytes memory data)= abi.decode(taskInfo.data, (uint, address, bytes));

        storeIntent(to, data);
        executeIntent();
    }

    function storeIntent(address _to, bytes calldata _data) public {
        intents.push(Intent(_to, _data));
    }

    function executeIntent() public returns (bool) {
        (bool success, ) = intents[0].to.call(intents[0].data);
        return success;
    }
}
