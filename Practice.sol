// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Test {
    address admin;

    struct Student {
        string name;
        uint8 age;
        uint256[] scores;
    }

    mapping(address => Student) students;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(admin == msg.sender, "Only admin");
        _;
    }

    function addStudent(address _address, string memory _name, uint8 _age, uint256 _score) public onlyAdmin {
        Student storage initStudent = students[_address];

        initStudent.name = _name;
        initStudent.age = _age;
        initStudent.scores.push(_score);
    }

    function viewStudent(address _address) external view returns (Student memory) {
        return students[_address];
    }



    // function viewStudents(address [] memory query) public view onlyAdmin returns(Student[] memory studentAddress) {
    //     studentAddress = new Student[](query.length);

    //     for(uint256 i = 0; i < query.length; i++) {
    //         studentAddress[i] = students[query[i]]; 
    //     }
    // }


    // The above function can also be written using the pattern below
    function viewStudents(address[] memory query) public view onlyAdmin returns(Student[] memory ) {
        Student[] memory studentAddress = new Student[](query.length);

        for(uint256 i = 0; i < query.length; i++) {
            studentAddress[i] = students[query[i]]; 
        }

        return studentAddress;
    }


    function addStudentScore(address _address, uint256 _score) public onlyAdmin {
        Student storage selectedStudent = students[_address];
        selectedStudent.scores.push(_score);
    }

}