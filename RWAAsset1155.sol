// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract RWAAsset1155 is ERC1155, Ownable {
    uint256 public nextTokenId;
struct Asset {
        string name;
        string description;
        uint256 value;
    }
mapping(uint256 => Asset) public assets;
    mapping(uint256 => uint256) public tokenSupply;
constructor() ERC1155("https://api.example.com/metadata/{id}.json") {}
// Mint a new asset (ERC-1155 token)
    function mintAsset(
        address to,
        string memory _name,
        string memory _description,
        uint256 _value,
        uint256 _amount
    ) public onlyOwner {
        uint256 tokenId = nextTokenId;
        _mint(to, tokenId, _amount, "");
assets[tokenId] = Asset({
            name: _name,
            description: _description,
            value: _value
        });
tokenSupply[tokenId] = _amount;
        nextTokenId++;
    }
// Get asset details
    function getAssetDetails(uint256 tokenId) public view returns (string memory, string memory, uint256) {
        require(exists(tokenId), "Asset does not exist");
        Asset memory asset = assets[tokenId];
        return (asset.name, asset.description, asset.value);
    }
// Check if the asset exists
    function exists(uint256 tokenId) public view returns (bool) {
        return assets[tokenId].value > 0;
    }
}