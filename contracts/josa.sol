// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract GameItem is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("Josa", "JSA") {}

    function awardJosa(address player, string memory tokenURI) public returns (uint256) {
        uint256 newJosaId = _tokenIds.current();

        _safemint(msg.sender, newJosaId);
        _setTokenURI(newJosaId, tokenURI);

        _tokenIds.increment();
        return newJosaId;
    }
}