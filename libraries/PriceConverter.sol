//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{

 function getETHPrice() internal  view returns(uint256) {
        //address : 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI
        AggregatorV3Interface temp = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (
            /* uint80 roundID */,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = temp.latestRoundData();   
        return uint256(price *1e10);

    }

    function getEthToUSDRate(uint256 ethAmount) internal view returns(uint256){

        uint256 ethPrice  = getETHPrice();
        uint256 ethToUSD = (ethPrice * ethAmount) / 1e18;
        return ethToUSD;



    }

}