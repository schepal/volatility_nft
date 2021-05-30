/* 
The purpose of this contract is to allow users to call the At-The-Money Implied Volatility for BTC or
ETH on a specific time-horizon. 
*/

pragma solidity ^0.6.0;

import "https://raw.githubusercontent.com/smartcontractkit/chainlink/develop/evm-contracts/src/v0.6/ChainlinkClient.sol";

contract GVOL is ChainlinkClient {
    // Declare the contract variables
    address private oracle;
    bytes32 private jobId;
    uint256 private fee;
    uint256 public result;
    
    constructor() public {
        setPublicChainlinkToken();
        /* 
        This contract is currently implemented on Kovan. The oracle and jobId data can be located here:
        https://market.link/nodes/9a9dfca2-6a47-4d12-a095-2224beec8c41/integrations?network=1
        */
        // Kovan LINK Oracle Address
        oracle = 0x56dd6586DB0D08c6Ce7B2f2805af28616E082455;
        // Genesis Volatility Kovan At-The-Money Implied Volatility Job ID 
        jobId = "5fd92f9bbc67465a80b8c4770dd89212";
        // Fee of 0.10 LINK
        fee = 0.1 * 10 ** 18;
    }
    
    // Used to retrieve the current Implied Volatility for either BTC or ETH over a given period
    function requestIV(string memory _symbol, string memory _period) public {
        Chainlink.Request memory req = buildChainlinkRequest(jobId, address(this), this.fulfillVolatility.selector);
        req.add("symbol", _symbol);
        req.add("day", _period);
        sendChainlinkRequestTo(oracle, req, fee);
    }
    
    // Used to store and keep track of the overall results
    function fulfillVolatility(bytes32 _requestId, uint256 _result) public recordChainlinkFulfillment(_requestId) {
        result = _result;
    }

}