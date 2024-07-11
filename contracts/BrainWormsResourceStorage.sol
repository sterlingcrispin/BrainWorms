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
/// @title	Brain Worms Resource Storage,
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

contract BrainWormsResourceStorage is
    IBrainWormsResourceStorage,
    AccessControl
{
    /// @dev AEGIS
    uint256 public AEGIS = 1135;

    // Role is allowed to change the resource balances
    bytes32 public constant RESOURCE_MANAGER_ROLE =
        keccak256("RESOURCE_MANAGER_ROLE");

    // Nested mapping to store resource balances for each token ID and resource type.
    // TokenID -> Resource Type -> Balance
    mapping(uint256 => mapping(uint256 => uint256)) private _resourceBalances;

    // Total number of resource types
    uint256 private _resourceTypeCount;

    // Total resources per type
    mapping(uint256 => uint256) private _totalResourcesByType;

    // Highest seen value for a resource type
    // This is not the current max value, but the highest value seen so far
    mapping(uint256 => uint256) private _highestResourceValueSoFarByType;

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Constructor

    /// @notice Constructor for the Brain Worms Resource Storage contract
    /// @param initialResourceTypeCount The initial number of resource types
    constructor(uint256 initialResourceTypeCount) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _resourceTypeCount = initialResourceTypeCount;
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // External Functions only callable by the DEFAULT_ADMIN_ROLE

    /// @notice Set the number of valid resource types
    /// @dev this expands the number of resource types and
    ///      can be used to expand the system.
    /// @param count The new count of valid resource types
    function setResourceTypeCount(
        uint256 count
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _resourceTypeCount = count;
        // Emit an event for the new resource type count change
        emit ResourceTypeCountSet(count);
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // External Functions only callable by the RESOURCE_MANAGER_ROLE

    /// @notice Increase the resource balance for a specific token ID and resource type
    /// @param tokenId The token ID
    /// @param resourceType The type of resource
    /// @param amount The amount of the resource to increase
    function increaseBalance(
        uint256 tokenId,
        uint256 resourceType,
        uint256 amount
    ) external onlyRole(RESOURCE_MANAGER_ROLE) {
        // Make sure the resource type is valid
        require(resourceType < _resourceTypeCount, "Invalid resource type");

        _resourceBalances[tokenId][resourceType] += amount;
        _totalResourcesByType[resourceType] += amount;

        // set the highest value seen for this resource type if needed
        if (
            _resourceBalances[tokenId][resourceType] >
            _highestResourceValueSoFarByType[resourceType]
        ) {
            _highestResourceValueSoFarByType[resourceType] = _resourceBalances[
                tokenId
            ][resourceType];
        }

        // Emit an event for the increased balance
        emit ResourceBalanceIncreased(tokenId, resourceType, amount);
    }

    /// @notice Increase multiple resources for a specific token ID
    /// @param tokenId The token ID
    /// @param resourceAmounts The amounts of the resources to increase
    function increaseMultiBalance(
        uint256 tokenId,
        uint256[] calldata resourceAmounts
    ) external override onlyRole(RESOURCE_MANAGER_ROLE) {
        // Make sure the resource amounts are valid
        // for the number of resource types
        require(
            resourceAmounts.length == _resourceTypeCount,
            "Invalid resource amounts"
        );
        // go through each resource type and increase the balance
        for (uint256 i = 0; i < _resourceTypeCount; i++) {
            _resourceBalances[tokenId][i] += resourceAmounts[i];
            _totalResourcesByType[i] += resourceAmounts[i];

            // set the highest value seen for this resource type if needed
            if (
                _resourceBalances[tokenId][i] >
                _highestResourceValueSoFarByType[i]
            ) {
                _highestResourceValueSoFarByType[i] = _resourceBalances[
                    tokenId
                ][i];
            }
        }
        // Emit an event for the increased balance
        emit MultiResourceBalanceIncreased(tokenId, resourceAmounts);
    }

    /// @notice Decrease the resource balance for a specific token ID and resource type
    /// @param tokenId The token ID
    /// @param resourceType The type of resource
    /// @param amount The amount of the resource to decrease
    function decreaseBalance(
        uint256 tokenId,
        uint256 resourceType,
        uint256 amount
    ) external onlyRole(RESOURCE_MANAGER_ROLE) {
        // Make sure the resource type is valid
        require(resourceType < _resourceTypeCount, "Invalid resource type");

        // Make sure the token has enough resources to decrease
        require(
            _resourceBalances[tokenId][resourceType] >= amount,
            "Insufficient resource balance"
        );

        // Decrease the balance
        _resourceBalances[tokenId][resourceType] -= amount;
        _totalResourcesByType[resourceType] -= amount;

        // Emit an event for the decreased balance
        emit ResourceBalanceDecreased(tokenId, resourceType, amount);
    }

    /// @notice Decrease multiple resources for a specific token ID
    /// @param tokenId The token ID
    /// @param resourceAmounts The amounts of the resources to decrease
    function decreaseMultiBalance(
        uint256 tokenId,
        uint256[] calldata resourceAmounts
    ) external onlyRole(RESOURCE_MANAGER_ROLE) {
        // Make sure the resource amounts are valid
        require(
            resourceAmounts.length == _resourceTypeCount,
            "Invalid resource amounts"
        );

        // go through each resource type and decrease the balance
        for (uint256 i = 0; i < _resourceTypeCount; i++) {
            // Make sure the token has enough resources to decrease
            require(
                _resourceBalances[tokenId][i] >= resourceAmounts[i],
                "Insufficient resource balance"
            );
            _resourceBalances[tokenId][i] -= resourceAmounts[i];
            _totalResourcesByType[i] -= resourceAmounts[i];
        }

        // Emit an event for the decreased balance
        emit MultiResourceBalanceDecreased(tokenId, resourceAmounts);
    }

    /// @notice Delete all resources for a specific token ID
    /// @param tokenId The token ID
    function deleteTokensEntireBalance(
        uint256 tokenId
    ) external override onlyRole(RESOURCE_MANAGER_ROLE) {
        // Iterate over each resource type and delete the balance for the token
        for (uint256 i = 0; i < _resourceTypeCount; i++) {
            // track the total resources change
            _totalResourcesByType[i] -= _resourceBalances[tokenId][i];
            // get rekt bozo
            delete _resourceBalances[tokenId][i];
        }

        // Emit an event for the deleted balance
        emit TokensEntireBalanceDeleted(tokenId);
    }

    /// @notice Grant the RESOURCE_MANAGER_ROLE to an account
    /// @param account The account to grant the role to
    function grantResourceManagerRole(
        address account
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        grantRole(RESOURCE_MANAGER_ROLE, account);
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // External View Functions

    /// @notice Get the resource balance for a specific token ID and resource type
    /// @param tokenId The token ID
    /// @param resourceType The type of resource
    /// @return The balance of the resource for that token
    function getResourceBalance(
        uint256 tokenId,
        uint256 resourceType
    ) external view returns (uint256) {
        return _resourceBalances[tokenId][resourceType];
    }

    /// @notice Get the total resources for a specific resource type
    /// @param resourceType The type of resource
    /// @return The total resources of the type harvested by all tokens
    function getTotalResourcesByType(
        uint256 resourceType
    ) external view returns (uint256) {
        return _totalResourcesByType[resourceType];
    }

    /// @notice Get the total resources harvested by all tokens
    /// @return The total resources harvested by all tokens
    function getTotalResources() external view returns (uint256) {
        uint256 totalResources = 0;
        for (uint256 i = 0; i < _resourceTypeCount; i++) {
            totalResources += _totalResourcesByType[i];
        }
        return totalResources;
    }

    /// @notice Get the highest resource value so far for a specific resource type
    /// @param resourceType The type of resource
    /// @return The highest resource value so far for that type
    function getHighestResourceValueSoFarByType(
        uint256 resourceType
    ) external view returns (uint256) {
        return _highestResourceValueSoFarByType[resourceType];
    }

    /// @notice Get all the resource balances for a specific token ID
    /// @param tokenId The token ID
    /// @return The resource balances for that token
    function getMultiResourceBalance(
        uint256 tokenId
    ) external view override returns (uint256[] memory) {
        uint256[] memory resources = new uint256[](_resourceTypeCount);
        for (uint256 i = 0; i < _resourceTypeCount; i++) {
            resources[i] = _resourceBalances[tokenId][i];
        }
        return resources;
    }

    /// @notice Get the number of valid resource types
    /// @return The count of valid resource types
    function getResourceTypeCount() external view override returns (uint256) {
        return _resourceTypeCount;
    }
}
