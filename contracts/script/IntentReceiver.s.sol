// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.20;

/*______     __      __                              __      __
 /      \   /  |    /  |                            /  |    /  |
/$$$$$$  | _$$ |_   $$ |____    ______   _______   _$$ |_   $$/   _______
$$ |  $$ |/ $$   |  $$      \  /      \ /       \ / $$   |  /  | /       |
$$ |  $$ |$$$$$$/   $$$$$$$  |/$$$$$$  |$$$$$$$  |$$$$$$/   $$ |/$$$$$$$/
$$ |  $$ |  $$ | __ $$ |  $$ |$$    $$ |$$ |  $$ |  $$ | __ $$ |$$ |
$$ \__$$ |  $$ |/  |$$ |  $$ |$$$$$$$$/ $$ |  $$ |  $$ |/  |$$ |$$ \_____
$$    $$/   $$  $$/ $$ |  $$ |$$       |$$ |  $$ |  $$  $$/ $$ |$$       |
 $$$$$$/     $$$$/  $$/   $$/  $$$$$$$/ $$/   $$/    $$$$/  $$/  $$$$$$$/
*/
/**
 * @author Othentic Labs LTD.
 * @notice Terms of Service: https://www.othentic.xyz/terms-of-service
 */

import {Script, console} from "forge-std/Script.sol";
import '../src/IAttestationCenter.sol';
import "../src/DestinationAugment.sol";

// How to:
// Either `source ../../.env` or replace variables in command.
// forge script IntentReceiverDeploy --rpc-url $L2_RPC --private-key $PRIVATE_KEY
// --broadcast -vvvv --verify --etherscan-api-key $L2_ETHERSCAN_API_KEY --chain
// $L2_CHAIN --verifier-url $L2_VERIFIER_URL --sig="run(address)" $ATTESTATION_CENTER_ADDRESS
contract IntentReceiverDeploy is Script {
    function setUp() public {}

    function run(address attestationCenter) public {
        vm.startBroadcast();
        IntentReceiver intentReceiver = new IntentReceiver();
        IAttestationCenter(attestationCenter).setAvsLogic(address(intentReceiver));
        DestinationAugment destinationAugment = new DestinationAugment("DestinationAugment", "DSTAUG", address(intentReceiver));
    }
}
