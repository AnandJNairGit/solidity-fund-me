// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe
{
  uint256 public minimumUsd = 50 * 1e18;
   function fund() public payable {
       msg.value; //to get howmuch value somebody is sending 
       require(getConversion(msg.value) > minimumUsd, "didn't receive enough value"); //1e18= 1 * 10 ** 18
   }  

   function getVersion() public view returns(uint256){
     AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
     return priceFeed.version();
   }

   function getPrice() public view returns(uint256){
     // contract address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
    (,int256 price,,,) = priceFeed.latestRoundData(); // ETH in terms of USD
    return uint256(price * 1e10);

   }

   function getConversion(uint256 ethAmount) public view returns (uint256)
   {
     uint256 ethPrice = getPrice();
     uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
     return ethAmountInUsd;
   }
}