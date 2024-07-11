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

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {ERC404} from "./ERC404.sol";
import {ERC404UniswapV2Exempt} from "./extensions/ERC404UniswapV2Exempt.sol";
import {ERC404MerkleClaim} from "./extensions/ERC404MerkleClaim.sol";

import {LibPRNG} from "solady/src/utils/LibPRNG.sol";

import {IBrainWormsCombatSystem} from "./interfaces/IBrainWormsCombatSystem.sol";
import {IBrainWormsTokenURI} from "./interfaces/IBrainWormsTokenURI.sol";
import {IBrainWormsResourceHarvesting} from "./interfaces/IBrainWormsResourceHarvesting.sol";
///
/// @title	Brain Worms, part of the Brain Worms Simulation System.
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
contract BrainWorms is
    Ownable,
    ERC404,
    ERC404UniswapV2Exempt,
    ERC404MerkleClaim
{
    /// @dev HELIOS
    uint256 public HELIOS = 8135;

    /// @dev PRNG for generating random numbers, thanks Vectorized.eth
    using LibPRNG for *;

    /// @dev The Brain Worms Combat System interface
    ///      set during deployment and for upgrades to the system.
    IBrainWormsCombatSystem public brainWormsCombatSystem;
    /// @dev The Brain Worms Token URI interface
    ///      set during deployment and for upgrades to the system.
    IBrainWormsTokenURI public brainWormsTokenURI;
    /// @dev The Brain Worms Resource Harvesting contract
    ///      set during deployment and for upgrades to the system.
    IBrainWormsResourceHarvesting public resourceHarvesting;

    /// @notice Flag to enable/disable initial transfer limit to
    ///         reduce naive token sniping.
    bool public initialTransferLimitEnabled = true;
    /// @notice The initial maximum holding amount for a wallet during
    ///         transfer limit period.
    uint256 public initialMaxHoldingAmount;
    /// @notice Mapping to allow LPs to bypass the initial transfer limit
    mapping(address => bool) public transferLimitExempt;

    /// @notice Total number of fights that have occurred
    uint256 public fightCount;

    /// @notice Mapping of token properties for each Brain Worm
    /// @dev Properties are encoded into a uint256 to save gas
    ///        Name: Variable Type Max Value (Bits) Comment
    ///      - Stamina: 255 (8 bits)
    ///      - Strength: 255 (8 bits)
    ///      - Dexterity: 255 (8 bits)
    ///      - Wins: 65535 (16 bits)
    ///      - Losses: 65535 (16 bits)
    ///      - Generation: 65535 (16 bits) Counts how many
    ///        times the token has been rerolled or added and removed
    ///        from the burn pool.
    ///      - DNA: 9999999999 (34 bits) A compressed
    ///      representation of the token's traits.
    ///      - Stance: 1 (1 bit) Defensive or offensive stance
    ///      - PVP Points: 65535 (16 bits) PVP points as calculated by
    ///      the combat system and impact stat bonuses. They are used by
    ///      the TokenURI contract to assign PVP Titles.
    mapping(uint256 => uint256) private tokenProperties;

    /// Bit positions based on the size of each field
    uint256 private constant STAMINA_SHIFT = 0;
    uint256 private constant STRENGTH_SHIFT = 8;
    uint256 private constant DEXTERITY_SHIFT = 16;
    uint256 private constant WINS_SHIFT = 24;
    uint256 private constant LOSSES_SHIFT = 40;
    uint256 private constant GENERATION_SHIFT = 56;
    uint256 private constant DNA_SHIFT = 72;
    uint256 private constant STANCE_SHIFT = 106;
    uint256 private constant PVP_POINTS_SHIFT = 107;

    // Masks for extracting fields
    uint256 private constant STAMINA_MASK = 0xFF << STAMINA_SHIFT;
    uint256 private constant STRENGTH_MASK = 0xFF << STRENGTH_SHIFT;
    uint256 private constant DEXTERITY_MASK = 0xFF << DEXTERITY_SHIFT;
    uint256 private constant WINS_MASK = 0xFFFF << WINS_SHIFT;
    uint256 private constant LOSSES_MASK = 0xFFFF << LOSSES_SHIFT;
    uint256 private constant GENERATION_MASK = 0xFFFF << GENERATION_SHIFT;
    uint256 private constant DNA_MASK = ((1 << 34) - 1) << DNA_SHIFT;
    uint256 private constant STANCE_MASK = 1 << STANCE_SHIFT;
    uint256 private constant PVP_POINTS_MASK = 0xFFFF << PVP_POINTS_SHIFT;

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Constructor

    /// @notice Constructor for the BrainWorms contract
    /// @param name_ The name of the token
    /// @param symbol_ The symbol of the token
    /// @param decimals_ The number of decimals for the token
    /// @param initialSupply_ The initial supply of tokens
    /// @param initialOwner_ The initial owner of the contract
    /// @param initialMintRecipient_ The recipient of the initial token mint
    /// @param uniswapSwapRouter_ The address of the Uniswap V2 swap router
    /// @param initialMaxHoldingAmount_ The initial maximum holding amount during
    ///        the transfer limit period. This expects the amount to be in whole
    ///        units, not in the token's decimals. So, 10 for 10 tokens.
    constructor(
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        uint256 initialSupply_,
        address initialOwner_,
        address initialMintRecipient_,
        address uniswapSwapRouter_,
        uint256 initialMaxHoldingAmount_
    )
        ERC404(name_, symbol_, decimals_)
        Ownable(initialOwner_)
        ERC404UniswapV2Exempt(uniswapSwapRouter_)
    {
        // Set the initial max holding amount
        initialMaxHoldingAmount = initialMaxHoldingAmount_ * 10 ** decimals_;

        // Set the owner and the UniswapV2 pair as exempt from the transfer limit
        transferLimitExempt[initialMintRecipient_] = true;
        transferLimitExempt[ERC404UniswapV2Exempt.uniswapV2Pair] = true;

        // Don't mint ERC721s to the initial owner and LP to save gas
        _setERC721TransferExempt(initialMintRecipient_, true);
        _setERC721TransferExempt(ERC404UniswapV2Exempt.uniswapV2Pair, true);

        _mintERC20(initialMintRecipient_, initialSupply_ * units);
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // External Functions

    /// @notice Sets the fighting stance of a Brain Worm
    /// @param tokenId The ID of the Brain Worm
    /// @param isDefensiveStance True if defensive stance, false if offensive stance
    function setStance(uint256 tokenId, bool isDefensiveStance) external {
        // require the caller to be the owner of the token to prevent
        // other people from changing the stance of your worm.
        require(_msgSender() == ownerOf(tokenId), "Not the token owner");
        uint256 encoded = tokenProperties[tokenId];
        // Clear the stance bit and set it to the new value
        tokenProperties[tokenId] =
            (encoded & ~STANCE_MASK) |
            (uint256(isDefensiveStance ? 1 : 0) << STANCE_SHIFT);
    }

    /// @notice Sets the resource type to harvest for a Brain Worm
    /// @dev The Resource Harvesting contract handles safety checks
    ///      regarding validity of setting the resource type.
    /// @param tokenId The ID of the Brain Worm
    /// @param resourceType The type of resource to harvest,
    ///        as defined by the Resource Harvesting contract.
    function setResourceTypeToHarvest(
        uint256 tokenId,
        uint256 resourceType
    ) external {
        // require the caller to be the owner of the token to prevent
        // other people from changing the resource type of your worm.
        require(_msgSender() == ownerOf(tokenId), "Not the token owner");
        resourceHarvesting.setResourceTypeToHarvest(tokenId, resourceType);
    }

    /// @notice Harvests resources for a Brain Worm
    /// @dev The Resource Harvesting contract handles safety checks
    ///      regarding validity of harvesting operations.
    /// @param tokenId The ID of the Brain Worm
    function harvestResource(uint256 tokenId) external {
        // require the caller to be the owner of the token to prevent
        // other people from harvesting resources for your worm.
        require(_msgSender() == ownerOf(tokenId), "Not the token owner");
        resourceHarvesting.harvest(tokenId);
    }

    /// @notice Harvests resources for multiple Brain Worms
    /// @dev The Resource Harvesting contract handles safety checks
    ///      regarding validity of harvesting operations.
    /// @param tokenIds An array of Brain Worm IDs to harvest resources for
    function batchHarvest(uint256[] calldata tokenIds) external {
        for (uint256 i = 0; i < tokenIds.length; i++) {
            // require the caller to be the owner of the token to prevent
            // other people from harvesting resources for your worm.
            require(
                _msgSender() == ownerOf(tokenIds[i]),
                "Not the token owner"
            );
            resourceHarvesting.harvest(tokenIds[i]);
        }
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Public Functions

    /// @notice Retrieves the properties of a Brain Worm
    /// @dev This is for front end and external contracts, for internal use you
    ///      should decode the properties directly as needed.
    /// @param tokenId_ The ID of the Brain Worm
    /// @return stamina The stamina of the Brain Worm
    /// @return strength The strength of the Brain Worm
    /// @return dexterity The dexterity of the Brain Worm
    /// @return wins The number of wins of the Brain Worm
    /// @return losses The number of losses of the Brain Worm
    /// @return generation The generation of the Brain Worm
    /// @return DNA The DNA of the Brain Worm, a compressed representation of the traits
    /// @return isDefensiveStance If the Brain Worm is in defensive stance
    /// @return pvpPoints The PVP points of the Brain Worm
    function getProperties(
        uint256 tokenId_
    )
        public
        view
        returns (
            uint8 stamina,
            uint8 strength,
            uint8 dexterity,
            uint16 wins,
            uint16 losses,
            uint16 generation,
            uint256 DNA,
            bool isDefensiveStance,
            uint16 pvpPoints
        )
    {
        // Get the encoded properties
        uint256 encoded = tokenProperties[tokenId_];

        // Extract the properties from the encoded value using bit shifting
        stamina = uint8((encoded & STAMINA_MASK) >> STAMINA_SHIFT);
        strength = uint8((encoded & STRENGTH_MASK) >> STRENGTH_SHIFT);
        dexterity = uint8((encoded & DEXTERITY_MASK) >> DEXTERITY_SHIFT);
        wins = uint16((encoded & WINS_MASK) >> WINS_SHIFT);
        losses = uint16((encoded & LOSSES_MASK) >> LOSSES_SHIFT);
        generation = uint16((encoded & GENERATION_MASK) >> GENERATION_SHIFT);
        DNA = (encoded & DNA_MASK) >> DNA_SHIFT;
        isDefensiveStance = (encoded & STANCE_MASK) != 0;
        pvpPoints = uint16((encoded & PVP_POINTS_MASK) >> PVP_POINTS_SHIFT);
    }

    /// @notice Initiates a fight between two Brain Worms with updated stance
    /// @dev This prevents needing to update the stance in a separate transaction.
    ///      But at the time of deployment, the website generally handles the
    ///      stance updatee as a separate transaction for UX reasons. This is
    ///      included for completeness and for future use cases.
    /// @param p1_ The ID of the attacking Brain Worm
    /// @param p2_ The ID of the defending Brain Worm
    /// @param p1IsDefensiveStance_ Whether the attacking Brain Worm should change to
    ///        defensive stance
    /// @param attackType_ The type of attack
    function fightBrainWormsWithUpdatedStance(
        uint256 p1_,
        uint256 p2_,
        bool p1IsDefensiveStance_,
        bool attackType_
    ) public {
        // get the encoded properties
        uint256 encoded = tokenProperties[p1_];
        // clear the stance bit and set it to the new value
        tokenProperties[p1_] =
            (encoded & ~STANCE_MASK) |
            (uint256(p1IsDefensiveStance_ ? 1 : 0) << STANCE_SHIFT);
        // call the fight function
        fightBrainWorms(p1_, p2_, attackType_);
    }

    /// @notice Initiates a fight between two Brain Worms
    /// @param p1_ The ID of the attacking Brain Worm
    /// @param p2_ The ID of the defending Brain Worm
    /// @param attackType_ The type of attack
    function fightBrainWorms(
        uint256 p1_,
        uint256 p2_,
        bool attackType_
    ) public {
        // Require the caller owns the attacking token, no fighting with other
        // people's worms. I could require the caller doesn't own the victim but thats
        // easy to bypass with a second wallet. So if you really want to attack another
        // worm you own, you can, but it's discouraged.
        //
        // the combat system prevents attacking yourself as that's relevant to
        // both regular and guest mode battles
        require(
            _msgSender() == ownerOf(p1_),
            "Only the owner of the attacking token can initiate a fight"
        );
        // require the victim to exist, ERC404 throws a "NotFound" if its out of bounds
        require(ownerOf(p2_) != address(0), "The victim token does not exist");

        // Increment the global fight count
        fightCount += 1;

        // Track the outcome of the fight
        bool didAttackerWin;
        // PVP points for both players
        uint16[2] memory pvpPoints;
        // scope to avoid stack too deep error
        {
            // Call the combat system to determine the outcome of the fight.
            // This is ugly looking. But to quote Tupac, "Only God Can Judge Me"
            (didAttackerWin, pvpPoints) = brainWormsCombatSystem
                .fightBrainWorms(
                    fightCount,
                    p1_,
                    p2_,
                    [
                        uint8(
                            (tokenProperties[p1_] & STAMINA_MASK) >>
                                STAMINA_SHIFT
                        ),
                        uint8(
                            (tokenProperties[p1_] & STRENGTH_MASK) >>
                                STRENGTH_SHIFT
                        ),
                        uint8(
                            (tokenProperties[p1_] & DEXTERITY_MASK) >>
                                DEXTERITY_SHIFT
                        ),
                        (tokenProperties[p1_] & STANCE_MASK) != 0 ? 1 : 0
                    ],
                    [
                        uint8(
                            (tokenProperties[p2_] & STAMINA_MASK) >>
                                STAMINA_SHIFT
                        ),
                        uint8(
                            (tokenProperties[p2_] & STRENGTH_MASK) >>
                                STRENGTH_SHIFT
                        ),
                        uint8(
                            (tokenProperties[p2_] & DEXTERITY_MASK) >>
                                DEXTERITY_SHIFT
                        ),
                        (tokenProperties[p2_] & STANCE_MASK) != 0 ? 1 : 0
                    ],
                    uint16(
                        (tokenProperties[p1_] & PVP_POINTS_MASK) >>
                            PVP_POINTS_SHIFT
                    ),
                    uint16(
                        (tokenProperties[p2_] & PVP_POINTS_MASK) >>
                            PVP_POINTS_SHIFT
                    ),
                    attackType_
                );
        }

        // Decode the properties of both tokens
        uint256 p1Props = tokenProperties[p1_];
        uint256 p2Props = tokenProperties[p2_];

        // Extract wins and losses
        uint16 p1Wins = uint16((p1Props & WINS_MASK) >> WINS_SHIFT);
        uint16 p1Losses = uint16((p1Props & LOSSES_MASK) >> LOSSES_SHIFT);
        uint16 p2Wins = uint16((p2Props & WINS_MASK) >> WINS_SHIFT);
        uint16 p2Losses = uint16((p2Props & LOSSES_MASK) >> LOSSES_SHIFT);

        // Update wins and losses based on the outcome of the fight
        if (didAttackerWin) {
            p1Wins++;
            p2Losses++;
        } else {
            p2Wins++;
            p1Losses++;
        }

        // Re-encode and update the properties directly
        // Clear and update wins, losses, and PVP points in one operation
        tokenProperties[p1_] =
            (p1Props & ~(WINS_MASK | LOSSES_MASK | PVP_POINTS_MASK)) |
            (uint256(p1Wins) << WINS_SHIFT) |
            (uint256(p1Losses) << LOSSES_SHIFT) |
            (uint256(pvpPoints[0]) << PVP_POINTS_SHIFT);

        tokenProperties[p2_] =
            (p2Props & ~(WINS_MASK | LOSSES_MASK | PVP_POINTS_MASK)) |
            (uint256(p2Wins) << WINS_SHIFT) |
            (uint256(p2Losses) << LOSSES_SHIFT) |
            (uint256(pvpPoints[1]) << PVP_POINTS_SHIFT);
    }

    /// @notice Mints tokens to the caller if they are eligible for the airdrop
    ///         and have not already claimed it.
    /// @dev This is handled by the ERC404MerkleClaim contract
    /// @param proof_ The merkle proof for the airdrop claim
    /// @param value_ The amount of tokens to mint
    function airdropMint(
        bytes32[] memory proof_,
        uint256 value_
    ) public override whenAirdropIsOpen {
        _validateAndRecordAirdropClaim(proof_, msg.sender, value_);
        _mintERC20(msg.sender, value_);
    }

    /// @notice Retrieves the token URI for a given token ID
    /// @dev This is handled by the Brain Worms Token URI contract which hooks
    ///      into EthFS for the onchain JavaScript, and onchain SVG generation.
    /// @param id_ The ID of the token
    /// @return result The token URI

    function tokenURI(
        uint256 id_
    ) public view override returns (string memory result) {
        uint256 encoded = tokenProperties[id_];
        uint256 DNA = (encoded & DNA_MASK) >> DNA_SHIFT;
        uint16[7] memory lifeStats = [
            uint16((encoded & STAMINA_MASK) >> STAMINA_SHIFT),
            uint16((encoded & STRENGTH_MASK) >> STRENGTH_SHIFT),
            uint16((encoded & DEXTERITY_MASK) >> DEXTERITY_SHIFT),
            uint16((encoded & GENERATION_MASK) >> GENERATION_SHIFT),
            uint16((encoded & WINS_MASK) >> WINS_SHIFT),
            uint16((encoded & LOSSES_MASK) >> LOSSES_SHIFT),
            uint16((encoded & PVP_POINTS_MASK) >> PVP_POINTS_SHIFT)
        ];
        result = brainWormsTokenURI.tokenURI(id_, DNA, lifeStats);
        return result;
    }

    /// @notice Allows a public reroll of a Brain Worm's properties
    /// @param id_ The ID of the Brain Worm to reroll
    function publicRerollWorm(uint256 id_) public {
        // caller must own the token to prevent other people from
        // rerolling your worm
        require(_msgSender() == ownerOf(id_), "Not the token owner");
        // get the generation of the token
        uint16 generation = uint16(
            (tokenProperties[id_] & GENERATION_MASK) >> GENERATION_SHIFT
        );
        // must be below generation 10
        require(generation < 10, "Generation is too high");
        // delete the token's resources to prevent accumulation
        resourceHarvesting.deleteTokensEntireBalance(id_);
        rerollWorm(id_, generation);
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Internal Functions

    /// @notice Sets all properties for a token at once
    /// @dev This is used to set all properties at once to save gas during minting,
    ///      burning, and rerolling operations.
    /// @param tokenId_ The ID of the token
    /// @param stamina_ The stamina value
    /// @param strength_ The strength value
    /// @param dexterity_ The dexterity value
    /// @param wins_ The number of wins
    /// @param losses_ The number of losses
    /// @param generation_ The generation of the Brain Worm
    /// @param DNA_ The DNA value
    /// @param isDefensiveStance_ True if defensive stance, false if offensive stance
    /// @param pvpPoints_ The PVP points
    function setProperties(
        uint256 tokenId_,
        uint8 stamina_,
        uint8 strength_,
        uint8 dexterity_,
        uint16 wins_,
        uint16 losses_,
        uint16 generation_,
        uint256 DNA_,
        bool isDefensiveStance_,
        uint16 pvpPoints_
    ) internal {
        // Validate the properties, however min values are not checked
        // as they're set during minting and rerolling which have their own
        // validation.
        require(stamina_ <= 255, "Stamina exceeds maximum value");
        require(strength_ <= 10, "Strength exceeds maximum value");
        require(dexterity_ <= 10, "Dexterity exceeds maximum value");
        require(DNA_ <= 9999999999, "DNA exceeds maximum value");

        // Encode the properties into memory variables
        // this was done in three parts to avoid stack too deep errors
        uint256 encoded1 = (uint256(stamina_) << STAMINA_SHIFT) |
            (uint256(strength_) << STRENGTH_SHIFT) |
            (uint256(dexterity_) << DEXTERITY_SHIFT) |
            (uint256(wins_) << WINS_SHIFT);

        uint256 encoded2 = (uint256(losses_) << LOSSES_SHIFT) |
            (uint256(generation_) << GENERATION_SHIFT) |
            (DNA_ << DNA_SHIFT);

        uint256 encoded3 = (uint256(isDefensiveStance_ ? 1 : 0) <<
            STANCE_SHIFT) | (uint256(pvpPoints_) << PVP_POINTS_SHIFT);

        // Combine the encoded values and assign to tokenProperties
        tokenProperties[tokenId_] = encoded1 | encoded2 | encoded3;
    }

    /// @notice Checks if the recipient's balance after transfer exceeds
    ///         the maximum holding amount
    /// @param to_ The recipient's address
    /// @param amount_ The amount being transferred
    function _checkMaxHolding(address to_, uint256 amount_) internal view {
        // Check if the recipient is exempt from the transfer limit
        if (to_ != address(0) && !transferLimitExempt[to_]) {
            uint256 newBalance = balanceOf[to_] + amount_;
            require(
                newBalance <= initialMaxHoldingAmount,
                "Exceeds max holding amount"
            );
        }
    }

    /// @notice Handles the transfer of ERC20 Brain Worms
    /// @dev Overrides the parent function to enforce the initial transfer limit
    /// @param from_ The sender's address
    /// @param to_ The recipient's address
    /// @param value_ The amount to transfer
    function _transferERC20(
        address from_,
        address to_,
        uint256 value_
    ) internal virtual override {
        if (initialTransferLimitEnabled) {
            _checkMaxHolding(to_, value_);
        }
        super._transferERC20(from_, to_, value_);
    }

    /// @notice Handles the transfer of ERC721 Brain Worms
    /// @dev Overrides the parent function to adjust token properties specific to
    ///      the Brain Worms Simulation System.
    /// @param from_ The sender's address
    /// @param to_ The recipient's address
    /// @param id_ The token ID
    function _transferERC721(
        address from_,
        address to_,
        uint256 id_
    ) internal virtual override {
        // Call the parent function
        super._transferERC721(from_, to_, id_);
        // get the generation of the token
        uint16 generation = uint16(
            (tokenProperties[id_] & GENERATION_MASK) >> GENERATION_SHIFT
        );
        // Check if its coming from the zero address which means it's
        // either transferring from the contract's bank or minting a fresh token.
        //
        // These both check if the generation is below 10 so that the system doesn't
        // endlessly reroll tokens. The reroll system is intended to add variety and
        // dynamism to the system, not to be a way to infinitely try for a perfect worm.
        // This also creates some gas savings for highly traded worms that are getting
        // churned on Uniswap or other exchanges.
        if (from_ == address(0) && generation < 10) {
            // reroll the token with a new set of properties
            rerollWorm(id_, generation);
        } else if (to_ == address(0) && generation < 10) {
            // burn the token
            // set everything but the generation and Id to zero
            setProperties(id_, 0, 0, 0, 0, 0, generation, 0, true, 0);
            resourceHarvesting.deleteTokensEntireBalance(id_);
        }
    }

    /// @notice Rerolls the properties of a Brain Worm
    /// @param id_ The token ID
    /// @param generation The current generation of the Brain Worm
    function rerollWorm(uint256 id_, uint16 generation) internal {
        // Create a new PRNG instance
        LibPRNG.PRNG memory prng;
        // Seed the PRNG
        prng.seed(
            uint256(
                keccak256(
                    abi.encodePacked(
                        id_,
                        block.timestamp,
                        block.prevrandao,
                        msg.sender
                    )
                )
            )
        );
        // DNA is a compressed representation of the token's traits
        uint256 DNA = prng.next() % 10000000000;

        // Increment the generation of the token if there is one, or set it to 1
        generation = generation + 1;

        // Generate new stats for the token
        uint8 newStamina = uint8((prng.next() % 6) + 10);
        uint8 newStrength = uint8((prng.next() % 10) + 1);
        uint8 newDexterity = uint8((prng.next() % 10) + 1);

        // punish stats for being a higher generation
        if (generation > 1) {
            uint256 generationDegradationRoll = prng.next() % 100;

            if (generationDegradationRoll < 33) {
                // 33% chance for stamina reduction
                newStamina = newStamina > uint8(generation)
                    ? newStamina - uint8(generation)
                    : 1;
            } else if (generationDegradationRoll < 66) {
                // 33% chance for strength reduction
                newStrength = newStrength > uint8(generation)
                    ? newStrength - uint8(generation)
                    : 1;
            } else {
                // 34% chance for dexterity reduction
                newDexterity = newDexterity > uint8(generation)
                    ? newDexterity - uint8(generation)
                    : 1;
            }
        }

        // Set initial properties for the minted token
        // value for each stat, zero wins and losses
        // and defensive stance by default
        setProperties(
            id_,
            newStamina,
            newStrength,
            newDexterity,
            0,
            0,
            generation,
            DNA,
            true,
            0
        );
        // grant the token an initial balance of resources
        resourceHarvesting.increaseResourceBalance(
            id_,
            uint8(prng.next() % 3),
            prng.next() % resourceHarvesting.vampireMinVictimBalance()
        );
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Owner Only Functions

    /// @notice Sets the maximum holding amount for the initial transfer limit
    /// @param newMaxHoldingAmount The new maximum holding amount
    function ownerSetMaxHoldingAmount(
        uint256 newMaxHoldingAmount
    ) public onlyOwner {
        initialMaxHoldingAmount = newMaxHoldingAmount;
    }

    /// @notice Enables or disables the initial transfer limit
    /// @param value True to enable, false to disable
    function ownerSetInitialTransferLimitEnabled(bool value) public onlyOwner {
        initialTransferLimitEnabled = value;
    }

    /// @notice Adds or removes an address from the transfer limit exemption list
    /// @param account_ The address to update
    /// @param value_ True to exempt, false to remove exemption
    function ownerSetTransferLimitExempt(
        address account_,
        bool value_
    ) public onlyOwner {
        transferLimitExempt[account_] = value_;
    }

    /// @notice Updates the address of the Combat System contract
    /// @dev This is intended for upgrades to the system
    /// @param newAddress_ The new address of the Combat System contract
    function ownerUpdateCombatSystemAddress(
        address newAddress_
    ) public onlyOwner {
        brainWormsCombatSystem = IBrainWormsCombatSystem(newAddress_);
    }

    /// @notice Updates the address of the Token URI contract
    /// @dev This is intended for upgrades to the system
    /// @param newAddress_ The new address of the Token URI contract
    function ownerUpdateTokenURIAddress(address newAddress_) public onlyOwner {
        brainWormsTokenURI = IBrainWormsTokenURI(newAddress_);
    }

    /// @notice Updates the address of the Resource Harvesting contract
    /// @dev This is intended for upgrades to the system
    /// @param newAddress_ The new address of the Resource Harvesting contract
    function ownerUpdateResourceHarvestingAddress(
        address newAddress_
    ) public onlyOwner {
        resourceHarvesting = IBrainWormsResourceHarvesting(newAddress_);
    }

    /// @notice Changes the properties of a Brain Worm. This is intended
    ///         to be used rarely and only for special cases like game balancing.
    //          Or to fix significant bugs to prevent the need for a migration.
    /// @dev There are not many restrictions on min or max values for
    ///      the properties, besides Stam,Str,Dex,DNA, to allow for flexibility
    ///      in the future. So be cautious. A backup of all properties should be
    ///      taken before running this function.
    /// @param tokenId The ID of the Brain Worm
    /// @param stamina The new stamina value
    /// @param strength The new strength value
    /// @param dexterity The new dexterity value
    /// @param wins The new number of wins
    /// @param losses The new number of losses
    /// @param generation The new generation
    /// @param DNA The new DNA value
    /// @param isDefensiveStance True if defensive stance, false if offensive stance
    /// @param PVPPoints The new PVP points
    function ownerSetProperties(
        uint256 tokenId,
        uint8 stamina,
        uint8 strength,
        uint8 dexterity,
        uint16 wins,
        uint16 losses,
        uint16 generation,
        uint256 DNA,
        bool isDefensiveStance,
        uint16 PVPPoints
    ) public onlyOwner {
        setProperties(
            tokenId,
            stamina,
            strength,
            dexterity,
            wins,
            losses,
            generation,
            DNA,
            isDefensiveStance,
            PVPPoints
        );
    }

    /// @notice Sets the ERC721 transfer exempt status for an account
    /// @dev This saves gas not minting NFTs to LP's and other such cases
    /// @param account_ The address to update
    /// @param value_ True to set as exempt, false otherwise
    function setERC721TransferExempt(
        address account_,
        bool value_
    ) external onlyOwner {
        _setERC721TransferExempt(account_, value_);
    }

    /// @notice Sets the airdrop merkle root
    /// @param airdropMerkleRoot_ The new merkle root for the airdrop
    function setAirdropMerkleRoot(
        bytes32 airdropMerkleRoot_
    ) external onlyOwner {
        _setAirdropMerkleRoot(airdropMerkleRoot_);
    }

    /// @notice Toggles the airdrop open or closed
    function toggleAirdropIsOpen() external onlyOwner {
        _toggleAirdropIsOpen();
    }
}
