// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// crud de usuario

contract Main {
    struct User {
        string name;
        uint amount;
        bool  valid;
    }

    mapping(address => User) private users;

    function createUser(string memory  _name) external returns(string memory){
        require(users[msg.sender].valid == false);
        users[msg.sender] = User(_name, 0, true);
        return "created";
    }

    function updateUser(string memory _newName) external returns(string memory){
        require(users[msg.sender].valid == true);
        users[msg.sender].name = _newName;
        return "updated";
    }

    function showUser() external view returns(User memory){
        return users[msg.sender];
    }

    function updateBalance(bool _isAddAmount, uint _amount) internal returns(string memory, uint){
        if(_isAddAmount){
            users[msg.sender].amount += _amount;
        }else{
            users[msg.sender].amount -= _amount;
        }
        return ("balance updated success", users[msg.sender].amount);
    }

    function addAmount(uint _amountQty) external returns(string memory, uint){
        require(users[msg.sender].valid == true);
        return updateBalance(true, _amountQty);
    }

    function removeAmount(uint _amountQty) external returns(string memory, uint){
        require(users[msg.sender].valid == true);
        return updateBalance(false, _amountQty);
    }

    function deleteUser() external  returns(string memory){
        require(users[msg.sender].valid == true);
        delete users[msg.sender];
        return "user deleted successfully";
    }
}