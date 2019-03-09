pragma solidity ^0.5.0;

import "openzeppelin-eth/contracts/token/ERC721/ERC721Full.sol";
import "openzeppelin-eth/contracts/token/ERC721/ERC721MetadataMintable.sol";
import "openzeppelin-eth/contracts/token/ERC721/ERC721Pausable.sol";

contract MyTransium is ERC721Full, ERC721MetadataMintable, ERC721Pausable {
    using SafeMath for uint256;

    // Initializing an ERC-721 Token with its name & symbol
    function initialize(string memory name, string memory symbol, address[] memory minters, address[] memory pausers) public initializer {
        ERC721.initialize();
        ERC721Enumerable.initialize();
        ERC721Metadata.initialize(name, symbol);

        // Initialize the minter and pauser roles, and renounce them
        ERC721MetadataMintable.initialize(address(this));
        _removeMinter(address(this));

        ERC721Pausable.initialize(address(this));
        _removePauser(address(this));

        // Add the requested minters and pausers (this can be done after renouncing since
        // these are the internal calls)
        for (uint256 i = 0; i < minters.length; ++i) {
            _addMinter(minters[i]);
        }

        for (uint256 i = 0; i < pausers.length; ++i) {
            _addPauser(pausers[i]);
        }
    }
}
