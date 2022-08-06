// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GrantPractice {
    // a contract where the owner create grant for a beneficiary:
    // allows beneficiary to withdraw only when time elapse
    // allows owner to withdraw before time elapse
    // get information of the beneficiary
    // amount of ethers in the smart contract

    address public owner;

    struct Beneficiary {
        uint grantReceived;
        address beneficiary;
        uint time;
    }

    mapping(uint => Beneficiary) beneficiaries;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier hasTimeElapsed(uint _id) {
        Beneficiary memory BP = beneficiaries[_id];
        require(BP.time <= block.timestamp, "time never reach");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    uint ID = 1;
    uint[] id;

    function creatGrant(address _address, uint _time) external payable onlyOwner returns (uint) {
        require(msg.value > 0, "no value passed");

        Beneficiary storage BP = beneficiaries[ID];

        BP.grantReceived = msg.value;
        BP.beneficiary = _address;
        BP.time = block.timestamp + (_time * 1 seconds);
        uint _id = ID;
        id.push(_id);

        ID++;

        return _id;
    }

    function withdraw(uint256 _id) external hasTimeElapsed(_id) {
        Beneficiary storage BP = beneficiaries[_id];
        address user = BP.beneficiary;
        require(user == msg.sender, "Not a beneficiary");

        uint amount = BP.grantReceived;
        require(amount > 0, "Insufficient funds");

        BP.grantReceived = 0;

        payable(user).transfer(amount);
    }

    function getContractBalance() external view returns (uint256 bal) {
        bal = address(this).balance;
    }

    function getUserBalance(uint _id) external view returns (uint256 bal) {
        Beneficiary storage BP = beneficiaries[_id];
        bal = BP.grantReceived;
    }

    function getAllBeneficiaries() external view returns (Beneficiary[] memory benefs) {
        uint[] memory all = id;
        benefs = new Beneficiary[](all.length);

        for(uint i = 0; i < all.length; i++) {
            benefs[i] = beneficiaries[all[i]];
        }
    }
}