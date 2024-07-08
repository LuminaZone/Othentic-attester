pragma solidity >=0.8.20;

interface IIntentSender {
    function sendIntent(uint256 chainId, address _to, bytes calldata _data) external;
}