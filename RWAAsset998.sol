// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
interface IERC998 {
    function addChild(address _child) external;
    function removeChild(address _child) external;
}
contract RWAAsset998 is ERC721, Ownable, IERC998 {
    uint256 public nextTokenId;
mapping(uint256 => address[]) public ownedChildren;
constructor() ERC721("RWAAsset998", "RWA998") {}
function mintAsset(address to) public onlyOwner {
        uint256 tokenId = nextTokenId;
        _safeMint(to, tokenId);
        nextTokenId++;
    }
// Add child NFT or ERC-20 token
    function addChild(address _child) public onlyOwner {
        ownedChildren[0].push(_child);
    }
// Remove child NFT or ERC-20 token
    function removeChild(address _child) public onlyOwner {
        for (uint256 i = 0; i < ownedChildren[0].length; i++) {
            if (ownedChildren[0][i] == _child) {
                ownedChildren[0][i] = ownedChildren[0][ownedChildren[0].length - 1];
                ownedChildren[0].pop();
                break;
            }
        }
    }
// Get child details (in this case, ERC-721 tokens)
    function getChildren(uint256 tokenId) public view returns (address[] memory) {
        return ownedChildren[tokenId];
    }
}