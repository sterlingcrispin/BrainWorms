//SPDX-License-Identifier: MIT
//////////////////////////////////////////////////////////////////////////////
//                                                                          //
//                              DELCOMPLEXDEL                               //
//                      DELCOMPLEXDELCOMPLEXDELCOMPLE                       //
//                 DELCOMPLE                     DELCOMPLE                  //
//              DELCOMP                               DELCOMP               //
//           DELCOM                                       DELCOM            //
//         DELCOM                                             DELCOM        //
//       DELCOM                                                 DELCOM      //
//      DELC       DELCOMPLEXDELCOMPLEXDELCOMPLEXDELCOMPLE       DELCOM     //
//    DELCOM        DELCOMPLEXDELCOMPLEXDELCOMPLEXDELCOMPL         DELCOM   //
//   DELC            DELCOMPLEXDELCOMPLEXDELCOMPLEXDELCOM            DELC   //
//  DELC              DELCOMPL                    DELCOM              DELC  //
//  DELC               DELCOMPL                  DELCOM               DELC  //
// DELC                 DELCOMPL                DELCOM                 DELC //
// DELC                  DELCOMPL              DELCOM                  DELC //
// DELC                   DELCOMPL           DELCOM                    DELC //
// DELC                    DELCOMPL         DELCOM                     DELC //
// DELC                     DELCOMPL       DELCOM                      DELC //
//  DELC                     DELCOMPL     DELCOM                      DELC  //
//  DELC                      DELCOMPL   DELCOM                       DELC  //
//   DELC                      DELCOMPLEXDELC                       DELCO   //
//    DELCOM                     DELCOMPLEXD                       DELCOM   //
//      DELC                     DELCOMPLE                       DELCOMP    //
//       DELCOM                    DELCOM                       DELCOM      //
//         DELCOM                   DELC                       DELCOM       //
//           DELCOM                 DEL                   DELCOMPL          //
//              DELCOMP                               DELCOMPL              //
//                 DELCOMPLE                     DELCOMPLE                  //
//                      DELCOMPLEXDELCOMPLEXDELCOMPLE                       //
//                              DELCOMPLEXDEL                               //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////

pragma solidity ^0.8.24;

import {LibPRNG} from "solady/src/utils/LibPRNG.sol";
import {IBrainWormsCombatSystem} from "./interfaces/IBrainWormsCombatSystem.sol";
import {IBrainWormsResourceHarvesting} from "./interfaces/IBrainWormsResourceHarvesting.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

///
/// @title	Brain Worms Combat System, part of the Brain Worms Simulation System.
///
/// @author	Sterling Crispin,
///		@ sterlingcrispin
///		Del Complex, Brain Worm Research Program
///		http://www.delcomplex.com
///     @ delcomplex
///
/// @notice	Our long term goal is to genetically engineer parasitic
///		worms to secrete cognitive enhancing biomolecules. Thus
///		increasing the intelligence of the host human. With
///		Brain Worms, we will accelerate the human species in
///		order to compete with AGI.
///
///		The Brain Worm implantation process begins at the nose.
///		We inject them via intranasal delivery to bypass the
///		blood-brain barrier and enable direct access to the brain.
///		Once inside, they compete for limited resources found in
///		the interstitial fluid of the brain such as glucose,
///		amino acids, and micronutrients. Thus, the Brain Worm
///		Simulation is a critical step in understanding the
///		behavior of the worms in a hostile environment.
///
///		As users interact with the Brain Worm Simulation, engage
///		with PVP combat, and gather resources, our scientists
///		will learn from the data and improve our biological
///		Brain Worms.
///
///		Del Complex produces tangible, digital, intangible,
///		rhizomatic, and hyperstitional products. Details
///		provided may relate to hyperstitional elements.
///
///
///	@custom:warranty The software is provided "as is", without
///     warranty of any kind, express or implied, including but
///     not limited to the warranties of merchantability, fitness
///     for a particular purpose and noninfringement. In no event
///     shall the authors or copyright holders be liable for any claim,
///		damages or other liability, whether in an action of
///		contract, tort or otherwise, arising from, out of or in
///		connection with the software or the use or other dealings
///		in the software.
///
///
/// @dev This is not a place of honor, no highly esteemed deed is
///		commemorated here, nothing valued is here. What is here
///		was dangerous and repulsive to us. This message is a
///		warning about danger. The danger is in a particular
///		location, it increases towards the center, the center of
///		danger is here, of a particular size and shape, and
///		below us.
///
contract BrainWormsCombatSystem is IBrainWormsCombatSystem, Ownable {
    /// @dev DELRIN
    uint256 public DELRIN = 6485;

    /// @dev PRNG for generating random numbers, thanks Vectorized
    using LibPRNG for *;

    /// @dev The last block a fight occurred to prevent spamming
    mapping(uint256 => uint256) private lastFightBlock;

    /// @dev The allowed contracts that can call the fight function
    mapping(address => bool) public allowedContracts;

    // Combat states
    uint8 constant ATTACKER_GOES_FIRST = 0;
    uint8 constant P1_CRITICAL_HIT = 1;
    uint8 constant P2_CRITICAL_HIT = 2;
    uint8 constant P1_MISS = 3;
    uint8 constant P2_MISS = 4;

    /// @dev The Brain Worms Resource Harvesting contract
    ///      set during deployment and for upgrades to the system.
    IBrainWormsResourceHarvesting public resourceHarvesting;

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Constructor

    /// @notice Constructor for the Brain Worms Combat System
    /// @param initialOwner_ The initial owner of the contract
    constructor(address initialOwner_) Ownable(initialOwner_) {}

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // External Functions

    /// @notice Fight two brain worms against each other
    /// @dev This function is the main entry point for the Combat System.
    ///      The results of this function will only be recorded to the Brain
    ///      Worms properties if called from the primary contract. Otherwise, it just
    ///      emits the values for the caller to record. This is how Guest Mode
    ///      works on the Brain Worms Simulation System website.
    ///
    ///      Decentralization means code by the people, of the people, for the people.
    ///      But the people are retarded. And unfortunately, so am I. This contract
    ///      is a testament to that. There are a lot of ugly things in here. I'm sorry.
    ///      May god have mercy on my soul.
    /// @param fightCount_ The number of fights that have occurred
    /// @param tokenIdAttacker_ The token ID of the attacking worm
    /// @param tokenIdDefender_ The token ID of the defending worm
    /// @param p1Attributes The attributes of the attacking worm
    ///        which is [stamina, strength, dexterity, isDefensiveStance]
    /// @param p2Attributes The attributes of the defending worm
    ///        which is [stamina, strength, dexterity, isDefensiveStance]
    /// @param p1PVPPoints_ The PVP points of the attacking worm
    /// @param p2PVPPoints_ The PVP points of the defending worm
    /// @param attackType_ The type of attack, true for Bite a strength
    ///        modifying attack or false for Sting a dexterity modifying attack
    function fightBrainWorms(
        uint256 fightCount_,
        uint256 tokenIdAttacker_,
        uint256 tokenIdDefender_,
        uint8[4] memory p1Attributes,
        uint8[4] memory p2Attributes,
        uint16 p1PVPPoints_,
        uint16 p2PVPPoints_,
        bool attackType_
    ) external returns (bool didAttackerWin, uint16[2] memory PvpPoints) {
        // Ensure the caller is not a contract
        // The PRNG was never really meant to be secure as its
        // not balance altering function
        require(
            !isContract(msg.sender) || allowedContracts[msg.sender],
            "Caller is not allowed to interact with this contract"
        );

        // Ensure the worms have not fought in this block to prevent spamming
        require(
            lastFightBlock[tokenIdAttacker_] < block.number,
            "Attacker has already fought in this block"
        );
        require(
            lastFightBlock[tokenIdDefender_] < block.number,
            "Defender has already fought in this block"
        );

        lastFightBlock[tokenIdAttacker_] = block.number;
        lastFightBlock[tokenIdDefender_] = block.number;

        // Ensure the worms are not the same
        require(
            tokenIdAttacker_ != tokenIdDefender_,
            "Worms cannot fight themselves"
        );
        // Create a new PRNG instance
        LibPRNG.PRNG memory prng;
        // Seed the PRNG
        prng.seed(
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.timestamp,
                        block.prevrandao,
                        msg.sender,
                        tokenIdAttacker_,
                        tokenIdDefender_
                    )
                )
            )
        );
        // Who did what indexed by constants
        bool[5] memory combatStates;

        // Roll for initiative
        {
            // add attackers full dex to the roll
            uint8 p1Roll = uint8(prng.next() % 20) + p1Attributes[2];
            // subtract half the defenders stamina from their roll,
            // if their roll is greater than half the defenders stamina
            uint8 p2Roll = uint8(prng.next() % 20);
            p2Roll = p2Roll > p2Attributes[0] / 2
                ? p2Roll - p2Attributes[0] / 2
                : 0;
            combatStates[ATTACKER_GOES_FIRST] = p1Roll > p2Roll;
        }

        // Perform attacks considering first attack advantage
        // represents p1 stamina, p2 stamina, and a memory slot for the pvpPointsChange
        int8[3] memory attackResults = conductAttacks(
            tokenIdAttacker_,
            tokenIdDefender_,
            combatStates[ATTACKER_GOES_FIRST],
            p1Attributes,
            p2Attributes,
            p1PVPPoints_,
            p2PVPPoints_,
            combatStates,
            prng,
            attackType_
        );

        // if the staminas are the same, then both players missed and the attacker loses
        if (combatStates[P1_MISS] && combatStates[P2_MISS]) {
            didAttackerWin = false;
        } else {
            // Determine the winner based on remaining stamina
            didAttackerWin = attackResults[0] > attackResults[1];
        }

        // Harvest resources from the loser if conditions are met
        uint256 resourceAmountTransferred;
        if (didAttackerWin) {
            resourceAmountTransferred = resourceHarvesting.vampireHarvest(
                tokenIdAttacker_,
                tokenIdDefender_
            );
        } else {
            resourceAmountTransferred = resourceHarvesting.vampireHarvest(
                tokenIdDefender_,
                tokenIdAttacker_
            );
        }
        // Calculate the new PVP points and the change in PVP points
        (PvpPoints, attackResults[2]) = calculatePvpPoints(
            didAttackerWin,
            uint256(p1PVPPoints_),
            uint256(p2PVPPoints_)
        );

        // I'd prefer to just emit it here but the stack is too deep already.
        // If there's a way I could have avoided this, then
        // I will face god and walk backwards into hell.
        emitBattleResultEvent(
            fightCount_,
            tokenIdAttacker_,
            tokenIdDefender_,
            combatStates,
            p1Attributes[0],
            p2Attributes[0],
            didAttackerWin,
            resourceAmountTransferred,
            PvpPoints,
            attackResults[2]
        );

        // let the caller know if the attacker won
        return (didAttackerWin, PvpPoints);
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Internal Functions

    /// @notice Conduct the attacks between two worms
    /// @dev This function is the core of the combat system. Woe to those who
    ///      read it. It is a dark and terrible place.
    /// @param tokenIdAttacker The token ID of the attacking worm
    /// @param tokenIdDefender The token ID of the defending worm
    /// @param attackerGoesFirst Whether the attacker goes first
    /// @param p1Attributes The attributes of the attacking worm
    ///        which is [stamina, strength, dexterity, isDefensiveStance]
    /// @param p2Attributes The attributes of the defending worm
    ///        which is [stamina, strength, dexterity, isDefensiveStance]
    /// @param p1PVPPoints The PVP points of the attacking worm
    /// @param p2PVPPoints The PVP points of the defending worm
    /// @param combatStates The states of the combat
    /// @param prng The PRNG for generating random numbers
    /// @param attackType_ The type of attack, true for Bite a strength
    ///        modifying attack or false for Sting a dexterity modifying attack
    function conductAttacks(
        uint256 tokenIdAttacker,
        uint256 tokenIdDefender,
        bool attackerGoesFirst,
        uint8[4] memory p1Attributes,
        uint8[4] memory p2Attributes,
        uint16 p1PVPPoints,
        uint16 p2PVPPoints,
        bool[5] memory combatStates,
        LibPRNG.PRNG memory prng,
        bool attackType_
    ) internal view returns (int8[3] memory) {
        // scope for preventing stack too deep
        unchecked {
            // rank bonus is 1-99, benefitting higher ranked players
            // and divided by 20 to get a 4 point bonus
            uint8 p1RankBonus = uint8(
                resourceHarvesting.getPlayerRanking(tokenIdAttacker, 0) / 20
            );

            p1Attributes[
                resourceHarvesting.resourceTypeBeingHarvested(tokenIdAttacker)
            ] += p1RankBonus;

            uint8 p2RankBonus = uint8(
                resourceHarvesting.getPlayerRanking(tokenIdDefender, 0) / 20
            );

            p2Attributes[
                resourceHarvesting.resourceTypeBeingHarvested(tokenIdDefender)
            ] += p2RankBonus;

            // Add the stance bonus
            // either +2 to strength or +2 to dexterity
            // depending on the stance
            // and another +1 to either depending on attack type
            // this is a bit clunky looking but condenses the logic for slightly better gas
            p1Attributes[1] += (p1Attributes[3] == 0)
                ? attackType_
                    ? 3
                    : 2
                : attackType_
                    ? 1
                    : 0;
            p1Attributes[2] += (p1Attributes[3] == 1)
                ? !attackType_
                    ? 3
                    : 2
                : !attackType_
                    ? 1
                    : 0;

            p2Attributes[1] += (p2Attributes[3] == 0) ? 2 : 0;
            p2Attributes[2] += (p2Attributes[3] == 1) ? 2 : 0;

            // now add PVP Points to the attributes,
            // 1 for each 100 points
            // up to a max of 25
            if (p1PVPPoints > 0) {
                uint8 p1Bonus = uint8(p1PVPPoints / 100);
                p1Bonus = p1Bonus > 25 ? 25 : p1Bonus;
                p1Attributes[0] += p1Bonus;
                p1Attributes[1] += p1Bonus;
                p1Attributes[2] += p1Bonus;
            }

            if (p2PVPPoints > 0) {
                uint8 p2Bonus = uint8(p2PVPPoints / 100);
                p2Bonus = p2Bonus > 25 ? 25 : p2Bonus;
                p2Attributes[0] += p2Bonus;
                p2Attributes[1] += p2Bonus;
                p2Attributes[2] += p2Bonus;
            }
        }

        // Perform attacks considering first attack advantage
        if (attackerGoesFirst) {
            // Player 1 attacks first
            (
                p2Attributes[0],
                combatStates[P1_CRITICAL_HIT],
                combatStates[P1_MISS]
            ) = performAttack(
                p1Attributes[1],
                p1Attributes[2],
                p2Attributes[0],
                p2Attributes[2],
                prng
            );
            // If Player 2 is still alive, they counter attack
            if (p2Attributes[0] > 0) {
                (
                    p1Attributes[0],
                    combatStates[P2_CRITICAL_HIT],
                    combatStates[P2_MISS]
                ) = performAttack(
                    p2Attributes[1],
                    p2Attributes[2],
                    p1Attributes[0],
                    p1Attributes[2],
                    prng
                );
            }
        } else {
            // Player 2 attacks first
            (
                p1Attributes[0],
                combatStates[P2_CRITICAL_HIT],
                combatStates[P2_MISS]
            ) = performAttack(
                p2Attributes[1],
                p2Attributes[2],
                p1Attributes[0],
                p1Attributes[2],
                prng
            );
            // If Player 1 is still alive, they counter attack
            if (p1Attributes[0] > 0) {
                (
                    p2Attributes[0],
                    combatStates[P1_CRITICAL_HIT],
                    combatStates[P1_MISS]
                ) = performAttack(
                    p1Attributes[1],
                    p1Attributes[2],
                    p2Attributes[0],
                    p2Attributes[2],
                    prng
                );
            }
        }

        return [int8(p1Attributes[0]), int8(p2Attributes[0]), int8(0)];
    }

    /// @notice Perform an attack between two worms
    /// @param attackerStrength The strength of the attacker
    /// @param attackerDexterity The dexterity of the attacker
    /// @param defenderStamina The stamina of the defender
    /// @param defenderDexterity The dexterity of the defender
    /// @param prng The PRNG for generating random numbers
    function performAttack(
        uint8 attackerStrength,
        uint8 attackerDexterity,
        uint8 defenderStamina,
        uint8 defenderDexterity,
        LibPRNG.PRNG memory prng
    ) internal pure returns (uint8, bool, bool) {
        // roll for hit chance and dodge chance
        uint8 hitChance = uint8(prng.next() % 20);
        uint8 dodgeChance = uint8(prng.next() % 20);
        bool criticalHit = false;
        bool miss = false;

        // Critical hit, direct knock-out
        if (hitChance + attackerDexterity / 2 >= 22) {
            criticalHit = true;
            // rekt
            defenderStamina = 0;
        } else if (
            hitChance + attackerStrength > dodgeChance + defenderDexterity
        ) {
            // attack landed, calculate damage
            uint8 damage = uint8(prng.next() % 10) + attackerStrength / 2;
            // apply damage
            defenderStamina = (damage >= defenderStamina)
                ? 0
                : (defenderStamina - damage);
        } else {
            // Attack missed, no damage dealt
            miss = true;
        }
        return (defenderStamina, criticalHit, miss);
    }

    /// @notice Calculate the new PVP points and the change in PVP points
    /// @param attackerWon Whether the attacker won
    /// @param p1Score The PVP points of the attacking worm
    /// @param p2Score The PVP points of the defending worm
    function calculatePvpPoints(
        bool attackerWon,
        uint256 p1Score,
        uint256 p2Score
    ) internal pure returns (uint16[2] memory PvpPoints, int8 pvpPointsChange) {
        // rating difference impacts the points change giving
        // more to the lower rank, and less to the higher rank
        int256 ratingDifference;
        if (attackerWon) {
            ratingDifference = int256(p2Score) - int256(p1Score);
        } else {
            ratingDifference = int256(p1Score) - int256(p2Score);
        } // is the absolute diff greater than 100? then no change
        if (
            ratingDifference >= 0
                ? ratingDifference > 100
                : -ratingDifference > 100
        ) {
            PvpPoints[0] = uint16(p1Score);
            PvpPoints[1] = uint16(p2Score);
            return (PvpPoints, 0);
        }
        // calculate the points change
        // the higher the total PVP points, the less points change
        // making it harder to climb the ranks at the higher levels
        int256 baseChange = 0;
        int256 changeModifier = 0;
        if (p1Score <= 2099) {
            baseChange = 16000;
            changeModifier = 40;
        } else if (p1Score <= 2400) {
            baseChange = 12000;
            changeModifier = 30;
        } else {
            baseChange = 8000;
            changeModifier = 20;
        }
        // calculate the points change
        uint256 pointsChange = uint256(
            ((changeModifier * ratingDifference) + baseChange) / 1000
        );
        // apply the points change
        if (attackerWon) {
            p1Score += pointsChange;
            p2Score = p2Score >= pointsChange ? p2Score - pointsChange : 0;
        } else {
            p1Score = p1Score >= pointsChange ? p1Score - pointsChange : 0;
            p2Score += pointsChange;
        }
        // return the new PVP points and the change in PVP points
        PvpPoints[0] = uint16(p1Score);
        PvpPoints[1] = uint16(p2Score);
        return (PvpPoints, int8(int256(pointsChange)));
    }

    /// @notice Check if an address is a contract
    /// @dev This function is used to prevent contracts from fighting
    ///      in the Brain Worms Combat System. Honestly I knew this was
    ///      going to be an issue but figured it would be funny to watch
    ///      someone blast other people's worms by exploiting the PRNG.
    ///      If that was you, hit me up on twitter and I'll mail you a
    ///      Brain Worm gift for taking the time to screw with it.
    /// @param account The address to check
    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Private Functions

    /// @notice Emit the battle result event
    /// @dev In a perfect world, functions like this wouldn't exist. But this is not
    ///      a perfect world.
    /// @param fightCount_ The number of fights that have occurred
    /// @param tokenIdAttacker_ The token ID of the attacking worm
    /// @param tokenIdDefender_ The token ID of the defending worm
    /// @param combatStates The states of the combat
    /// @param p1Stamina The stamina of the attacking worm
    /// @param p2Stamina The stamina of the defending worm
    /// @param didAttackerWin Whether the attacker won
    /// @param resourceAmountTransferred The amount of resources transferred
    /// @param PvpPoints The new PVP points
    /// @param PvpPointsChange The change in PVP points
    function emitBattleResultEvent(
        uint256 fightCount_,
        uint256 tokenIdAttacker_,
        uint256 tokenIdDefender_,
        bool[5] memory combatStates,
        uint8 p1Stamina,
        uint8 p2Stamina,
        bool didAttackerWin,
        uint256 resourceAmountTransferred,
        uint16[2] memory PvpPoints,
        int8 PvpPointsChange
    ) private {
        // Emit the battle result event
        emit IBrainWormsCombatSystem.BattleResult(
            fightCount_,
            tokenIdAttacker_,
            tokenIdDefender_,
            combatStates[ATTACKER_GOES_FIRST],
            combatStates[P1_CRITICAL_HIT],
            combatStates[P2_CRITICAL_HIT],
            combatStates[P1_MISS],
            combatStates[P2_MISS],
            p1Stamina,
            p2Stamina,
            didAttackerWin,
            resourceAmountTransferred,
            PvpPoints[0],
            PvpPoints[1],
            PvpPointsChange
        );
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Owner Only Functions

    /// @notice Set the Brain Worms Resource Harvesting contract
    /// @param resourceHarvesting_ The Brain Worms Resource Harvesting contract
    function setResourceHarvesting(
        address resourceHarvesting_
    ) external onlyOwner {
        resourceHarvesting = IBrainWormsResourceHarvesting(resourceHarvesting_);
    }

    /// @notice Set allowed contracts that can call the fight function
    /// @dev to prevent abuse
    /// @param contractAddress The address of the contract
    function setContractAllowance(
        address contractAddress,
        bool isAllowed
    ) external onlyOwner {
        allowedContracts[contractAddress] = isAllowed;
    }
}
