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
/// @title	Brain Worms Resource Storage Interface,
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

interface IBrainWormsResourceStorage {
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Events

    // Events - increase

    /// @notice Emitted when a token's resource balance is increased
    /// @param tokenId The token ID
    /// @param resourceType The type of resource
    /// @param amount The amount of the resource
    event ResourceBalanceIncreased(
        uint256 indexed tokenId,
        uint256 indexed resourceType,
        uint256 amount
    );

    /// @notice Emitted when a token's resource balance is increased
    /// @param tokenId The token ID
    /// @param resourceAmounts The amounts of the resources
    event MultiResourceBalanceIncreased(
        uint256 indexed tokenId,
        uint256[] resourceAmounts
    );

    // Events - decrease

    /// @notice Emitted when a token's resource balance is deleted
    /// @param tokenId The token ID
    event TokensEntireBalanceDeleted(uint256 indexed tokenId);

    /// @notice Emitted when a token's resource balance is decreased
    /// @param tokenId The token ID
    /// @param resourceType The type of resource
    /// @param amount The amount of the resource
    event ResourceBalanceDecreased(
        uint256 indexed tokenId,
        uint256 indexed resourceType,
        uint256 amount
    );

    /// @notice Emitted when a token's resource balance is decreased
    /// @param tokenId The token ID
    /// @param resourceAmounts The amounts of the resources
    event MultiResourceBalanceDecreased(
        uint256 indexed tokenId,
        uint256[] resourceAmounts
    );

    // Events - set

    /// @notice Emitted when the number of valid resource types is changed
    /// @param count The new count of resource types
    event ResourceTypeCountSet(uint256 count);

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // External

    /// @notice Increase a specific resource amount for a specific token ID
    /// @param tokenId The token ID
    /// @param resourceType The type of resource
    /// @param amount The amount of the resource
    function increaseBalance(
        uint256 tokenId,
        uint256 resourceType,
        uint256 amount
    ) external;

    /// @notice Increase multiple resources for a specific token ID
    /// @param tokenId The token ID
    /// @param resourceAmounts The amounts of the resources
    function increaseMultiBalance(
        uint256 tokenId,
        uint256[] calldata resourceAmounts
    ) external;

    /// @notice Decrease a specific resource amount for a specific token ID
    /// @param tokenId The token ID
    /// @param resourceType The type of resource
    /// @param amount The amount of the resource
    function decreaseBalance(
        uint256 tokenId,
        uint256 resourceType,
        uint256 amount
    ) external;

    /// @notice Decrease multiple resources for a specific token ID
    /// @param tokenId The token ID
    /// @param resourceAmounts The amounts of the resources
    function decreaseMultiBalance(
        uint256 tokenId,
        uint256[] calldata resourceAmounts
    ) external;

    /// @notice Delete all resources for a specific token ID
    /// @param tokenId The token ID
    function deleteTokensEntireBalance(uint256 tokenId) external;

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // External View

    /// @notice Get the number of valid resource types
    /// @return The count of valid resource types
    function getResourceTypeCount() external view returns (uint256);

    /// @notice Get the total resources harvested by all
    ///         tokens for a specific resource type
    /// @param resourceType The type of resource
    function getTotalResourcesByType(
        uint256 resourceType
    ) external view returns (uint256);

    /// @notice Get the total resources harvested by all tokens
    ///         for all resource types
    /// @return The total resources harvested
    function getTotalResources() external view returns (uint256);

    /// @notice Get the highest players resource value so far
    ///         for a specific resource type
    /// @param resourceType The type of resource
    /// @return The highest resource value so far
    function getHighestResourceValueSoFarByType(
        uint256 resourceType
    ) external view returns (uint256);

    /// @notice Get all the resource balances for a specific tokenID
    function getMultiResourceBalance(
        uint256 tokenId
    ) external view returns (uint256[] memory);

    /// @notice Get the resource balance for a specific token ID and resource type
    /// @param tokenId The token ID
    /// @param resourceType The type of resource
    /// @return The resource balance
    function getResourceBalance(
        uint256 tokenId,
        uint256 resourceType
    ) external view returns (uint256);
}
