// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Packing {
    // SLOT 1
    address a; // 20bytes
    uint64 b; // 8bytes
    uint32 c; // 4bytes

    // SLOT 2
    uint256 z; // 32bytes
}