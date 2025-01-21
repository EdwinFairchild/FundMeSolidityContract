//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe{
    using PriceConverter for uint256;
    uint256 constant minFundAmountUSD = 5;

    //keep tract of fnders
    address[] public funders;
    // map an address type to a uint256 type
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    address public immutable i_owner;

    constructor (){
        i_owner = msg.sender;
    }

    function fund()  payable public{
        // msg.value is an uin256 and it is automatically passed as first argument to getEthToUSDRate
        require(msg.value.getEthToUSDRate() >= minFundAmountUSD, "Minimum required is 5 USD");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;

    }

    function withdraw() public funderOnly {
    // check how much the caller has funded
    uint256 fundedAmount = addressToAmountFunded[msg.sender];
   
    // reset the caller's funded amount
    addressToAmountFunded[msg.sender] = 0;

    // transfer the funds back to the caller
    (bool success, ) = payable(msg.sender).call{value: fundedAmount}("");
    require(success, "Withdraw failed");
}

    modifier ownerOnly(){
        // require(msg.sender != i_owner, "You are not the owner");
        if(msg.sender != i_owner){
            revert NotOwner();
        }
        _;
    }

    modifier funderOnly() {
    require(addressToAmountFunded[msg.sender] > 0, "You have no funds to withdraw");
    _;
}


}