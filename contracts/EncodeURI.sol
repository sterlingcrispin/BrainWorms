// SPDX-License-Identifier: MIT
// via @iamwhitelights
pragma solidity ^0.8.17;
contract EncodeURI {
    /**
     * @dev URI Encoding/Decoding Hex Table
     */
    bytes internal constant TABLE = "0123456789ABCDEF";

    /**
     * @dev URI encodes the provided string. Gas optimized like crazy.
     */
    function encodeURI(string memory str_) public pure returns (string memory) {
        bytes memory input = bytes(str_);
        uint256 inputLength = input.length;
        uint256 outputLength = 0;

        for (uint256 i = 0; i < inputLength; i++) {
            bytes1 b = input[i];

            if (
                (b >= 0x30 && b <= 0x39) ||
                (b >= 0x41 && b <= 0x5a) ||
                (b >= 0x61 && b <= 0x7a)
            ) {
                outputLength++;
            } else {
                outputLength += 3;
            }
        }

        bytes memory output = new bytes(outputLength);
        uint256 j = 0;

        for (uint256 i = 0; i < inputLength; i++) {
            bytes1 b = input[i];

            if (
                (b >= 0x30 && b <= 0x39) ||
                (b >= 0x41 && b <= 0x5a) ||
                (b >= 0x61 && b <= 0x7a)
            ) {
                output[j++] = b;
            } else {
                bytes1 b1 = TABLE[uint8(b) / 16];
                bytes1 b2 = TABLE[uint8(b) % 16];
                output[j++] = 0x25; // '%'
                output[j++] = b1;
                output[j++] = b2;
            }
        }

        return string(output);
    }
}
