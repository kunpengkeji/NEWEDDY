// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./IERC20.sol"; //import IERC20

// ERC20代币的水龙头合约
contract Faucet {
    address public tokenContract;   // token代币合约地址
    mapping(address => uint256) public requestedAddress;   // 记录领取过代币的地址
    address public owner; //合约发布者
    uint256 public amountAllowed ; // 每次领取得数量

    // SendToken事件    
    event SendToken(address indexed Receiver, uint256 indexed Amount); 

    // 部署时设定ERC2代币合约
    constructor(address _tokenContract,uint256 _amountAllowed) {
        tokenContract = _tokenContract; // set token contract
        amountAllowed=_amountAllowed;
        owner=msg.sender;
    }

    // 用户领取代币函数
    function requestTokens() external {
        if(requestedAddress[msg.sender]>0){require(requestedAddress[msg.sender]-block.timestamp >=1 days,"");}   
        IERC20 token = IERC20(tokenContract); // 创建IERC20合约对象
        require(token.balanceOf(address(this)) >= amountAllowed, "Faucet Empty!"); // 水龙头空了

        token.transfer(msg.sender, amountAllowed); // 发送token
        requestedAddress[msg.sender] = block.timestamp; // 记录领取地址 
        
        emit SendToken(msg.sender, amountAllowed); // 释放SendToken事件
    }

    //设置每次领取数量，只有合约开发这才可以调用
    function setAmountEachTime(uint256 _amountAllowed) public {
        require(msg.sender == owner, "Only the owner can set the amount");
          amountAllowed=_amountAllowed;  //更新每次领取得数量
    }
}