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
pragma solidity ^0.8.12;
pragma abicoder v2;

import {LibString} from "solady/src/utils/LibString.sol";
import {Trigonometry} from "./lib/Trigonometry.sol";
///
/// @title	Brain Worms Thumbnail Generator, part of the Brain Worms Simulation System.
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
contract BrainWormsThumbnailGenerator {
    /// @dev TANGO
    uint256 public TANGO = 4425;

    int256 constant TWO_PI = 6283185307179586476;

    /// @notice Generates a thumbnail for a given token ID
    /// @dev This is an insane house of cards not meant to be called
    ///      onchain. Nothing here is safe or efficient or sane.
    /// @param tokenId_ The token ID to generate a thumbnail for
    /// @param hsv_ The HSV values to use for the thumbnail
    function generateThumbnail(
        uint256 tokenId_,
        uint[3] memory hsv_
    ) public view virtual returns (string memory) {
        // scaled up to 1e18
        int256[2] memory tokenBasedRandomness;

        // arbitrary scaling to get a number between 0 and 100
        tokenBasedRandomness[0] = int256(((tokenId_ % 100) * 1e18) / 100);

        int256[3] memory colors = buildColors(tokenBasedRandomness[0]);

        tokenBasedRandomness[1] = perlinNoise(
            int256(tokenBasedRandomness[0] * 3),
            int256(tokenBasedRandomness[0]) +
                Trigonometry.cos(uint256(tokenId_ * 2e18)) *
                3
        );

        // build the head of the SVG
        string memory str = buildHead(
            tokenId_,
            tokenBasedRandomness[1],
            colors
        );

        // perlins0 is a raw perlin noise value
        // perlins1 is a processed value
        int256[3] memory perlins;
        int256[2] memory pos;
        // this guides the step size
        perlins[2] = 30 + int256(abs(60 * tokenBasedRandomness[1]) / 1e18);
        // keep it within bounds
        perlins[2] = perlins[2] < int256(40) ? int256(40) : perlins[2];

        // stringSteps0 holds the colors
        // stringSteps1 holds the group of more blurry objects
        // stringsteps2 holds the circle
        // stringsteps3 holds the outline around some circles
        string[5] memory stringSteps;
        stringSteps[3] = string(
            abi.encodePacked(
                ' stroke="url(#Lg)" stroke-width="',
                LibString.toString(
                    80 + (abs(80 * tokenBasedRandomness[1])) / 1e18
                ),
                '" '
            )
        );
        stringSteps[4] = ' stroke="url(#Lg2)" stroke-width="65" ';
        stringSteps[1] = '<g filter="url(#Gbl2)" >';
        // loop through the SVG and build the circles
        for (int256 x = 50; x < 650; x += perlins[2]) {
            for (int256 y = 50; y < 600; y += perlins[2]) {
                // raw perlin
                perlins[0] = perlinNoise(
                    (x * 1e18 * tokenBasedRandomness[1]) / 1e18,
                    (y * 1e18 * tokenBasedRandomness[1]) / 1e18
                );

                // process it for a step value
                perlins[1] = int256(abs((perlins[0] * 255) / 1e18));
                pos[0] = x + perlins[1];
                pos[1] = y + perlins[1];

                // keep within the bounds of the circle
                if (
                    pos[0] > 90 && pos[0] < 910 && pos[1] > 60 && pos[1] < 880
                ) {
                    int256 size;
                    // avoid stack too deep
                    {
                        // size based on perlin noise and whatnot
                        size =
                            (
                                ((perlins[2] /
                                    2 +
                                    ((perlins[2] * (size / TWO_PI)) / 1e18)) *
                                    perlins[0] *
                                    perlins[0] *
                                    2)
                            ) /
                            1e36; // bring back to normal range
                    }
                    // avoid stack too deep
                    {
                        uint256 sizeNorm = size > 60 ? 60 : uint256(size);
                        sizeNorm = (sizeNorm * 1e18) / 60;
                        uint256 hue;
                        uint256 brightness;
                        // avoid stack too deep
                        {
                            hue =
                                hsv_[0] +
                                (abs(1e18 - perlins[0]) * 25) /
                                1e18;
                            hue = hue < 20 ? 20 : hue;
                            hue = hue > 340 ? hue % 340 : hue;

                            brightness =
                                hsv_[2] +
                                uint256((abs(perlins[0]) * 30) / 1e18);
                        }
                        colors = hsvToRgb(
                            // hue
                            hue,
                            // saturation
                            hsv_[1],
                            // brightness
                            brightness
                        );
                        // RGB values as string
                        stringSteps[0] = string(
                            abi.encodePacked(
                                LibString.toString(colors[0]),
                                ",",
                                LibString.toString(colors[1]),
                                ",",
                                LibString.toString(colors[2]),
                                ')" />'
                            )
                        );
                    }

                    // build the circle
                    stringSteps[2] = string(
                        abi.encodePacked(
                            "<circle",
                            // sometimes add a stroke
                            perlins[0] % 9 == 0
                                ? stringSteps[3]
                                : perlins[0] % 7 == 0
                                    ? stringSteps[4]
                                    : "",
                            ' class="BS" cx="',
                            LibString.toString(pos[0]),
                            '" cy="',
                            LibString.toString(pos[1]),
                            '" r="',
                            LibString.toString(abs(size) + 7),
                            '" fill="rgb(',
                            stringSteps[0]
                        )
                    );

                    // put it in the blurry group
                    if (perlins[0] < tokenBasedRandomness[1]) {
                        stringSteps[1] = LibString.concat(
                            stringSteps[1],
                            stringSteps[2]
                        );
                    } else {
                        // put it in the regular line of other circles
                        str = LibString.concat(str, stringSteps[2]);
                    }
                }
            }
        }
        // close the blurry group
        stringSteps[1] = LibString.concat(stringSteps[1], "</g>");
        str = LibString.concat(str, stringSteps[1]);

        // now bring it all together and close the SVG
        str = string(
            abi.encodePacked(
                str,
                '</g><rect x="0" y="0" width="1000" height="1000" fill="black" mask="url(#circleMask)" /><circle cx="500" cy="465" r="380" stroke="white" stroke-width="4"   opacity="0.2" fill="transparent" /> <g filter="url(#Gbl2)" ><circle cx="500" cy="465" r="370" stroke="white" stroke-width="15"   opacity=".8" fill="transparent" /> </g> <path fill="white" d="M39.8,958.5c2.7,0,5.4,0,8.1,0c0.3,0,0.4,0.2,0.3,0.5c-1,2.1-2,4.3-3,6.4c-0.7,1.5-1.4,2.9-2.1,4.4 c-1.1,2.4-2.3,4.9-3.4,7.3c-0.1,0.2-0.2,0.3-0.5,0.2c-0.1,0-0.1-0.1-0.2-0.2c-0.9-2.2-1.8-4.3-2.8-6.5c-0.7-1.6-1.4-3.2-2-4.8  c-0.8-1.9-1.7-3.9-2.5-5.8c-0.2-0.4-0.3-0.7-0.5-1.1c-0.1-0.3,0-0.5,0.3-0.5C34.4,958.5,37.1,958.5,39.8,958.5 C39.8,958.5,39.8,958.5,39.8,958.5z M40.4,961.1c-1.5,0-3,0-4.6,0c-0.1,0-0.1,0-0.1,0.1c0.8,1.8,1.5,3.6,2.3,5.4 c0.7,1.6,1.4,3.2,2,4.8c0,0,0,0.1,0.1,0.1c0,0,0-0.1,0-0.1c0.4-0.8,0.8-1.6,1.1-2.4c1.2-2.6,2.4-5.1,3.7-7.7c0.1-0.1,0.1-0.1-0.1-0.1C43.5,961.1,41.9,961.1,40.4,961.1z"/> <circle fill="transparent" stroke-width="1.7235" stroke="white" cx="39.8" cy="966" r="15.2"/> <line x1="0" y1="93%" x2="100%" y2="93%" stroke="white" stroke-width="2" /> <text x="7%" y="97.3%" font-size="25" class="tx">Del Complex</text> <text x="26%" y="96%" class="tx" font-size="16">Brain Worms Colony Sample #',
                LibString.toString(tokenId_),
                '</text> <text x="26%" y="98%" class="tx" font-size="16">Not for Human Consumption</text> </svg>'
            )
        );
        return Base64.encode(bytes(str));
    }

    /// @notice Converts HSV to RGB
    /// @dev expects h: 0-360, s 0-100 , v 0-100
    ///      Why did I bother writing this in assembly?
    ///      This function should be mostly correct, but no guarantees.
    function hsvToRgb(
        uint256 hue_,
        uint256 saturation_,
        uint256 value_
    ) internal pure returns (int256[3] memory rgb) {
        assembly {
            // Cap hue to 0-360
            if gt(hue_, 340) {
                hue_ := 360
            }

            // Cap saturation to 0-100
            if gt(saturation_, 100) {
                saturation_ := 100
            }

            // Cap value to 0-100
            if gt(value_, 100) {
                value_ := 100
            }

            // Chroma
            let c := div(mul(value_, saturation_), 100)
            // Hue section for the 6 sectors of the color wheel
            let hSection := div(hue_, 60)
            let remainder := mod(hue_, 60)
            // Remainder of the hue section scaled to [0, 100]
            let remainderScaled := div(mul(remainder, 100), 60)

            // 'abs' logic
            let diff := sub(remainderScaled, 100)
            // Mimic 'abs' by checking if diff is negative, flip the sign
            if slt(diff, 0) {
                diff := sub(0, diff)
            }
            let temp := sub(100, diff)
            let x := div(mul(c, temp), 100)

            // Calculating the match value to adjust the final colors
            let m := sub(value_, c)
            let r := 0
            let g := 0
            let b := 0

            // Assigning values based on the hue section
            switch hSection
            case 0 {
                r := c
                g := x
            }
            case 1 {
                r := x
                g := c
            }
            case 2 {
                g := c
                b := x
            }
            case 3 {
                g := x
                b := c
            }
            case 4 {
                r := x
                b := c
            }
            case 5 {
                r := c
                b := x
            }

            // Adjust the color by adding m and scale back to 0-255
            r := div(mul(add(r, m), 255), 100)
            g := div(mul(add(g, m), 255), 100)
            b := div(mul(add(b, m), 255), 100)

            mstore(rgb, r)
            mstore(add(rgb, 32), g)
            mstore(add(rgb, 64), b)
        }
    }

    /// @notice Generates perlin noise, or well, a bad approximation of it which
    ///         has been tinkered with for inscrutable reasons.
    /// @dev assumes x and y are scaled by 1e18
    function perlinNoise(int256 x_, int256 y_) internal pure returns (int256) {
        // Magic numbers scaled by 1e18
        // 12.9898 * 1e18
        int256 P1X = 12989800000000000000;
        // 78.233 * 1e18
        int256 P1Y = 78233000000000000000;
        // Compute D1 with inputs scaled by 1e18
        int256 D1 = (int256(x_) * int256(y_) + P1X * P1Y) / 1e18;
        // Compute S1 using the sin function,
        int256 S1 = Trigonometry.sin(uint256(D1));
        // Magic number for scaling the sine output
        // 43758.5453 scaled by 1e18
        int256 magicNumber = 43758545300000000000000;
        // Compute S2, ensuring result is scaled back down
        int256 S2 = (S1 * magicNumber) / 1e18;
        // Return the fractional part
        return int256(S2 % 1e18);
    }

    /// @notice Builds the colors for the thumbnail
    /// @dev This was just to avoid stack too deep errors
    /// @param tokenNorm_ The normalized token ID
    function buildColors(
        int256 tokenNorm_
    ) internal pure returns (int256[3] memory colors) {
        int256 value1 = perlinNoise(
            int256(tokenNorm_ * 14),
            (Trigonometry.cos(uint256(tokenNorm_)) * 3)
        );
        int256 value2 = perlinNoise(
            int256(tokenNorm_ * 24),
            (Trigonometry.sin(uint256(tokenNorm_)) * 3)
        );
        colors[0] = int256(abs(((value1 * 41) / 1e18) % 120));
        colors[1] = int256(abs(((value1 * 73) / 1e18) % 120));
        colors[2] = int256(abs(((value2 * 82) / 1e18) % 120));
    }

    /// @notice Builds the head of the SVG
    /// @dev This was just to avoid stack too deep errors
    /// @param tokenId_ The token ID
    /// @param tokenPerlin_ The perlin noise value based on the token ID
    /// @param colors256 The colors for the thumbnail
    function buildHead(
        uint256 tokenId_,
        int256 tokenPerlin_,
        int256[3] memory colors256
    ) internal pure returns (string memory) {
        string memory str;
        string[3] memory colors = [
            LibString.toString(colors256[0]),
            LibString.toString(colors256[1]),
            LibString.toString(colors256[2])
        ];
        str = string(
            abi.encodePacked(
                '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 1000 1000">   <style>.BS {mix-blend-mode: screen;}</style><rect width="100%" height="100%" fill="rgb(',
                colors[0],
                ",",
                colors[1],
                ",",
                colors[2],
                ')" /> <mask id="circleMask"> <rect x="0" y="0" width="1000" height="1000" fill="white" /> <circle cx="500" cy="465" r="380" fill="black" /> </mask> <defs> <style type="text/css"> .tx {font-family: monospace;fill: white;}</style>'
            )
        );

        int256 F1 = (Trigonometry.cos(1e18 * tokenId_) * 100) / 1e18;
        str = string(
            abi.encodePacked(
                str,
                '<radialGradient id="Lg" x1="0" x2="0.',
                LibString.toString(F1),
                '" y1="0" y2="1"><stop offset="0" stop-color="rgb(',
                colors[0],
                ",",
                colors[1],
                ",",
                colors[2],
                ')" stop-opacity="1"/><stop offset="1" stop-color="white" stop-opacity=".2"/></radialGradient>'
            )
        );
        string memory tempStr;
        {
            tempStr = string(
                abi.encodePacked(
                    LibString.toString((10 * abs(tokenPerlin_)) / 1e18 + 15),
                    " ",
                    LibString.toString(
                        (10 * (1e18 - abs(tokenPerlin_))) / 1e18 + 15
                    )
                )
            );
        }
        {
            str = string(
                abi.encodePacked(
                    str,
                    '<radialGradient id="Lg2" x1="0" x2="',
                    LibString.toString(F1),
                    '" y1="0" y2="1"><stop offset="0.2" stop-color="rgb(',
                    colors[0],
                    ",",
                    colors[1],
                    ",",
                    colors[2],
                    ')" stop-opacity="1"/><stop offset="1" stop-color="black" stop-opacity=".5"/></radialGradient></defs><filter id="Gbl">    <feTurbulence type="turbulence" baseFrequency="0.01" numOctaves="1" result="turbulence" /> <feDisplacementMap in="SourceGraphic" in2="turbulence" scale="40" xChannelSelector="R" yChannelSelector="G"/><feGaussianBlur stdDeviation="2 3" /> </filter><filter id="Gbl2"> <feGaussianBlur stdDeviation="',
                    tempStr,
                    '" /> </filter><g filter="url(#Gbl)" >'
                )
            );
        }

        return str;
    }

    /// @notice Returns the absolute value of a signed integer
    /// @param x_ The signed integer to get the absolute value of
    function abs(int256 x_) private pure returns (uint256) {
        return uint256(x_ < 0 ? -x_ : x_);
    }
}

/// [MIT License]
/// @title Base64
/// @notice Provides a function for encoding some bytes in base64
/// @author Brecht Devos <brecht@loopring.org>
library Base64 {
    bytes internal constant TABLE =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    /// @notice Encodes some bytes to the base64 representation
    function encode(bytes memory data) internal pure returns (string memory) {
        uint256 len = data.length;
        if (len == 0) return "";
        uint256 encodedLen = 4 * ((len + 2) / 3);
        bytes memory result = new bytes(encodedLen + 32);
        bytes memory table = TABLE;

        assembly {
            let tablePtr := add(table, 1)
            let resultPtr := add(result, 32)
            for {
                let i := 0
            } lt(i, len) {

            } {
                i := add(i, 3)
                let input := and(mload(add(data, i)), 0xffffff)
                let out := mload(add(tablePtr, and(shr(18, input), 0x3F)))
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(shr(12, input), 0x3F))), 0xFF)
                )
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(shr(6, input), 0x3F))), 0xFF)
                )
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(input, 0x3F))), 0xFF)
                )
                out := shl(224, out)
                mstore(resultPtr, out)
                resultPtr := add(resultPtr, 4)
            }
            switch mod(len, 3)
            case 1 {
                mstore(sub(resultPtr, 2), shl(240, 0x3d3d))
            }
            case 2 {
                mstore(sub(resultPtr, 1), shl(248, 0x3d))
            }
            mstore(result, encodedLen)
        }
        return string(result);
    }
}

library strings {
    struct slice {
        uint _len;
        uint _ptr;
    }

    function memcpy(uint dest, uint src, uint lenIn) private pure {
        // Copy word-length chunks while possible
        for (; lenIn >= 32; lenIn -= 32) {
            assembly {
                mstore(dest, mload(src))
            }
            dest += 32;
            src += 32;
        }

        // Copy remaining bytes
        uint mask = type(uint).max;
        if (lenIn > 0) {
            mask = 256 ** (32 - lenIn) - 1;
        }
        assembly {
            let srcpart := and(mload(src), not(mask))
            let destpart := and(mload(dest), mask)
            mstore(dest, or(destpart, srcpart))
        }
    }

    /*
     * @dev Returns a slice containing the entire string.
     * @param self The string to make a slice from.
     * @return A newly allocated slice containing the entire string.
     */
    function toSlice(string memory self) internal pure returns (slice memory) {
        uint ptr;
        assembly {
            ptr := add(self, 0x20)
        }
        return slice(bytes(self).length, ptr);
    }

    /*
     * @dev Returns the length of a null-terminated bytes32 string.
     * @param self The value to find the length of.
     * @return The length of the string, from 0 to 32.
     */
    function len(bytes32 self) internal pure returns (uint) {
        uint ret;
        if (self == 0) return 0;
        if (uint(self) & type(uint128).max == 0) {
            ret += 16;
            self = bytes32(uint(self) / 0x100000000000000000000000000000000);
        }
        if (uint(self) & type(uint64).max == 0) {
            ret += 8;
            self = bytes32(uint(self) / 0x10000000000000000);
        }
        if (uint(self) & type(uint32).max == 0) {
            ret += 4;
            self = bytes32(uint(self) / 0x100000000);
        }
        if (uint(self) & type(uint16).max == 0) {
            ret += 2;
            self = bytes32(uint(self) / 0x10000);
        }
        if (uint(self) & type(uint8).max == 0) {
            ret += 1;
        }
        return 32 - ret;
    }

    /*
     * @dev Returns a slice containing the entire bytes32, interpreted as a
     *      null-terminated utf-8 string.
     * @param self The bytes32 value to convert to a slice.
     * @return A new slice containing the value of the input argument up to the
     *         first null.
     */
    function toSliceB32(bytes32 self) internal pure returns (slice memory ret) {
        // Allocate space for `self` in memory, copy it there, and point ret at it
        assembly {
            let ptr := mload(0x40)
            mstore(0x40, add(ptr, 0x20))
            mstore(ptr, self)
            mstore(add(ret, 0x20), ptr)
        }
        ret._len = len(self);
    }

    /*
     * @dev Returns a new slice containing the same data as the current slice.
     * @param self The slice to copy.
     * @return A new slice containing the same data as `self`.
     */
    function copy(slice memory self) internal pure returns (slice memory) {
        return slice(self._len, self._ptr);
    }

    /*
     * @dev Copies a slice to a new string.
     * @param self The slice to copy.
     * @return A newly allocated string containing the slice's text.
     */
    function toString(slice memory self) internal pure returns (string memory) {
        string memory ret = new string(self._len);
        uint retptr;
        assembly {
            retptr := add(ret, 32)
        }

        memcpy(retptr, self._ptr, self._len);
        return ret;
    }

    /*
     * @dev Returns the length in runes of the slice. Note that this operation
     *      takes time proportional to the length of the slice; avoid using it
     *      in loops, and call `slice.empty()` if you only need to know whether
     *      the slice is empty or not.
     * @param self The slice to operate on.
     * @return The length of the slice in runes.
     */
    function len(slice memory self) internal pure returns (uint l) {
        // Starting at ptr-31 means the LSB will be the byte we care about
        uint ptr = self._ptr - 31;
        uint end = ptr + self._len;
        for (l = 0; ptr < end; l++) {
            uint8 b;
            assembly {
                b := and(mload(ptr), 0xFF)
            }
            if (b < 0x80) {
                ptr += 1;
            } else if (b < 0xE0) {
                ptr += 2;
            } else if (b < 0xF0) {
                ptr += 3;
            } else if (b < 0xF8) {
                ptr += 4;
            } else if (b < 0xFC) {
                ptr += 5;
            } else {
                ptr += 6;
            }
        }
    }

    /*
     * @dev Returns true if the slice is empty (has a length of 0).
     * @param self The slice to operate on.
     * @return True if the slice is empty, False otherwise.
     */
    function empty(slice memory self) internal pure returns (bool) {
        return self._len == 0;
    }

    /*
     * @dev Returns a positive number if `other` comes lexicographically after
     *      `self`, a negative number if it comes before, or zero if the
     *      contents of the two slices are equal. Comparison is done per-rune,
     *      on unicode codepoints.
     * @param self The first slice to compare.
     * @param other The second slice to compare.
     * @return The result of the comparison.
     */
    function compare(
        slice memory self,
        slice memory other
    ) internal pure returns (int) {
        uint shortest = self._len;
        if (other._len < self._len) shortest = other._len;

        uint selfptr = self._ptr;
        uint otherptr = other._ptr;
        for (uint idx = 0; idx < shortest; idx += 32) {
            uint a;
            uint b;
            assembly {
                a := mload(selfptr)
                b := mload(otherptr)
            }
            if (a != b) {
                // Mask out irrelevant bytes and check again
                uint mask = type(uint).max; // 0xffff...
                if (shortest < 32) {
                    mask = ~(2 ** (8 * (32 - shortest + idx)) - 1);
                }
                unchecked {
                    uint diff = (a & mask) - (b & mask);
                    if (diff != 0) return int(diff);
                }
            }
            selfptr += 32;
            otherptr += 32;
        }
        return int(self._len) - int(other._len);
    }

    /*
     * @dev Returns true if the two slices contain the same text.
     * @param self The first slice to compare.
     * @param self The second slice to compare.
     * @return True if the slices are equal, false otherwise.
     */
    function equals(
        slice memory self,
        slice memory other
    ) internal pure returns (bool) {
        return compare(self, other) == 0;
    }

    /*
     * @dev Extracts the first rune in the slice into `rune`, advancing the
     *      slice to point to the next rune and returning `self`.
     * @param self The slice to operate on.
     * @param rune The slice that will contain the first rune.
     * @return `rune`.
     */
    function nextRune(
        slice memory self,
        slice memory rune
    ) internal pure returns (slice memory) {
        rune._ptr = self._ptr;

        if (self._len == 0) {
            rune._len = 0;
            return rune;
        }

        uint l;
        uint b;
        // Load the first byte of the rune into the LSBs of b
        assembly {
            b := and(mload(sub(mload(add(self, 32)), 31)), 0xFF)
        }
        if (b < 0x80) {
            l = 1;
        } else if (b < 0xE0) {
            l = 2;
        } else if (b < 0xF0) {
            l = 3;
        } else {
            l = 4;
        }

        // Check for truncated codepoints
        if (l > self._len) {
            rune._len = self._len;
            self._ptr += self._len;
            self._len = 0;
            return rune;
        }

        self._ptr += l;
        self._len -= l;
        rune._len = l;
        return rune;
    }

    /*
     * @dev Returns the first rune in the slice, advancing the slice to point
     *      to the next rune.
     * @param self The slice to operate on.
     * @return A slice containing only the first rune from `self`.
     */
    function nextRune(
        slice memory self
    ) internal pure returns (slice memory ret) {
        nextRune(self, ret);
    }

    /*
     * @dev Returns the number of the first codepoint in the slice.
     * @param self The slice to operate on.
     * @return The number of the first codepoint in the slice.
     */
    function ord(slice memory self) internal pure returns (uint ret) {
        if (self._len == 0) {
            return 0;
        }

        uint word;
        uint length;
        uint divisor = 2 ** 248;

        // Load the rune into the MSBs of b
        assembly {
            word := mload(mload(add(self, 32)))
        }
        uint b = word / divisor;
        if (b < 0x80) {
            ret = b;
            length = 1;
        } else if (b < 0xE0) {
            ret = b & 0x1F;
            length = 2;
        } else if (b < 0xF0) {
            ret = b & 0x0F;
            length = 3;
        } else {
            ret = b & 0x07;
            length = 4;
        }

        // Check for truncated codepoints
        if (length > self._len) {
            return 0;
        }

        for (uint i = 1; i < length; i++) {
            divisor = divisor / 256;
            b = (word / divisor) & 0xFF;
            if (b & 0xC0 != 0x80) {
                // Invalid UTF-8 sequence
                return 0;
            }
            ret = (ret * 64) | (b & 0x3F);
        }

        return ret;
    }

    /*
     * @dev Returns the keccak-256 hash of the slice.
     * @param self The slice to hash.
     * @return The hash of the slice.
     */
    function keccak(slice memory self) internal pure returns (bytes32 ret) {
        assembly {
            ret := keccak256(mload(add(self, 32)), mload(self))
        }
    }

    /*
     * @dev Returns true if `self` starts with `needle`.
     * @param self The slice to operate on.
     * @param needle The slice to search for.
     * @return True if the slice starts with the provided text, false otherwise.
     */
    function startsWith(
        slice memory self,
        slice memory needle
    ) internal pure returns (bool) {
        if (self._len < needle._len) {
            return false;
        }

        if (self._ptr == needle._ptr) {
            return true;
        }

        bool equal;
        assembly {
            let length := mload(needle)
            let selfptr := mload(add(self, 0x20))
            let needleptr := mload(add(needle, 0x20))
            equal := eq(
                keccak256(selfptr, length),
                keccak256(needleptr, length)
            )
        }
        return equal;
    }

    /*
     * @dev If `self` starts with `needle`, `needle` is removed from the
     *      beginning of `self`. Otherwise, `self` is unmodified.
     * @param self The slice to operate on.
     * @param needle The slice to search for.
     * @return `self`
     */
    function beyond(
        slice memory self,
        slice memory needle
    ) internal pure returns (slice memory) {
        if (self._len < needle._len) {
            return self;
        }

        bool equal = true;
        if (self._ptr != needle._ptr) {
            assembly {
                let length := mload(needle)
                let selfptr := mload(add(self, 0x20))
                let needleptr := mload(add(needle, 0x20))
                equal := eq(
                    keccak256(selfptr, length),
                    keccak256(needleptr, length)
                )
            }
        }

        if (equal) {
            self._len -= needle._len;
            self._ptr += needle._len;
        }

        return self;
    }

    /*
     * @dev Returns true if the slice ends with `needle`.
     * @param self The slice to operate on.
     * @param needle The slice to search for.
     * @return True if the slice starts with the provided text, false otherwise.
     */
    function endsWith(
        slice memory self,
        slice memory needle
    ) internal pure returns (bool) {
        if (self._len < needle._len) {
            return false;
        }

        uint selfptr = self._ptr + self._len - needle._len;

        if (selfptr == needle._ptr) {
            return true;
        }

        bool equal;
        assembly {
            let length := mload(needle)
            let needleptr := mload(add(needle, 0x20))
            equal := eq(
                keccak256(selfptr, length),
                keccak256(needleptr, length)
            )
        }

        return equal;
    }

    /*
     * @dev If `self` ends with `needle`, `needle` is removed from the
     *      end of `self`. Otherwise, `self` is unmodified.
     * @param self The slice to operate on.
     * @param needle The slice to search for.
     * @return `self`
     */
    function until(
        slice memory self,
        slice memory needle
    ) internal pure returns (slice memory) {
        if (self._len < needle._len) {
            return self;
        }

        uint selfptr = self._ptr + self._len - needle._len;
        bool equal = true;
        if (selfptr != needle._ptr) {
            assembly {
                let length := mload(needle)
                let needleptr := mload(add(needle, 0x20))
                equal := eq(
                    keccak256(selfptr, length),
                    keccak256(needleptr, length)
                )
            }
        }

        if (equal) {
            self._len -= needle._len;
        }

        return self;
    }

    // Returns the memory address of the first byte of the first occurrence of
    // `needle` in `self`, or the first byte after `self` if not found.
    function findPtr(
        uint selflen,
        uint selfptr,
        uint needlelen,
        uint needleptr
    ) private pure returns (uint) {
        uint ptr = selfptr;
        uint idx;

        if (needlelen <= selflen) {
            if (needlelen <= 32) {
                bytes32 mask;
                if (needlelen > 0) {
                    mask = bytes32(~(2 ** (8 * (32 - needlelen)) - 1));
                }

                bytes32 needledata;
                assembly {
                    needledata := and(mload(needleptr), mask)
                }

                uint end = selfptr + selflen - needlelen;
                bytes32 ptrdata;
                assembly {
                    ptrdata := and(mload(ptr), mask)
                }

                while (ptrdata != needledata) {
                    if (ptr >= end) return selfptr + selflen;
                    ptr++;
                    assembly {
                        ptrdata := and(mload(ptr), mask)
                    }
                }
                return ptr;
            } else {
                // For long needles, use hashing
                bytes32 hash;
                assembly {
                    hash := keccak256(needleptr, needlelen)
                }

                for (idx = 0; idx <= selflen - needlelen; idx++) {
                    bytes32 testHash;
                    assembly {
                        testHash := keccak256(ptr, needlelen)
                    }
                    if (hash == testHash) return ptr;
                    ptr += 1;
                }
            }
        }
        return selfptr + selflen;
    }

    // Returns the memory address of the first byte after the last occurrence of
    // `needle` in `self`, or the address of `self` if not found.
    function rfindPtr(
        uint selflen,
        uint selfptr,
        uint needlelen,
        uint needleptr
    ) private pure returns (uint) {
        uint ptr;

        if (needlelen <= selflen) {
            if (needlelen <= 32) {
                bytes32 mask;
                if (needlelen > 0) {
                    mask = bytes32(~(2 ** (8 * (32 - needlelen)) - 1));
                }

                bytes32 needledata;
                assembly {
                    needledata := and(mload(needleptr), mask)
                }

                ptr = selfptr + selflen - needlelen;
                bytes32 ptrdata;
                assembly {
                    ptrdata := and(mload(ptr), mask)
                }

                while (ptrdata != needledata) {
                    if (ptr <= selfptr) return selfptr;
                    ptr--;
                    assembly {
                        ptrdata := and(mload(ptr), mask)
                    }
                }
                return ptr + needlelen;
            } else {
                // For long needles, use hashing
                bytes32 hash;
                assembly {
                    hash := keccak256(needleptr, needlelen)
                }
                ptr = selfptr + (selflen - needlelen);
                while (ptr >= selfptr) {
                    bytes32 testHash;
                    assembly {
                        testHash := keccak256(ptr, needlelen)
                    }
                    if (hash == testHash) return ptr + needlelen;
                    ptr -= 1;
                }
            }
        }
        return selfptr;
    }

    /*
     * @dev Modifies `self` to contain everything from the first occurrence of
     *      `needle` to the end of the slice. `self` is set to the empty slice
     *      if `needle` is not found.
     * @param self The slice to search and modify.
     * @param needle The text to search for.
     * @return `self`.
     */
    function find(
        slice memory self,
        slice memory needle
    ) internal pure returns (slice memory) {
        uint ptr = findPtr(self._len, self._ptr, needle._len, needle._ptr);
        self._len -= ptr - self._ptr;
        self._ptr = ptr;
        return self;
    }

    /*
     * @dev Modifies `self` to contain the part of the string from the start of
     *      `self` to the end of the first occurrence of `needle`. If `needle`
     *      is not found, `self` is set to the empty slice.
     * @param self The slice to search and modify.
     * @param needle The text to search for.
     * @return `self`.
     */
    function rfind(
        slice memory self,
        slice memory needle
    ) internal pure returns (slice memory) {
        uint ptr = rfindPtr(self._len, self._ptr, needle._len, needle._ptr);
        self._len = ptr - self._ptr;
        return self;
    }

    /*
     * @dev Splits the slice, setting `self` to everything after the first
     *      occurrence of `needle`, and `token` to everything before it. If
     *      `needle` does not occur in `self`, `self` is set to the empty slice,
     *      and `token` is set to the entirety of `self`.
     * @param self The slice to split.
     * @param needle The text to search for in `self`.
     * @param token An output parameter to which the first token is written.
     * @return `token`.
     */
    function split(
        slice memory self,
        slice memory needle,
        slice memory token
    ) internal pure returns (slice memory) {
        uint ptr = findPtr(self._len, self._ptr, needle._len, needle._ptr);
        token._ptr = self._ptr;
        token._len = ptr - self._ptr;
        if (ptr == self._ptr + self._len) {
            // Not found
            self._len = 0;
        } else {
            self._len -= token._len + needle._len;
            self._ptr = ptr + needle._len;
        }
        return token;
    }

    /*
     * @dev Splits the slice, setting `self` to everything after the first
     *      occurrence of `needle`, and returning everything before it. If
     *      `needle` does not occur in `self`, `self` is set to the empty slice,
     *      and the entirety of `self` is returned.
     * @param self The slice to split.
     * @param needle The text to search for in `self`.
     * @return The part of `self` up to the first occurrence of `delim`.
     */
    function split(
        slice memory self,
        slice memory needle
    ) internal pure returns (slice memory token) {
        split(self, needle, token);
    }

    /*
     * @dev Splits the slice, setting `self` to everything before the last
     *      occurrence of `needle`, and `token` to everything after it. If
     *      `needle` does not occur in `self`, `self` is set to the empty slice,
     *      and `token` is set to the entirety of `self`.
     * @param self The slice to split.
     * @param needle The text to search for in `self`.
     * @param token An output parameter to which the first token is written.
     * @return `token`.
     */
    function rsplit(
        slice memory self,
        slice memory needle,
        slice memory token
    ) internal pure returns (slice memory) {
        uint ptr = rfindPtr(self._len, self._ptr, needle._len, needle._ptr);
        token._ptr = ptr;
        token._len = self._len - (ptr - self._ptr);
        if (ptr == self._ptr) {
            // Not found
            self._len = 0;
        } else {
            self._len -= token._len + needle._len;
        }
        return token;
    }

    /*
     * @dev Splits the slice, setting `self` to everything before the last
     *      occurrence of `needle`, and returning everything after it. If
     *      `needle` does not occur in `self`, `self` is set to the empty slice,
     *      and the entirety of `self` is returned.
     * @param self The slice to split.
     * @param needle The text to search for in `self`.
     * @return The part of `self` after the last occurrence of `delim`.
     */
    function rsplit(
        slice memory self,
        slice memory needle
    ) internal pure returns (slice memory token) {
        rsplit(self, needle, token);
    }

    /*
     * @dev Counts the number of nonoverlapping occurrences of `needle` in `self`.
     * @param self The slice to search.
     * @param needle The text to search for in `self`.
     * @return The number of occurrences of `needle` found in `self`.
     */
    function count(
        slice memory self,
        slice memory needle
    ) internal pure returns (uint cnt) {
        uint ptr = findPtr(self._len, self._ptr, needle._len, needle._ptr) +
            needle._len;
        while (ptr <= self._ptr + self._len) {
            cnt++;
            ptr =
                findPtr(
                    self._len - (ptr - self._ptr),
                    ptr,
                    needle._len,
                    needle._ptr
                ) +
                needle._len;
        }
    }

    /*
     * @dev Returns True if `self` contains `needle`.
     * @param self The slice to search.
     * @param needle The text to search for in `self`.
     * @return True if `needle` is found in `self`, false otherwise.
     */
    function contains(
        slice memory self,
        slice memory needle
    ) internal pure returns (bool) {
        return
            rfindPtr(self._len, self._ptr, needle._len, needle._ptr) !=
            self._ptr;
    }

    /*
     * @dev Returns a newly allocated string containing the concatenation of
     *      `self` and `other`.
     * @param self The first slice to concatenate.
     * @param other The second slice to concatenate.
     * @return The concatenation of the two strings.
     */
    function concat(
        slice memory self,
        slice memory other
    ) internal pure returns (string memory) {
        string memory ret = new string(self._len + other._len);
        uint retptr;
        assembly {
            retptr := add(ret, 32)
        }
        memcpy(retptr, self._ptr, self._len);
        memcpy(retptr + self._len, other._ptr, other._len);
        return ret;
    }

    /*
     * @dev Joins an array of slices, using `self` as a delimiter, returning a
     *      newly allocated string.
     * @param self The delimiter to use.
     * @param parts A list of slices to join.
     * @return A newly allocated string containing all the slices in `parts`,
     *         joined with `self`.
     */
    function join(
        slice memory self,
        slice[] memory parts
    ) internal pure returns (string memory) {
        if (parts.length == 0) return "";

        uint length = self._len * (parts.length - 1);
        for (uint i = 0; i < parts.length; i++) length += parts[i]._len;

        string memory ret = new string(length);
        uint retptr;
        assembly {
            retptr := add(ret, 32)
        }

        for (uint i = 0; i < parts.length; i++) {
            memcpy(retptr, parts[i]._ptr, parts[i]._len);
            retptr += parts[i]._len;
            if (i < parts.length - 1) {
                memcpy(retptr, self._ptr, self._len);
                retptr += self._len;
            }
        }

        return ret;
    }
}
