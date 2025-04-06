// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts@5.2.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@5.2.0/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts@5.2.0/access/Ownable.sol";
import {ERC20Permit} from "@openzeppelin/contracts@5.2.0/token/ERC20/extensions/ERC20Permit.sol";

contract Influent is ERC20, ERC20Burnable, Ownable, ERC20Permit {
    uint256 public constant MAX_SUPPLY = 1_000_000 * 10 ** 18;

    constructor(address initialOwner)
        ERC20("Influent", "INF")
        ERC20Permit("Influent")
        Ownable(initialOwner)
    {}

    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= MAX_SUPPLY, "Max supply exceeded");
        _mint(to, amount);
    }

    function burn(uint256 amount) public override {
        _burn(msg.sender, amount);
    }
}
