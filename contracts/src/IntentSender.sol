// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract IntentSender {
    struct Intent {
        address to;
        bytes data;
    }

    Intent[] public intents;

    function sendIntent(address _to, bytes calldata _data) public {
        intents.push(Intent(_to, _data));
    }
}