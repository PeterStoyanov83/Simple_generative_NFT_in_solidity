// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GenerativeNFT is ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    // Base URI for generative art
    string private _baseTokenURI;

    /**
     * @dev Constructor that sets the name, symbol, and base token URI for the NFT.
     * @param name - Name of the NFT.
     * @param symbol - Symbol or ticker of the NFT.
     * @param baseTokenURI - Initial base URI for the token metadata.
     */
    constructor(string memory name, string memory symbol, string memory baseTokenURI) ERC721(name, symbol) {
        _baseTokenURI = baseTokenURI;
    }

    /**
     * @dev Internal function that returns the base URI for the token's metadata.
     * @return string - The current base URI.
     */
    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    /**
     * @dev Function for the contract owner to set a new base URI for token metadata.
     * @param baseTokenURI - The new base URI to be set.
     */
    function setBaseURI(string memory baseTokenURI) external onlyOwner {
        _baseTokenURI = baseTokenURI;
    }

    /**
     * @dev Function for the contract owner to mint a new token.
     * @param recipient - The address to receive the minted NFT.
     */
    function mint(address recipient) external onlyOwner {
        _tokenIdCounter.increment();
        uint256 newTokenId = _tokenIdCounter.current();
        _safeMint(recipient, newTokenId);
    }
}
