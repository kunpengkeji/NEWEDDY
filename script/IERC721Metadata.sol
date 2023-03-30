// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


//IERC721Metadata 是ERC721的扩展接口,实现了3个查询metadata元数据的常用函数:

interface IERC721Metadata {
    function name() external view returns (string memory); //返回代币名称

    function symbol() external view returns (string memory);//代币代号

    function tokenURI(uint256 tokenId) external view returns (string memory);//通过tokenId查询metadata的连接url，ERC721特有函数
}