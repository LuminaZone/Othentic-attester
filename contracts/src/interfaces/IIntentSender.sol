// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity  solidity ^0.8.0;

inerface IIntentSender {
    function sendIntent(address _to, bytes calldata _data) external;
}