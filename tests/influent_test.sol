// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

import "remix_tests.sol";
import "remix_accounts.sol";
import "../influent.sol";

contract InfluentTest {
    Influent token;
    address owner;
    address user1;
    address user2;

    uint256 constant initialMint = 500 * 10 ** 18;

    function beforeEach() public {
        owner = address(this);
        user1 = TestsAccounts.getAccount(0);
        user2 = TestsAccounts.getAccount(1);

        token = new Influent(owner); // test contract is owner
        token.mint(user1, initialMint); // mint to user1
    }

    function testInitialBalance() public {
        Assert.equal(token.balanceOf(user1), initialMint, "User1 balance should match initial mint");
    }

    function testMintFromOwner() public {
        uint256 extra = 100 * 10 ** 18;
        token.mint(user2, extra);
        Assert.equal(token.balanceOf(user2), extra, "User2 should have newly minted tokens");
    }

    /// #sender: account-1
    /*function testBurnByUser1() public {
        token.burn(initialMint);
        Assert.equal(token.balanceOf(msg.sender), 0, "User1 balance should be 0 after burn");
    }*/

    function testTotalSupplyCorrect() public {
        Assert.equal(token.totalSupply(), initialMint, "Total supply should equal initial mint");
    }
}