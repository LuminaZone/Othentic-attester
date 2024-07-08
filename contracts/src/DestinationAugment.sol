// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

import "./IntentReceiver.sol";
import "./IAvsLogic.sol";

contract DestinationAugment is
    ERC20,
    ERC20Burnable,
    ERC20Pausable,
    AccessControl
{
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    address public intentReceiver;

    constructor(string memory name, string memory symbol, address intentReceiver) ERC20(name, symbol) {
        // Grant the contract deployer the default admin role: they can grant and revoke any roles
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);

        // Grant the minter and pauser roles to the deployer
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, intentReceiver);
        intentReceiver=intentReceiver;
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function teleport(uint256 chainId, address to, uint256 amount) external {
        _burn(msg.sender, amount);
        // build abi function call
        bytes4 selector = bytes4(keccak256(bytes("mint(address,uint256)")));
        IntentReceiver(intentReceiver).storeIntent(to, abi.encodeWithSelector(selector, to, amount));
        IntentReceiver(intentReceiver).executeIntent();
    }

    function _update(
        address from,
        address to,
        uint256 value
    ) internal virtual override(ERC20, ERC20Pausable) whenNotPaused {
        super._update(from, to, value);
    }
}
