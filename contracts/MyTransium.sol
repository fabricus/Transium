pragma solidity ^0.5.0;

import "openzeppelin-eth/contracts/token/ERC721/ERC721Full.sol";

contract MyTransium is ERC721Full {
    using SafeMath for uint256;

    // Initializing an ERC-721 Token named 'Transium' with a symbol 'TRZ'
    function initialize(string memory name, string memory symbol) public initializer {
        ERC721.initialize();
        ERC721Enumerable.initialize();
        ERC721Metadata.initialize(name, symbol);
    }
}
