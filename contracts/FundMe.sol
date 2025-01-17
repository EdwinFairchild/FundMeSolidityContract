//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
 import {PriceConverter} from "../libraries/PriceConverter.sol";

contract FundMe{
    using PriceConverter for uint256;
    uint256 minFundAmountUSD = 5;

    //keep tract of fnders
    address[] public funders;
    // map an address type to a uint256 type
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    

    function fund()  payable public{
        // msg.value is an uin256 and it is automatically passed as first argument to getEthToUSDRate
        require(msg.value.getEthToUSDRate() >= minFundAmountUSD, "Minimum required is 5 USD");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;

    }

    function wuthdraw() public {
        for( uint256 funderIndex = 0 ; funderIndex < funders.length ; funderIndex++){
            // reset the amount funded associated with the funder
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;

        }
    }


}