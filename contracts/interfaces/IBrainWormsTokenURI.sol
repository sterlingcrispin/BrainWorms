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

pragma solidity ^0.8.0;
///
/// @title	Brain Worms TokenURI Interface, part of the Brain Worms Simulation System.
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
interface IBrainWormsTokenURI {
    /// @notice Returns the tokenURI for a given token ID
    /// @param id_ The token ID
    /// @param DNA_ The DNA of the token, up to 9999999999 (34 bits)
    ///        A compressed representation of the token's traits.
    /// @param lifeStats_ The life stats of the token,
    ///        [Stamina, Strength, Dexterity, Generation, Wins, Losses, PVP Points]
    /// @return result The tokenURI for the given token ID
    function tokenURI(
        uint256 id_,
        uint256 DNA_,
        uint16[7] memory lifeStats_
    ) external view returns (string memory result);
}
