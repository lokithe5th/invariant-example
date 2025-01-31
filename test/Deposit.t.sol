// SPDX-License-Identifier: UNLICENSED
// https://www.rareskills.io/post/invariant-testing-solidity
pragma solidity ^0.8.13;
import "forge-std/Test.sol";
import "../src/Deposit.sol";

contract InvariantDeposit is Test {
    Deposit deposit;

    function setUp() external {
        vm.createSelectFork(API_KEY);
        deposit = new Deposit();
        vm.deal(address(deposit), 100 ether);
    }

     function invariant_alwaysWithdrawable() external payable {
        deposit.deposit{value: 1 ether}();
        uint256 balanceBefore = deposit.balance(address(this));
        assertEq(balanceBefore, 1 ether);
        deposit.withdraw();
        uint256 balanceAfter = deposit.balance(address(this));
        assertGt(balanceBefore, balanceAfter);
    }

     function invariant_alwaysWithdrawable2() external payable {
        deposit.deposit{value: 1 ether}();
        uint256 balanceBefore = deposit.balance(address(this));
        assertEq(balanceBefore, 1 ether);
        deposit.withdraw();
        uint256 balanceAfter = deposit.balance(address(this));
        assertGt(balanceBefore, balanceAfter);
    }

    receive() external payable {}
}
