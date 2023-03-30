// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC165.sol";

/**
 * @dev ERC721标准接口.
 */
interface IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);//在转账时被释放，记录代币的发出地址from，接收地址to和tokenid。
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);//在授权时释放，记录授权地址owner，被授权地址approved和tokenid
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function balanceOf(address owner) external view returns (uint256 balance);//balanceOf：返回某地址的NFT持有量balance。

    function ownerOf(uint256 tokenId) external view returns (address owner);//返回某tokenId的主人owner

    function safeTransferFrom(  //安全转账的重载函数，参数里面包含了data。
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;

    function safeTransferFrom( //安全转账（如果接收方是合约地址，会要求实现ERC721Receiver接口）。参数为转出地址from，接收地址to和
        address from,
        address to,
        uint256 tokenId
    ) external;

    function transferFrom(//普通转账，参数为转出地址from，接收地址to和tokenId
        address from,
        address to,
        uint256 tokenId
    ) external;

    function approve(address to, uint256 tokenId) external; //授权另一个地址使用你的NFT。参数为被授权地址approve和tokenId。

    function setApprovalForAll(address operator, bool _approved) external;//将自己持有的该系列NFT批量授权给某个地址operator。

    function getApproved(uint256 tokenId) external view returns (address operator);//查询tokenId被批准给了哪个地址。

    function isApprovedForAll(address owner, address operator) external view returns (bool);//查询某地址的NFT是否批量授权给了另一个operator地址。
}