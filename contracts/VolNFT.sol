pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

// Basic skeleton of the volatility NFT 
contract VolNFT is ERC721 {
    // TODO: need to figure out a way to integrate the GVOL data feed into the NFT
    // TODO: find a way to update the NFT meta-data based on change in GVOL implied volatility
    constructor() public ERC721("VolNFT", "VOL") public {       
    }    
}