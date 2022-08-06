// SPDX-License-Identifier:MIT;
pragma solidity 0.8.0;


contract DB {
    // 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2  //1
    // 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db  //2
    // 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB //3

    address owner;
    struct Student{
        string name;
        uint256 age;
        uint256[] score;
    }

    mapping(address => Student) studentsDb;  // studentsDb[_address]

    constructor() {
        owner = msg.sender;
    }

    // admin === register && access their data;
    modifier onlyAdmin() {
        require(owner == msg.sender, "Only admin");
        _;
    }

    // register a student
    function InitRec(address _address, string memory _name, uint256 _age, uint256 _score) public  onlyAdmin{
        Student storage s = studentsDb[_address];
        s.name = _name;
        s.age = _age;
        s.score.push(_score);
    }

    // returns the data of a particular student
    function returnInit(address _address) public view returns (Student memory){
        return studentsDb[_address];
    }
    // [0x1, 0x2] =>   student

    // returns the array of student info
    function returnArrayInit(address[] memory query) public view onlyAdmin returns  (Student[] memory c){
        c = new Student[](9);

        for(uint256 i=0; i < query.length; i++){
            c[i] = studentsDb[query[i]];
        }
    }



    // update the array of score
    function UpdateInitRec(address _address, uint256 _score) onlyAdmin public {
        Student storage s = studentsDb[_address];
        s.score.push(_score);
    }
 

}