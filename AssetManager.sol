// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./RWAAsset.sol";
import "./RWAToken.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AssetManager is Ownable {
    RWAAsset public rwaAssetContract;
    mapping(uint256 => address) public tokenContracts; // Mapping of ERC-721 asset ID to its ERC-20 contract

    event AssetTokenized(uint256 indexed assetId, address tokenContract);

    constructor(address _rwaAssetContract) {
        rwaAssetContract = RWAAsset(_rwaAssetContract);
    }

    // Tokenize an existing ERC-721 asset by creating an ERC-20 contract
    function tokenizeAsset(uint256 assetId, string memory tokenName, string memory tokenSymbol, uint256 tokenSupply) public onlyOwner {
        require(rwaAssetContract.ownerOf(assetId) == msg.sender, "Not the asset owner");

        // Deploy a new RWAToken contract
        RWAToken newToken = new RWAToken(tokenName, tokenSymbol, assetId);
        newToken.mint(msg.sender, tokenSupply * (10 ** newToken.decimals()));

        tokenContracts[assetId] = address(newToken);

        emit AssetTokenized(assetId, address(newToken));
    }

    // Get details of the ERC-721 asset and its ERC-20 token
    function getAssetAndTokenDetails(uint256 assetId) public view returns (string memory assetName, string memory assetDescription, uint256 assetValue, address tokenContract) {
        (assetName, assetDescription, assetValue) = rwaAssetContract.getAssetDetails(assetId);
        tokenContract = tokenContracts[assetId];
    }
}
