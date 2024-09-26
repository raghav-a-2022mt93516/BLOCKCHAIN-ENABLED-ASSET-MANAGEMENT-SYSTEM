// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RWAToken is ERC20, Ownable {
    uint256 public assetId; // The corresponding ERC-721 asset ID

    constructor(string memory name, string memory symbol, uint256 _assetId) ERC20(name, symbol) {
        assetId = _assetId;
    }

    // Mint new tokens representing fractional ownership of the asset
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
