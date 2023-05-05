// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.4.24;

import "./IERC20.sol";
import "../../math/SafeMath.sol";

/**
 * @title standard token
 */
contract Name {

    using safeMath for uint256;

    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowed;

    uint256 private _totalSupply;

    /**
     * @notice total number of existing tokens
     */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
}