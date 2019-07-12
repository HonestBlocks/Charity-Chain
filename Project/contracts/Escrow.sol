pragma solidity ^0.5.0;

import "./token.sol";
import "./Claims.sol";

contract Ownable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * > Note: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract donor_init is Ownable,MyFirstToken{

    function initialize(address _newDonor)private onlyOwner{
        __balanceOf[_newDonor]+=100;
    }
}

contract Charity is MyFirstToken,ClaimsRegistry{
    
    mapping (address=>mapping(bytes32=>uint)) public due; 
    
    
    function donate(uint _amount,address _recipient,bytes32 _key) public returns (bool){
        //ClaimsRegistry a;
        if  (isApproved(_recipient,_recipient,_key)){
            return transfer(_recipient,_amount);
        }
        
            if (_amount > 0 && _amount <= balanceOf(msg.sender)) {
            __balanceOf[msg.sender] -= _amount;
            due[_recipient][_key]+=_amount;
            return true;
        }
        return false;
    }
    
    function ClearDues(address _recipient,bytes32 _key) public {
        if  (isApproved(_recipient,_recipient,_key)){
            __balanceOf[_recipient]+=due[_recipient][_key];
            due[_recipient][_key]=0;
        }
    }
}
