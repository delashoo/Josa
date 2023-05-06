// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.4.24;

import "./IERC20.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";

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

    /**
     * @notice Gets the balance of the specified address
     * @param address of the owner, to be querried of the balance
     * @return uint256 representing amount of token owned by the address
     */
    function balanceOf(address owner) public view returns (uint256) {
        return _balances[owner];
    }

    /** 
     * @notice checks the amount allowed by owner's address to spender
     * @param Owner's address - where tokens reside.
     * @param spender address - that spends the tokens
     * @return a uint256 specyfing the amount of tokens still available for spender
    */
   function allowance(address owner, address spender) public view returns (uint256) {
        return _allowed[owner][spender];
   }
   
   /**
    * @notice transfers tokens to another address
    * @dev Can be used for withdrawals or payments of utilities
    * @param _to address - that receives the tokens
    * @param value - amount of tokens being transfered
    */
   function transfer(address to, uint256 value) public returns (bool) {
        require(value <= _balances[msg.sender]);
        require(to != address(0));

        _balances[msg.sender] = _balances[msg.sender].sub(value);
        _balances[to] = _balances[to].add(value);

        emit Transfer(msg.sender, to, value);
        return true;
   }

   /**
    * @notice Approves spender address to spend specified amount of tokens on behalf of msg.sender
    * BEWARE!
    * Changing allowance with this method introduces risk of spender spending both old & new allowance by unfortunate transaction orders
    * Solution to this involves first setting allowance to zero then allocating new value
    * @param spender address - that spends the token
    * @param value - amount of tokens to be spent
    */
   function approve(address spender, uint256 value) public returns(bool) {
        require(spender != address(0));

        _allowed[msg.sender][spender] = value;

        emit Approval(msg.sender, spender, value);
        return true;
   }

   /**
    * @delashoo 
    * @notice transfers tokens from one address to another
    * @param from address - From which tokens reside
    * @param to address - that receives tokens
    * @param value - amount of tokens being transferred
    */
   function transferFrom(address from, address to, uint256 value) publiv returns(bool) {
        require(value <= _balances[from]);
        require(value <= _allowed[from]msg.sender[]);
        require(to != address(0));

        _balance[from] = _balances[from].sub(value);
        _balances[to] = _balances[to].add(value);
        _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(value);

        emit Transfer(from, to, value);
        return true;
   }

   /**
    * @notice Increases the amount of tokens that owner allows spender address
    * approve should be called when allowed == 0, to increment= to avoid 2 calls and wait until first transaction is mined
    * @param spender - address that spends the tokens
    * @param addedvalue - Amount of tokens to increase the allowance by
    */
   function increaseAllowance(address spender, uint256 addedValue) public return(bool) {
        require(spender != address(0));

        _allowed[msg.sender][spender] = (_allowed[msg.sendr][spender].add(addedValue));

        emit Approval(msg.sender, spender, _allowed[msg.sender][spender]);
        return true;
   }

   /**
    * @notice Decreases the amount of tokens spender is allowed to spend
    * @param spender - address that spends tokens instead of msg.sender
    * @param subtractedvalue - Amount of tokens to decrease the allowance by.
    */
   function decreaseAllowance(address spender, uint256 subtractedvalue) public returns(bool) {
        require(spender != address(0));

        _allowed[msg.sender][spender] = (allowed[msg.sender][spender].sub(subtractedValue));

        emit Approval(msg.sender, spender, allowed[msg.sender][spender]);
        return true;
   }

   /**
    * @notice Allows for new tokens to be generated following some mechanism
    * @param account - address that receives the created tokens
    * @param amount of tokens being created
    */
   function _mint(address account, uint256 amount) internal {
        require(account != 0);

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        
        emit Transfer(address(0), account, amount);
  }

  /**
   * @notice an internal function to burn an amount of tokens of a given account
   * @param account - address whose tokens will be burnt.
   * @param amount - token number to be burnt
   */
  function _burn(address account, uint256 amount) internal {
        require(account != 0);
        require(amount <= _balances[account]);

        _totalSupply = _totalSupply.sub(amount);
        _balances[account] = _balances[account].sub(amount);

        emit Transfer(account, address(0), amount);
  }

  /**
   * @notice An internal function that burns an amount of tokens of a given address deducting the sender's allowance for the said address
   * @param account -address from which tokens will be burnt
   * @param amount the amount of tokens that will be burnt
   */
  function _burnFrom(address account, uint256 amount) internal {
        require(amount <= _allowed[account][msg.sender]);

        // Should https://github.com/OpenZeppelin/zeppelin-solidity/issues/707 be accepted,
        // this function needs to emit an event with the updated approval.
        _allowed[account][msg.sender] = _allowed[account][msg.sender].sub(amount);
        _burn(account, amount);
  }
}