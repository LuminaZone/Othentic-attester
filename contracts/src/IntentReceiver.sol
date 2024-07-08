// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntentReceiver {
    struct Intent {
        address to;
        bytes data;
    }

    Intent[] public intents;

    function storeIntent(address _to, bytes calldata _data) public {
        intents.push(Intent(_to, _data));
    }

    function executeIntent() public returns (bool) {
        (bool success, ) = intents[0].to.call(intents[0].data);
        return success;
    }
}
