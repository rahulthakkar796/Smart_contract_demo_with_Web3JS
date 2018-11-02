pragma solidity ^0.4.18;


contract Owned {
    address owner;
    
//function to assign ownership to current address    
    function Owned() public {
        owner = msg.sender;
    }
    
    //modifier to check the condition of ownership
   modifier onlyOwner {
       require(msg.sender == owner);
       _;
   }
}

contract Courses is Owned {

// struct to store the details of an instructor
    struct Instructor {
        uint age;
        bytes16 fName;
        bytes16 lName;
    }
    //maps Instructor struct to the owner address
    mapping (address => Instructor) instructors;
    
    //array of address type to store the registered instructor addresses
    address[] public instructorAccts;
    
    //event to notify that given in has been registered successfully
    event instructorInfo(
       bytes16 fName,
       bytes16 lName,
       uint age
    );
    //function to assign values to given variables
    function setInstructor(address _address, uint _age, bytes16 _fName, bytes16 _lName) onlyOwner public {
        var instructor = instructors[_address];
        
        instructor.age = _age;
        instructor.fName = _fName;
        instructor.lName = _lName;
        
        instructorAccts.push(_address) -1;
        instructorInfo(_fName, _lName, _age);
    }
    
    //return registered instructor accounts
    function getInstructors() view public returns(address[]) {
        return instructorAccts;
    }
    
    //return all the details of given instructor
    function getInstructor(address _address) view public returns (uint, bytes16, bytes16) {
        return (instructors[_address].age, instructors[_address].fName, instructors[_address].lName);
    }
    
    //return number of instructors registered(count of u)
    function countInstructors() view public returns (uint) {
        return instructorAccts.length;
    }
    
}