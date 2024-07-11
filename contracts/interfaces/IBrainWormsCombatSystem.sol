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
///
/// @title	Brain Worms Combat System Interface,
///         part of the Brain Worms Simulation System.
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
interface IBrainWormsCombatSystem {
    /// @notice Fight two brain worms against each other
    /// @dev This function is the main entry point for the Combat System.
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
    ) external returns (bool didAttackerWin, uint16[2] memory PvpPoints);

    /// @notice Battle results for a fight between two brain worms
    /// @param battleId The global ID of the battle that increments with each fight
    /// @param tokenIdPlayer1 The token ID of the attacker player
    /// @param tokenIdPlayer2 The token ID of the defender player
    /// @param didPlayer1RollInitiative True if the attacker rolled initiative
    /// @param didPlayer1CriticalHit True if the attacker landed a critical hit
    /// @param didPlayer2CriticalHit True if the defender landed a critical hit
    /// @param didPlayer1Miss True if the attacker missed
    /// @param didPlayer2Miss True if the defender missed
    /// @param staminaRemainingPlayer1 The remaining stamina of the attacker
    /// @param staminaRemainingPlayer2 The remaining stamina of the defender
    /// @param didPlayer1Win True if the attacker won
    /// @param resourceAmountTransferred The amount of resources transferred
    /// @param p1PvpPoints The PVP points of the attacker
    /// @param p2PvpPoints The PVP points of the defender
    /// @param PvpPointsChange The change in PVP points
    event BattleResult(
        uint256 indexed battleId,
        uint256 indexed tokenIdPlayer1,
        uint256 indexed tokenIdPlayer2,
        bool didPlayer1RollInitiative,
        bool didPlayer1CriticalHit,
        bool didPlayer2CriticalHit,
        bool didPlayer1Miss,
        bool didPlayer2Miss,
        uint8 staminaRemainingPlayer1,
        uint8 staminaRemainingPlayer2,
        bool didPlayer1Win,
        uint256 resourceAmountTransferred,
        uint16 p1PvpPoints,
        uint16 p2PvpPoints,
        int8 PvpPointsChange
    );
}
