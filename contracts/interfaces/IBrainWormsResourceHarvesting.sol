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
/// @title  Brain Worms Resource Harvesting Interface,
///         part of the Brain Worms Simulation System.
///
/// @author Sterling Crispin,
///     @ sterlingcrispin
///     Del Complex, Brain Worm Research Program
///     http://www.delcomplex.com
///     @ delcomplex
///
/// @notice Our long term goal is to genetically engineer parasitic
///     worms to secrete cognitive enhancing biomolecules. Thus
///     increasing the intelligence of the host human. With
///     Brain Worms, we will accelerate the human species in
///     order to compete with AGI.
///
///     The Brain Worm implantation process begins at the nose.
///     We inject them via intranasal delivery to bypass the
///     blood-brain barrier and enable direct access to the brain.
///     Once inside, they compete for limited resources found in
///     the interstitial fluid of the brain such as glucose,
///     amino acids, and micronutrients. Thus, the Brain Worm
///     Simulation is a critical step in understanding the
///     behavior of the worms in a hostile environment.
///
///     As users interact with the Brain Worm Simulation, engage
///     with PVP combat, and gather resources, our scientists
///     will learn from the data and improve our biological
///     Brain Worms.
///
///     Del Complex produces tangible, digital, intangible,
///     rhizomatic, and hyperstitional products. Details
///     provided may relate to hyperstitional elements.
///
interface IBrainWormsResourceHarvesting {
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Events

    /// @notice Emitted when resources are harvested for a token
    /// @param tokenId The ID of the token that harvested resources
    /// @param resourceType The type of resource harvested
    /// @param resourceAmount The amount of resources harvested
    event ResourceHarvested(
        uint256 indexed tokenId,
        uint256 resourceType,
        uint256 resourceAmount
    );

    /// @notice Emitted when a token's resource type to harvest is set
    /// @param tokenId The ID of the token
    /// @param resourceType The type of resource set to harvest
    event ResourceTypeToHarvestSet(
        uint256 indexed tokenId,
        uint256 resourceType
    );

    /// @notice Emitted when resources are transferred between tokens
    /// @param fromTokenId The ID of the token transferring resources
    /// @param toTokenId The ID of the token receiving resources
    /// @param resourceType The type of resource transferred
    /// @param amount The amount of resources transferred
    event ResourceTransferred(
        uint256 indexed fromTokenId,
        uint256 indexed toTokenId,
        uint256 resourceType,
        uint256 amount
    );

    /// @notice Emitted when a token's entire balance is deleted
    /// @param tokenId The ID of the token whose balance was deleted
    /// @param resourceAmount An array of the deleted resource amounts
    event TokensEntireBalanceDeleted(
        uint256 indexed tokenId,
        uint256[] resourceAmount
    );

    /// @notice Emitted when the vampire block cooldown is set
    /// @param cooldown The new cooldown value
    event VampireBlockCooldownSet(uint256 cooldown);

    /// @notice Emitted when the vampire max transfer percent is set
    /// @param percent The new max transfer percent
    event VampireMaxTransferPercentSet(uint256 percent);

    /// @notice Emitted when the vampire minimum victim balance is set
    /// @param balance The new minimum victim balance
    event VampireMinVictimBalanceSet(uint256 balance);

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // External Functions

    /// @notice Sets the resource type to harvest for a specific token ID
    /// @param tokenId The ID of the token to set the resource type for
    /// @param resourceType The type of resource to harvest
    function setResourceTypeToHarvest(
        uint256 tokenId,
        uint256 resourceType
    ) external;

    /// @notice Performs a batch harvest for multiple token IDs
    /// @param tokenIds An array of token IDs to harvest for
    function batchHarvest(uint256[] calldata tokenIds) external;

    /// @notice Performs a harvest for a specific token ID
    /// @param tokenId The ID of the token to harvest for
    function harvest(uint256 tokenId) external;

    /// @notice Performs a vampiric harvest, transferring resources from one player to another
    /// @param tokenIdAttacker The ID of the attacking token
    /// @param tokenIdVictim The ID of the victim token
    /// @return resourceAmountTransferred The amount of resources transferred
    function vampireHarvest(
        uint256 tokenIdAttacker,
        uint256 tokenIdVictim
    ) external returns (uint256 resourceAmountTransferred);

    /// @notice Transfer resources between two token IDs
    /// @param fromTokenId The ID of the token transferring resources
    /// @param toTokenId The ID of the token receiving resources
    /// @param resourceType The type of resource to transfer
    /// @param amount The amount of resources to transfer
    function transfer(
        uint256 fromTokenId,
        uint256 toTokenId,
        uint256 resourceType,
        uint256 amount
    ) external;

    /// @notice Increase the resource balance for a specific token ID
    /// @param tokenId The ID of the token to increase the balance for
    /// @param resourceType The type of resource to increase the balance for
    /// @param amount The amount of resources to increase the balance by
    function increaseResourceBalance(
        uint256 tokenId,
        uint256 resourceType,
        uint256 amount
    ) external;

    /// @notice Delete the entire resource balance for a specific token ID
    /// @param tokenId The ID of the token to delete the balance for
    function deleteTokensEntireBalance(uint256 tokenId) external;

    /// @notice Grants the harvester role to an address
    /// @param harvesterAddress The address to grant the harvester role to
    function grantHarvesterRole(address harvesterAddress) external;

    /// @notice Revokes the harvester role from an address
    /// @param harvesterAddress The address to revoke the harvester role from
    function revokeHarvesterRole(address harvesterAddress) external;

    /// @notice Sets the minimum total resources required to start diminishing returns
    /// @param minTotalResources_ The new minimum total resources value
    function setMinTotalResources(uint256 minTotalResources_) external;

    /// @notice Sets the maximum ratio of resources to transfer from the victim to the attacker
    /// @param vampireRatio_ The new max transfer percent
    function setVampireMaxTransferPercent(uint256 vampireRatio_) external;

    /// @notice Sets the minimum balance a victim must have to be attacked
    /// @param vampireMinVictimBalance_ The new minimum victim balance
    function setVampireMinVictimBalance(
        uint256 vampireMinVictimBalance_
    ) external;

    /// @notice Sets the number of blocks to wait before a token ID can perform another vampire attack
    /// @param cooldown The new cooldown value
    function setVampireBlockCooldown(uint256 cooldown) external;

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // External View Functions

    /// @notice Calculate the player's ranking based on their resource balance
    /// @param tokenId The ID of the token to calculate the ranking for
    /// @param additionalResourceValue The amount of resources to add to the player's balance
    /// @return uint256 The player's ranking
    function getPlayerRanking(
        uint256 tokenId,
        uint256 additionalResourceValue
    ) external view returns (uint256);

    /// @notice The role allowed to perform resource harvesting and manipulation
    function HARVESTER_ROLE() external view returns (bytes32);

    /// @notice Checks if an address has the HARVESTER_ROLE
    /// @param account The address to check
    /// @return bool True if the account has the HARVESTER_ROLE, false otherwise
    function isHarvester(address account) external view returns (bool);

    /// @notice The last block number at which a token ID harvested resources
    function lastHarvestBlock(uint256 tokenId) external view returns (uint256);

    /// @notice The resource type being harvested for a specific token ID
    function resourceTypeBeingHarvested(
        uint256 tokenId
    ) external view returns (uint256);

    /// @notice Total number of players participating in resource harvesting
    function totalPlayers() external view returns (uint256);

    /// @notice The minimum value of total resources required to start diminishing returns
    function minTotalResources() external view returns (uint256);

    /// @notice The maximum ratio of resources to transfer from the victim to the attacker
    function vampireMaxTransferPercent() external view returns (uint256);

    /// @notice The number of blocks to wait before a token ID can perform another vampire attack
    function vampireBlockCooldown() external view returns (uint256);

    /// @notice The minimum balance a victim must have to be attacked
    function vampireMinVictimBalance() external view returns (uint256);

    /// @notice The last block number at which a token ID performed a vampire attack
    function lastVampireBlock(uint256 tokenId) external view returns (uint256);
}
