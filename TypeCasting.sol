// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TypeCasting {

    event Converted(address owner, string message);

    bytes32 public x = "This is the beginning of Adddddd";
    string public y = "This is the beginning of Adddddd";

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not only");
        _;
    }

    function changeOwner(address _address) public onlyOwner {
        owner = _address;
        emit Converted(_address, "Ownership transfered");
    }

    function showOwner() external view returns (address) {
        return owner;
    }

    function convertByteToString() public view returns(string memory) {
        string memory result = string(abi.encodePacked(x));
        return result;
    }
}