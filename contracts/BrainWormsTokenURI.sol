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

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {LibString} from "solady/src/utils/LibString.sol";
import {EncodeURI} from "./EncodeURI.sol";
import {IScriptyBuilderV2, HTMLRequest, HTMLTagType, HTMLTag} from "./lib/scripty/interfaces/IScriptyBuilderV2.sol";
import {IBrainWormsThumbnailGenerator} from "./interfaces/IBrainWormsThumbnailGenerator.sol";

///
/// @title	Brain Worms Token URI, part of the Brain Worms Simulation System.
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
contract BrainWormsTokenURI is Ownable {
    /// @dev OMEGA
    uint256 public OMEGA = 4825;

    // ERC404's offset the tokenID by a massive value to avoid collisions
    uint256 public constant ID_ENCODING_PREFIX = 1 << 255;

    address public immutable scriptyBuilderAddress =
        0xD7587F110E08F4D120A231bA97d3B577A81Df022;
    address public immutable ethfsFileStorageAddress =
        0x8FAA1AAb9DA8c75917C43Fb24fDdb513edDC3245;

    // The SVG thumbnail generator contract
    address public thumbnailGeneratorAddress;

    // PvP rank titles from lowest to highest
    string[11] public pvpRankTitles = [
        "Prey",
        "Hatchling",
        "Harvester",
        "Infiltrator",
        "Manipulator",
        "Sentinel",
        "Marauder",
        "Predator",
        "Master Parasite",
        "Champion Parasite",
        "Apex Parasite"
    ];

    // The Generative art JavaScript content
    bytes public base64ScriptContent;

    // Encodes plain text as a URI-encoded string
    EncodeURI public encodeURIContract;

    // Decodes traits from the Brain Worm DNA
    // 3 bits per trait: Up to 11 traits (since 3*11 = 33, leaving 1 bit unused).
    uint constant DNA_BITS_USED_FOR_TRAIT = 3;
    // Total DNA bits
    uint constant TOTAL_BITS = 34;

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Constructor

    constructor(address initialOwner_) Ownable(initialOwner_) {
        encodeURIContract = new EncodeURI();
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Public Functions

    /// @notice Calculate if a trait is present based on DNA and probability
    /// @param dna The DNA of the Brain Worm
    /// @param probability The probability of the trait being present ie 10 for 10%
    /// @param traitPosition The position of the trait in the DNA from (0 to (TOTAL_BITS/DNA_BITS_USED_FOR_TRAIT)-1)
    function isTraitPresent(
        uint dna,
        uint probability,
        uint traitPosition
    ) public pure returns (bool) {
        // Maximum value for the bits used for the trait
        uint maxValueForTrait = (1 << DNA_BITS_USED_FOR_TRAIT) - 1;
        // Extract the trait value from the DNA
        uint traitValue = (dna >> (traitPosition * DNA_BITS_USED_FOR_TRAIT)) &
            maxValueForTrait;

        // Convert probability to threshold value
        uint threshold = (maxValueForTrait * probability) / 100;

        return traitValue <= threshold;
    }

    /// @notice Build the PvP attribute for the Brain Worm
    /// @param PVPPoints_ The PvP points of the Brain Worm
    function buildPvpAttribute(
        uint16 PVPPoints_
    ) internal view returns (string memory) {
        uint rank = 0;

        if (PVPPoints_ >= 2400) {
            rank = 10;
        } else if (PVPPoints_ >= 2000) {
            rank = 9;
        } else if (PVPPoints_ >= 1600) {
            rank = 8;
        } else if (PVPPoints_ >= 1200) {
            rank = 7;
        } else if (PVPPoints_ >= 900) {
            rank = 6;
        } else if (PVPPoints_ >= 700) {
            rank = 5;
        } else if (PVPPoints_ >= 500) {
            rank = 4;
        } else if (PVPPoints_ >= 300) {
            rank = 3;
        } else if (PVPPoints_ >= 200) {
            rank = 2;
        } else if (PVPPoints_ >= 100) {
            rank = 1;
        }

        return
            string(
                abi.encodePacked(
                    '{ "trait_type": "PvP Title", "value": "',
                    pvpRankTitles[rank],
                    '" },'
                )
            );
    }

    /// @notice Build the JSON attribute blob for the Brain Worm
    /// @param DNA_ The DNA of the Brain Worm
    /// @param stats_ The stats of the Brain Worm
    function buildAttributes(
        uint256 DNA_,
        uint16[7] memory stats_
    ) internal view returns (string memory) {
        string[14] memory traits;
        string[14] memory traitTypes = [
            "Stamina",
            "Strength",
            "Dexterity",
            "Eyes",
            "Mouth",
            "Leg",
            "Proboscis",
            "Body",
            "Body Bumps",
            "Body Spikes",
            "Body Rings",
            "Generation",
            "Wins",
            "Losses"
        ];

        // Some traits are driven by stats if they are very high or low
        // Stamina
        traits[0] = LibString.toString(stats_[0]);
        // Strength
        traits[1] = LibString.toString(stats_[1]);
        // Dexterity
        traits[2] = LibString.toString(stats_[2]);

        // Eyes
        traits[3] = isTraitPresent(DNA_, 30, 0) ? "Stems" : "Spider";
        if (isTraitPresent(DNA_, 30, 1)) {
            traits[3] = "Huge";
        }

        // Mouth
        if (stats_[1] >= 9) {
            traits[4] = "Fangs";
        } else if (stats_[1] <= 2) {
            traits[4] = "Missing";
        } else {
            traits[4] = isTraitPresent(DNA_, 50, 2) ? "Worm" : "Mandibles";
        }

        // Leg
        if (stats_[2] >= 9) {
            traits[5] = "Agile";
        } else if (stats_[2] <= 2) {
            traits[5] = "Missing";
        } else {
            traits[5] = isTraitPresent(DNA_, 30, 3) ? "Thorny" : "Squiggly";
        }

        // Proboscis
        traits[6] = isTraitPresent(DNA_, 50, 4) ? "Prehensile" : "Absent";

        // Body
        traits[8] = "Smooth";
        traits[9] = "Soft";
        traits[10] = "Plain";

        // Body variations
        if (stats_[0] >= 14) {
            traits[7] = "Hefty";
        } else if (stats_[0] <= 11) {
            traits[7] = "Fragile";
        } else {
            if (isTraitPresent(DNA_, 80, 5)) {
                traits[7] = "Transparent";
                traits[8] = isTraitPresent(DNA_, 50, 6) ? "Bumpy" : traits[8];
                traits[9] = isTraitPresent(DNA_, 50, 7) ? "Spiky" : traits[9];
                traits[10] = isTraitPresent(DNA_, 50, 8)
                    ? "Ringed"
                    : traits[10];
            } else {
                traits[7] = "Solid";
            }
        }

        // Generation
        traits[11] = LibString.toString(stats_[3]);
        // Wins
        traits[12] = LibString.toString(stats_[4]);
        // Losses
        traits[13] = LibString.toString(stats_[5]);

        // Start of the JSON string
        string memory attributesJson = '"attributes": [';

        // build each JSON object
        for (uint i = 0; i < traits.length; i++) {
            // Build the trait JSON string
            string memory traitJson = LibString.concat(
                '{ "trait_type": "',
                traitTypes[i]
            );
            traitJson = LibString.concat(traitJson, '", "value": "');
            traitJson = LibString.concat(traitJson, traits[i]);
            traitJson = LibString.concat(traitJson, '" },');

            // Concatenate the current trait JSON to the attributes JSON
            attributesJson = LibString.concat(attributesJson, traitJson);
        }

        return LibString.concat(attributesJson, buildPvpAttribute(stats_[3]));
    }

    /// @notice Generate the token URI for the Brain Worm
    /// @dev This is called by the ERC721 part of the Brain Worms contract
    ///      and calculates all of the attributes, the HTML for the generative
    ///      art, and calls an external contract to generate the
    //       thumbnail via onchain SVG. There is no offchain call to IPFS anywhere.
    /// @param id_ The ID of the Brain Worm
    /// @param DNA_ The DNA of the Brain Worm
    /// @param stats_ The stats of the Brain Worm
    function tokenURI(
        uint256 id_,
        uint256 DNA_,
        uint16[7] memory stats_
    ) public view returns (string memory result) {
        // remove ERC404's huge encoding offset to get a friendly ID for the token
        id_ = id_ - ID_ENCODING_PREFIX;

        // Build the attributes JSON
        string memory attributes = buildAttributes(DNA_, stats_);

        // HSV color attribute
        uint[3] memory hsv = calculateHSV(DNA_);

        // Build the HSV JSON string, and append it to the attributes JSON
        // doing this here because I want to pass the hsv array to the thumbnail generator
        string memory hsvAttribute = string(
            abi.encodePacked(
                '{ "trait_type": "Color", "value": "hsv(',
                LibString.toString(hsv[0]),
                ", ",
                LibString.toString(hsv[1]),
                "%, ",
                LibString.toString(hsv[2]),
                '%)" }'
            )
        );

        // Append the HSV attribute to the attributes JSON
        attributes = LibString.concat(attributes, hsvAttribute);

        // Close the JSON array
        attributes = LibString.concat(attributes, "],");

        // HTML tags
        // double encoded:
        // <style>
        //     html{height:100%}body{min-height:100%;margin:0;padding:0}canvas{padding:0;margin:auto;display:block;position:absolute;top:0;bottom:0;left:0;right:0}
        // </style>
        HTMLTag[] memory headTags = new HTMLTag[](1);
        headTags[0].tagOpen = "%253Cstyle%253E";
        headTags[0]
            .tagContent = "html%257Bheight%253A100%2525%257Dbody%257Bmin-height%253A100%2525%253Bmargin%253A0%253Bpadding%253A0%257Dcanvas%257Bpadding%253A0%253Bmargin%253Aauto%253Bdisplay%253Ablock%253Bposition%253Aabsolute%253Btop%253A0%253Bbottom%253A0%253Bleft%253A0%253Bright%253A0%257D";
        headTags[0].tagClose = "%253C%252Fstyle%253E";

        // Gunzip unzips all the other scripts into the page
        HTMLTag[] memory bodyTags = new HTMLTag[](11);
        bodyTags[0].name = "gunzipScripts-0.0.1.js";
        // <script src="data:text/javascript;base64,[script]"></script>
        bodyTags[0].tagType = HTMLTagType.scriptBase64DataURI;
        bodyTags[0].contractAddress = ethfsFileStorageAddress;

        // Helps dynamically load ES modules
        bodyTags[1].name = "es-module-shims.js.Base64.gz";
        // <script type="text/javascript+gzip" src="data:text/javascript;base64,[script]"></script>
        bodyTags[1].tagType = HTMLTagType.scriptGZIPBase64DataURI;
        bodyTags[1].contractAddress = ethfsFileStorageAddress;

        // fflate is a zip/gzip library for JavaScript
        bodyTags[2].name = "fflate.module.js.Base64.gz";
        // double encoded:
        // - <script>var fflte = "
        // - "</script>
        bodyTags[2]
            .tagOpen = "%253Cscript%253Evar%2520fflte%2520%253D%2520%2522";
        bodyTags[2].tagClose = "%2522%253C%252Fscript%253E";
        bodyTags[2].contractAddress = ethfsFileStorageAddress;

        // Three.js is a 3D library for JavaScript
        bodyTags[3].name = "three-v0.162.0-module.min.js.Base64.gz";
        // double encoded:
        // - <script>var t3 = "
        // - "</script>
        bodyTags[3].tagOpen = "%253Cscript%253Evar%2520t3%2520%253D%2520%2522";
        bodyTags[3].tagClose = "%2522%253C%252Fscript%253E";
        bodyTags[3].contractAddress = ethfsFileStorageAddress;

        // OrbitControls is a camera control library for Three.js
        bodyTags[4].name = "three-v0.162.0-OrbitControls.js.Base64.gz";
        // double encoded:
        // - <script>var oc = "
        // - "</script>
        bodyTags[4].tagOpen = "%253Cscript%253Evar%2520oc%2520%253D%2520%2522";
        bodyTags[4].tagClose = "%2522%253C%252Fscript%253E";
        bodyTags[4].contractAddress = ethfsFileStorageAddress;

        // TextureUtils is a texture utility library for Three.js needed for USDZ export
        bodyTags[5].name = "three-v0.162.0-TextureUtils.js.Base64.gz";
        // double encoded:
        // - <script>var txUtl = "
        // - "</script>
        bodyTags[5]
            .tagOpen = "%253Cscript%253Evar%2520txUtl%2520%253D%2520%2522";
        bodyTags[5].tagClose = "%2522%253C%252Fscript%253E";
        bodyTags[5].contractAddress = ethfsFileStorageAddress;

        // USDZExporter is a USDZ export library for Three.js
        bodyTags[6].name = "three-v0.162.0-USDZExporter.js.Base64.gz";
        // double encoded:
        // - <script>var usDzXp = "
        // - "</script>
        bodyTags[6]
            .tagOpen = "%253Cscript%253Evar%2520usDzXp%2520%253D%2520%2522";
        bodyTags[6].tagClose = "%2522%253C%252Fscript%253E";
        bodyTags[6].contractAddress = ethfsFileStorageAddress;

        // Import handler for dynamically loading ES modules
        bodyTags[7].name = "importHandler.js";
        bodyTags[7].tagType = HTMLTagType.scriptBase64DataURI;
        bodyTags[7].contractAddress = ethfsFileStorageAddress;

        bodyTags[8].name = "";
        // <script>[script]</script>
        bodyTags[8].tagType = HTMLTagType.script;
        bodyTags[8]
            .tagContent = 'injectImportMap([ ["fflate",fflte],   ["three",t3], ["OrbitControls",oc], ["TextureUtils", txUtl], ["USDZExporter",usDzXp]  ],gunzipScripts)';

        // This passes the attributes to the generative art script so it can be used
        // to generate the art with the right traits.
        // double encoded:
        // - <script>var DNA ='
        // - ';</script>
        bodyTags[9].tagOpen = bytes(
            LibString.concat(
                "%253Cscript%253Evar%2520DNA%2520%253D%2527",
                encodeURIContract.encodeURI(
                    encodeURIContract.encodeURI(attributes)
                )
            )
        );
        bodyTags[9].tagClose = "%2527%253B%253C%252Fscript%253E";

        // The generative art script
        // double encoded:
        // - <script type="module" src="data:text/javascript;base64,
        // - "></script>
        bodyTags[10]
            .tagOpen = "%253Cscript%2520type%253D%2522module%2522%2520src%253D%2522data%253Atext%252Fjavascript%253Bbase64%252C";
        bodyTags[10].tagContent = base64ScriptContent;
        bodyTags[10].tagClose = "%2522%253E%253C%252Fscript%253E";

        // Ask the thumbnail generator contract to generate the SVG thumbnail
        // and append it to the attributes JSON
        attributes = LibString.concat(
            LibString.concat(
                LibString.concat(
                    '","image":"data:image/svg+xml;base64,',
                    IBrainWormsThumbnailGenerator(thumbnailGeneratorAddress)
                        .generateThumbnail(id_, hsv)
                ),
                '",'
            ),
            attributes
        );

        HTMLRequest memory htmlRequest;
        htmlRequest.headTags = headTags;
        htmlRequest.bodyTags = bodyTags;
        // shoutout to @0xthedude and @xtremetom for Scripty
        bytes memory doubleURLEncodedHTMLDataURI = IScriptyBuilderV2(
            scriptyBuilderAddress
        ).getHTMLURLSafe(htmlRequest);

        result = string(
            abi.encodePacked(
                "data:application/json,",
                encodeURIContract.encodeURI(
                    string(
                        abi.encodePacked(
                            '{"name":"Brain Worm # ',
                            LibString.toString(id_),
                            attributes,
                            '"description":"Brain Worms is a fully onchain generative brain parasite system, with PVP, resource harvesting, and more. Learn more at https://delcomplex.com/brainworms  \\n\\n Built on ERC-404 they are a token-coin hybrid simultaneously allowing for Brain Worms to be reborn with new traits as they are fractionalized and brought back together. \\n\\n From the cartridges that store the brain worm DNA, the 3D worms themselves, their traits, resources, and the PVP combat system. It is all fully onchain and generative! \\n\\n Brain Worms come with RPG style stats, and resources you can harvest for PVP battles. Glucose boosts Stamina, Lipids boost Strength, and Amino Acids boost Dexterity. These help round out your worms weaknesses, or let you double down on their best qualities! \\n\\n Worms can attack with Bites or Stings, and switch between Offensive and Defensive stances. These adjust your stats, allowing for sophisticated operators to gain an advantage during PVP. \\n\\n The strongest Brain Worms are issued PVP points as they win battles and climb the global leaderboard. These award special titles to the Brain Worms and further boost their stats. \\n\\n Guest Mode allows anyone with a wallet to try the simulator for free. And with full mobile wallet support, you can tend to your Brain Worms on the go. \\n\\n Help us evolve brain worms to secrete cognitive enhancing biomolecules, accelerating the human species to compete with AGI. \\n\\n A tournament of power. \\n\\n Thousands of worms in a digital brain. Evolving. Battling. Harvesting resources from the cerebrospinal fluids. \\n\\n Will you become the Apex Predator or remain Prey?","animation_url":"'
                        )
                    )
                ),
                doubleURLEncodedHTMLDataURI,
                // url encoded once
                // "}
                "%22%7D"
            )
        );
        return result;
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Internal Functions

    /// @notice Generate the HSV values for the generative art by rehashing the DNA
    /// @param DNA The DNA of the Brain Worm
    function calculateHSV(uint256 DNA) internal pure returns (uint[3] memory) {
        uint hue = (uint(
            keccak256(
                abi.encodePacked(
                    isTraitPresent(DNA, 30, 0),
                    isTraitPresent(DNA, 50, 2)
                )
            )
        ) % 340);
        uint saturation = (uint(
            keccak256(
                abi.encodePacked(
                    isTraitPresent(DNA, 80, 5),
                    isTraitPresent(DNA, 50, 6)
                )
            )
        ) % 30) + 30;
        uint value = (
            (uint(
                keccak256(
                    abi.encodePacked(
                        isTraitPresent(DNA, 50, 4),
                        isTraitPresent(DNA, 50, 7)
                    )
                )
            ) % 20)
        ) + 70;
        return [hue, saturation, value];
    }

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Owner Only Functions

    /// @notice Set the address of the thumbnail generator contract
    /// @param _newAddress The new address of the thumbnail generator contract
    function setThumbnailGeneratorAddress(
        address _newAddress
    ) public onlyOwner {
        thumbnailGeneratorAddress = _newAddress;
    }

    /// @notice Set the base64 encoded string of the generative art script
    /// @param _base64EncodedString The new base64 encoded string of the generative art script
    function setScriptContent(
        bytes calldata _base64EncodedString
    ) public onlyOwner {
        base64ScriptContent = _base64EncodedString;
    }

    /// @notice Set the address of the EncodeURI contract
    /// @param _encodeURIAddress The new address of the EncodeURI contract, thanks WhiteLights.eth
    function setEncodeURI(address _encodeURIAddress) public onlyOwner {
        encodeURIContract = EncodeURI(_encodeURIAddress);
    }

    /// @notice Set the PvP rank titles
    /// @param titles The new PvP rank titles
    function setPvpRankTitles(string[11] memory titles) public onlyOwner {
        pvpRankTitles = titles;
    }
}
