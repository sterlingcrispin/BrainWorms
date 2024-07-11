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

import "@openzeppelin/contracts/access/AccessControl.sol";
import "./interfaces/IBrainWormsResourceStorage.sol";
///
/// @title	Brain Worms Resource Harvesting, part of the Brain Worms Simulation System.
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
contract BrainWormsResourceHarvesting is AccessControl {
    /// @dev ZEPHYR
    uint256 public ZEPHYR = 1135;

    // Role is allowed to perform resource harvesting and manipulation
    bytes32 public constant HARVESTER_ROLE = keccak256("HARVESTER_ROLE");

    /// @dev The Brain Worms Resource Storage contract
    ///      set during deployment and for upgrades to the system.
    IBrainWormsResourceStorage private immutable _resourceStorage;

    /// @notice The last block number at which a token ID harvested resources
    ///         TokenID -> Last Harvest Block
    mapping(uint256 => uint256) public lastHarvestBlock;

    /// @notice The resource type being harvested for a specific token ID.
    ///         Players can only harvest one resource type at a time.
    ///         TokenID -> Resource Type
    mapping(uint256 => uint256) public resourceTypeBeingHarvested;

    /// @notice Total number of players (token IDs) participating in resource harvesting
    /// @dev This starts at 1 to prevent division by zero at first
    uint256 public totalPlayers = 1;

    /// @notice The minimum value of total resources required to start diminishing returns
    ///         during resource harvesting.
    /// @dev This helps the system warm up and not punish everyone at 99%
    ///      while the average resource gets established.
    ///      This benefits the earliest players to a resource but
    ///      they will get diminishing returns as more players join.
    uint256 public minTotalResources = 50000;

    /// @notice The maximum ratio of resources to transfer from the victim to the attacker
    ///         in a vampiric attack.
    uint256 public vampireMaxTransferPercent = 2;

    /// @notice The number of blocks to wait before a token ID can perform another vampire attack
    ///         This is to prevent spamming of vampire attacks.
    uint256 public vampireBlockCooldown = 267;

    /// @notice The minimum balance a victim must have to be attacked
    uint256 public vampireMinVictimBalance = 1000;

    /// @notice The last block number at which a token ID performed a vampire attack
    ///         TokenID -> Last Vampire Block
    mapping(uint256 => uint256) public lastVampireBlock;

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

    /// @notice Emitted when a vampiric transfer occurs
    /// @param tokenIdAttacker The ID of the attacking token
    /// @param tokenIdVictim The ID of the victim token
    /// @param resourceType The type of resource transferred
    /// @param amount The amount of resources transferred
    event VampireTransfer(
        uint256 indexed tokenIdAttacker,
        uint256 indexed tokenIdVictim,
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
    // Constructor

    constructor(address resourceStorageAddress) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);

        _resourceStorage = IBrainWormsResourceStorage(resourceStorageAddress);
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // External Functions

    /// @notice Checks if an address has the HARVESTER_ROLE
    /// @param account The address to check
    /// @return bool True if the account has the HARVESTER_ROLE, false otherwise
    function isHarvester(address account) external view returns (bool) {
        return hasRole(HARVESTER_ROLE, account);
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // External Functions only callable by the HARVESTER_ROLE

    /// @notice Sets the resource type to harvest for a specific token ID.abi
    ///         This also begins the harvesting process for that resource type.
    /// @param tokenId The ID of the token to set the resource type for
    /// @param resourceType The type of resource to harvest
    function setResourceTypeToHarvest(
        uint256 tokenId,
        uint256 resourceType
    ) external onlyRole(HARVESTER_ROLE) {
        // Prevent setting a resource type that doesn't exist.
        require(
            resourceType < _resourceStorage.getResourceTypeCount(),
            "Invalid resource type"
        );

        resourceTypeBeingHarvested[tokenId] = resourceType;

        // Increment the total number of players if the token ID is
        // harvesting for the first time.
        if (lastHarvestBlock[tokenId] == 0) {
            totalPlayers += 1;
        }
        // Update the last harvest block for the token ID.
        // Either the player has begun harvesting for the first time or
        // has switched resource types. And players are only allowed to
        // harvest one resource type at a time.
        lastHarvestBlock[tokenId] = block.number;

        // Emit an event indicating the resource type has been set
        emit ResourceTypeToHarvestSet(tokenId, resourceType);
    }

    /// @notice Performs a batch harvest for multiple token IDs
    /// @param tokenIds An array of token IDs to harvest for
    function batchHarvest(
        uint256[] calldata tokenIds
    ) external onlyRole(HARVESTER_ROLE) {
        // Iterate over each token ID and perform the harvest
        for (uint256 i = 0; i < tokenIds.length; i++) {
            harvest(tokenIds[i]);
        }
    }

    /// @notice Transfer resources between two token IDs
    /// @dev The core contract doesn't call this function, it's included for
    ///      completeness and potential future use.
    /// @param fromTokenId The ID of the token transferring resources
    /// @param toTokenId The ID of the token receiving resources
    /// @param resourceType The type of resource to transfer
    /// @param amount The amount of resources to transfer
    function transfer(
        uint256 fromTokenId,
        uint256 toTokenId,
        uint256 resourceType,
        uint256 amount
    ) external onlyRole(HARVESTER_ROLE) {
        // Prevent setting a resource type that doesn't exist.
        require(
            resourceType < _resourceStorage.getResourceTypeCount(),
            "Invalid resource type"
        );

        // Sender needs to have enough resources to transfer
        require(
            _resourceStorage.getResourceBalance(fromTokenId, resourceType) >=
                amount,
            "Insufficient balance"
        );
        // Alter the balances in the BrainWormsResourceStorage contract
        _resourceStorage.decreaseBalance(fromTokenId, resourceType, amount);

        _resourceStorage.increaseBalance(toTokenId, resourceType, amount);

        // Emit an event indicating resources have been transferred
        emit ResourceTransferred(fromTokenId, toTokenId, resourceType, amount);
    }

    /// @notice Increase the resource balance for a specific token ID
    /// @dev The core contract calls this during minting to initialize the resource balances
    ///      for new token IDs. It could be used for other purposes as well in the future.
    /// @param tokenId The ID of the token to increase the balance for
    /// @param resourceType The type of resource to increase the balance for
    /// @param amount The amount of resources to increase the balance by
    function increaseResourceBalance(
        uint256 tokenId,
        uint256 resourceType,
        uint256 amount
    ) external onlyRole(HARVESTER_ROLE) {
        // You cant transfer resources that dont or shouldn't exist
        require(
            resourceType < _resourceStorage.getResourceTypeCount(),
            "Invalid resource type"
        );
        // Alter the balance in the BrainWormsResourceStorage contract
        _resourceStorage.increaseBalance(tokenId, resourceType, amount);
    }

    /// @notice Delete the entire resource balance for a specific token ID
    /// @dev The core contract calls this when a token ID is burned to remove all
    ///      resources associated with the token ID.
    /// @param tokenId The ID of the token to delete the balance for
    function deleteTokensEntireBalance(
        uint256 tokenId
    ) external onlyRole(HARVESTER_ROLE) {
        // Get the resource balances for the token ID
        uint256[] memory resources = _resourceStorage.getMultiResourceBalance(
            tokenId
        );

        // Delete the resources for the token ID in the BrainWormsResourceStorage contract
        _resourceStorage.deleteTokensEntireBalance(tokenId);

        // Decrement the total number of players if they were harvesting
        if (lastHarvestBlock[tokenId] > 0) {
            totalPlayers--;
        }

        // Reset the last harvest block for the token ID
        delete lastHarvestBlock[tokenId];

        // Reset the resource type for the token ID
        delete resourceTypeBeingHarvested[tokenId];

        // Emit an event indicating the entire balance has been deleted
        emit TokensEntireBalanceDeleted(tokenId, resources);
    }

    /// @notice Performs a vampiric harvest, transferring resources from one player to another
    ///         based on the attacker's rank such that higher ranked players receive
    ///         less resources
    /// @param tokenIdAttacker The ID of the attacking token
    /// @param tokenIdVictim The ID of the victim token
    /// @return uint256 The amount of resources transferred
    function vampireHarvest(
        uint256 tokenIdAttacker,
        uint256 tokenIdVictim
    ) external onlyRole(HARVESTER_ROLE) returns (uint256) {
        // Check that both the attacker and the victim haven't been involved in
        // a vampire attack recently. Just return if they have, I don't want to
        // revert here because fights should continue as normal if drain isn't possible
        if (
            lastVampireBlock[tokenIdAttacker] + vampireBlockCooldown >
            block.number &&
            lastVampireBlock[tokenIdVictim] + vampireBlockCooldown >
            block.number
        ) {
            return 0;
        }
        // Whichever resource type the attacker is harvesting is what they'll take
        uint256 resourceType = resourceTypeBeingHarvested[tokenIdAttacker];

        // The transfer amount is capped at the vampire ratio of the victim's resource balance
        uint256 victimResourceBalance = _resourceStorage.getResourceBalance(
            tokenIdVictim,
            resourceType
        );
        // prevent attacking players with low balances or draining them to zero
        if (victimResourceBalance < vampireMinVictimBalance) {
            return 0;
        }
        uint256 transferAmountMax = (victimResourceBalance *
            vampireMaxTransferPercent) / 100;

        // Calculate the transfer amount based on the attackers rank
        uint256 transferAmount = calculateHarvest(
            tokenIdAttacker,
            transferAmountMax
        );

        // don't attempt to transfer zero resources
        // and don't update the last vampire block
        if (transferAmount == 0) {
            return 0;
        }

        // Transfer the resources from the victim to the attacker
        _resourceStorage.decreaseBalance(
            tokenIdVictim,
            resourceType,
            transferAmount
        );
        _resourceStorage.increaseBalance(
            tokenIdAttacker,
            resourceType,
            transferAmount
        );

        // Update the last vampire block for the attacker and the victim
        lastVampireBlock[tokenIdAttacker] = block.number;
        lastVampireBlock[tokenIdVictim] = block.number;

        return transferAmount;
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Public Functions only callable by the Harvester Role

    /// @notice Performs a harvest for a specific token ID
    /// @param tokenId The ID of the token to harvest for
    function harvest(uint256 tokenId) public onlyRole(HARVESTER_ROLE) {
        // token must have begun harvesting
        require(lastHarvestBlock[tokenId] > 0, "Resource type not set");
        // prevent harvesting in the same block
        require(
            block.number > lastHarvestBlock[tokenId],
            "Can't harvest in same block"
        );
        // Blocks elapsed since the last harvest
        uint256 blocksPassed = block.number - lastHarvestBlock[tokenId];

        // Get the resource type being harvested for the token ID
        uint256 resourceType = resourceTypeBeingHarvested[tokenId];

        // Harvest amount for the token ID considering the player's ranking
        uint256 harvestAmount = calculateHarvest(tokenId, blocksPassed);

        // Add the harvested resources to the token ID's balance in
        // the BrainWormsResourceStorage contract
        _resourceStorage.increaseBalance(tokenId, resourceType, harvestAmount);

        // Update the last harvest block for the token ID
        lastHarvestBlock[tokenId] = block.number;

        // Emit an event indicating resources have been harvested for the token ID
        emit ResourceHarvested(tokenId, resourceType, harvestAmount);
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Public Functions

    /// @notice Calculate the player's ranking based on their resource balance
    ///         for a specific resource type relative to the average resource balance
    ///         of all players. An additional resource value can be added to the player's
    ///         rank check because the player may be attempting to harvest resources which
    ///         would affect their ranking.
    /// @param tokenId The ID of the token to calculate the ranking for
    /// @param additionalResourceValue The amount of resources to add to the player's balance
    /// @return uint256 The player's ranking
    function getPlayerRanking(
        uint256 tokenId,
        uint256 additionalResourceValue
    ) public view returns (uint256) {
        // Resource type being harvested for the token ID
        uint256 resourceType = resourceTypeBeingHarvested[tokenId];

        // players current balance plus how much they're attempting to harvest
        uint256 playerResourceBalance = _resourceStorage.getResourceBalance(
            tokenId,
            resourceType
        ) + additionalResourceValue;

        // total resources of all players by type
        uint256 totalResourceBalance = _resourceStorage.getTotalResourcesByType(
            resourceType
        );
        // If not many resources have been harvested yet, return 1 rank to give
        // the max amount to the first players and get the system started
        if (totalResourceBalance < minTotalResources) {
            return 1;
        }

        // Calulate the rank based on the player's resource and average resource balance
        // I'm not checking for zero totalPlayers because its initialized to 1
        uint256 averageResourceBalance = totalResourceBalance / totalPlayers;
        uint256 rank = (playerResourceBalance * 100) /
            (averageResourceBalance +
                _resourceStorage.getHighestResourceValueSoFarByType(
                    resourceType
                ));

        // Clamp the rank between 1 and 99
        rank = rank > 99 ? 99 : rank;
        rank = rank < 1 ? 1 : rank;
        return rank;
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Private View Functions

    /// @notice Calculate the amount of resources to harvest for a specific token ID
    ///         based on the player's rank ranking relative to the average resource balance.
    /// @param tokenId The ID of the token to calculate the harvest amount for
    /// @param resourceAmountToHarvest The amount of resources to harvest
    /// @return uint256 The adjusted amount to harvest
    function calculateHarvest(
        uint256 tokenId,
        uint256 resourceAmountToHarvest
    ) private view returns (uint256) {
        // reduce the harvest amount based on the player's rank ranking
        // such that higher ranked players receive less resources
        uint256 playerRank = getPlayerRanking(tokenId, resourceAmountToHarvest);

        uint256 diminishingFactor = 100 - playerRank;
        // don't let diminishing factor go below 20%
        // otherwise the highest ranking players get too little
        diminishingFactor = diminishingFactor < 20 ? 20 : diminishingFactor;

        // calculate the adjusted amount to harvest
        uint256 adjustedAmount = (resourceAmountToHarvest * diminishingFactor) /
            100;
        return adjustedAmount;
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Admin Only Functions

    /// @notice Grants the harvester role to an address so it can perform resource harvesting
    /// @param harvesterAddress The address to grant the harvester role to
    function grantHarvesterRole(
        address harvesterAddress
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        grantRole(HARVESTER_ROLE, harvesterAddress);
    }

    /// @notice Revokes the harvester role from an address so it can no longer
    ///         perform resource harvesting
    /// @param harvesterAddress The address to revoke the harvester role from
    function revokeHarvesterRole(
        address harvesterAddress
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        revokeRole(HARVESTER_ROLE, harvesterAddress);
    }

    /// @notice Sets the minimum total resources required to start diminishing returns
    ///         during resource harvesting
    /// @param minTotalResources_ The new minimum total resources value
    function setMinTotalResources(
        uint256 minTotalResources_
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        minTotalResources = minTotalResources_;
    }

    /// @notice Sets the maximum ratio of resources to transfer from the victim
    ///         to the attacker in a vampiric attack
    /// @dev The value is a percentage, so 2 would be 2%
    /// @param vampireRatio_ The new max transfer percent
    function setVampireMaxTransferPercent(
        uint256 vampireRatio_
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        vampireMaxTransferPercent = vampireRatio_;

        // Emit an event indicating the vampire max transfer percent has been set
        emit VampireMaxTransferPercentSet(vampireRatio_);
    }

    /// @notice Sets the minimum balance a victim must have to be attacked
    /// @param vampireMinVictimBalance_ The new minimum victim balance
    function setVampireMinVictimBalance(
        uint256 vampireMinVictimBalance_
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        // if its less than 100 the percentage calculation will return zero
        require(
            vampireMinVictimBalance_ > 100,
            "Vampire min victim balance must be greater than 100"
        );
        vampireMinVictimBalance = vampireMinVictimBalance_;

        // Emit an event indicating the vampire min victim balance has been set
        emit VampireMinVictimBalanceSet(vampireMinVictimBalance_);
    }

    /// @notice Sets the number of blocks to wait before a token ID can perform another
    ///         vampire attack
    /// @param cooldown The new cooldown value
    function setVampireBlockCooldown(
        uint256 cooldown
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        vampireBlockCooldown = cooldown;

        // Emit an event indicating the vampire block cooldown has been set
        emit VampireBlockCooldownSet(cooldown);
    }
}
