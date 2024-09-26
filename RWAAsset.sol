// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RWAAsset is ERC721, Ownable {
    uint256 public nextTokenId;

    struct Asset {
        string name;
        string description;
        uint256 value;
    }

    mapping(uint256 => Asset) public assets;

    constructor() ERC721("RWAAsset", "RWA") {}

    // Mint a new asset (ERC-721 token)
    function mintAsset(
        address to,
        string memory _name,
        string memory _description,
        uint256 _value
    ) public onlyOwner {
        uint256 tokenId = nextTokenId;
        _safeMint(to, tokenId);
        
        assets[tokenId] = Asset({
            name: _name,
            description: _description,
            value: _value
        });

        nextTokenId++;
    }

    // Get asset details
    function getAssetDetails(uint256 tokenId) public view returns (string memory, string memory, uint256) {
        require(_exists(tokenId), "Asset does not exist");
        Asset memory asset = assets[tokenId];
        return (asset.name, asset.description, asset.value);
    }
}
