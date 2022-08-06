// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract DB {
    address public admin;
    
    struct Student {
        string name;
        uint256 age;
        uint256[] score;
    }

    // mapping()
    mapping(address => Student) students;

    Student[] studentsRecords;

    constructor() {
        admin = msg.sender;
    }


    // register a student
    function InitRec(address _address, string memory _name, uint256 _age, uint256[] memory _score) public {
        require(msg.sender == admin, "Only admin");
        
        Student storage initStudent = students[_address];
        
        initStudent.name = _name;
        initStudent.age = _age;
        initStudent.score = _score;
        studentsRecords.push(initStudent);
    }

    // returns the data one particular student
    function showStudent(uint _index) public view returns (Student memory) {
        return studentsRecords[_index];
    }

    // returns the array of student info
    function allStudents() external view returns (Student[] memory) {
        return studentsRecords;
    }
}