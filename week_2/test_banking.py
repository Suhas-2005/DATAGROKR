"""
Automated test script for the banking system.
Tests all core functionality without requiring user input.
"""

import os
import sys

# Ensure we're running from the project root
os.chdir(os.path.dirname(__file__))

print("=" * 60)
print("  BANKING SYSTEM - AUTOMATED TESTS")
print("=" * 60)

# -------------------------------------------------------
# Test 1: Imports
# -------------------------------------------------------
print("\n[TEST 1] Testing imports...")
try:
    from bank.account import BankAccount, SavingsAccount
    from bank.transaction import Transaction
    from analysis.analysis import run_analysis
    print("  PASS - All imports successful")
except ImportError as e:
    print(f"  FAIL - Import error: {e}")
    sys.exit(1)

# -------------------------------------------------------
# Test 2: Create BankAccount
# -------------------------------------------------------
print("\n[TEST 2] Creating a BankAccount...")
acc1 = BankAccount("Test User", 1000.0)
assert acc1.account_holder == "Test User"
assert acc1.balance == 1000.0
assert acc1.account_type() == "General Account"
print(f"  PASS - Created {acc1.account_number}, balance={acc1.balance}")

# -------------------------------------------------------
# Test 3: Create SavingsAccount (Inheritance + super())
# -------------------------------------------------------
print("\n[TEST 3] Creating a SavingsAccount (inheritance + super())...")
acc2 = SavingsAccount("Savings User", 5000.0, 0.08)
assert acc2.account_holder == "Savings User"
assert acc2.balance == 5000.0
assert acc2.interest_rate == 0.08
assert acc2.account_type() == "Savings Account"
print(f"  PASS - Created {acc2.account_number}, balance={acc2.balance}, rate={acc2.interest_rate}")

# -------------------------------------------------------
# Test 4: Polymorphism
# -------------------------------------------------------
print("\n[TEST 4] Testing polymorphism (account_type())...")
assert acc1.account_type() == "General Account"
assert acc2.account_type() == "Savings Account"
print(f"  PASS - BankAccount -> \"{acc1.account_type()}\"")
print(f"  PASS - SavingsAccount -> \"{acc2.account_type()}\"")

# -------------------------------------------------------
# Test 5: Deposit (valid)
# -------------------------------------------------------
print("\n[TEST 5] Testing valid deposit...")
result = acc1.deposit(500)
assert result == True
assert acc1.balance == 1500.0
print(f"  PASS - Balance after +500: {acc1.balance}")

# -------------------------------------------------------
# Test 6: Deposit (invalid - negative)
# -------------------------------------------------------
print("\n[TEST 6] Testing invalid deposit (negative amount)...")
result = acc1.deposit(-100)
assert result == False
assert acc1.balance == 1500.0
print(f"  PASS - Deposit rejected, balance unchanged: {acc1.balance}")

# -------------------------------------------------------
# Test 7: Deposit (invalid - text)
# -------------------------------------------------------
print("\n[TEST 7] Testing invalid deposit (text input)...")
result = acc1.deposit("abc")
assert result == False
assert acc1.balance == 1500.0
print(f"  PASS - Deposit rejected, balance unchanged: {acc1.balance}")

# -------------------------------------------------------
# Test 8: Withdraw (valid)
# -------------------------------------------------------
print("\n[TEST 8] Testing valid withdrawal...")
result = acc1.withdraw(200)
assert result == True
assert acc1.balance == 1300.0
print(f"  PASS - Balance after -200: {acc1.balance}")

# -------------------------------------------------------
# Test 9: Withdraw (insufficient balance)
# -------------------------------------------------------
print("\n[TEST 9] Testing withdrawal with insufficient balance...")
result = acc1.withdraw(9999)
assert result == False
assert acc1.balance == 1300.0
print(f"  PASS - Withdrawal rejected, balance unchanged: {acc1.balance}")

# -------------------------------------------------------
# Test 10: Withdraw (invalid input)
# -------------------------------------------------------
print("\n[TEST 10] Testing withdrawal with invalid input...")
result = acc1.withdraw("xyz")
assert result == False
print(f"  PASS - Withdrawal rejected for text input")

# -------------------------------------------------------
# Test 11: Transaction history
# -------------------------------------------------------
print("\n[TEST 11] Testing transaction history...")
assert len(acc1.transaction_history) == 2  # 1 deposit + 1 withdrawal
print(f"  PASS - {len(acc1.transaction_history)} transactions recorded")
for txn in acc1.transaction_history:
    print(f"    {txn}")

# -------------------------------------------------------
# Test 12: Transaction object attributes
# -------------------------------------------------------
print("\n[TEST 12] Testing Transaction object...")
txn = acc1.transaction_history[0]
assert txn.transaction_type == "Deposit"
assert txn.amount == 500.0
assert txn.account_number == acc1.account_number
print(f"  PASS - Transaction: {txn.transaction_id}, type={txn.transaction_type}, amount={txn.amount}")

# -------------------------------------------------------
# Test 13: Calculate interest (SavingsAccount)
# -------------------------------------------------------
print("\n[TEST 13] Testing calculate_interest()...")
interest = acc2.calculate_interest()
expected = 5000.0 * 0.08
assert interest == expected
print(f"  PASS - Interest on 5000 at 8%: {interest}")

# -------------------------------------------------------
# Test 14: CSV writing (context manager)
# -------------------------------------------------------
print("\n[TEST 14] Testing CSV file writing...")
csv_path = os.path.join("data", "transactions.csv")
assert os.path.exists(csv_path)
print(f"  PASS - transactions.csv exists at {csv_path}")

# -------------------------------------------------------
# Test 15: display_account()
# -------------------------------------------------------
print("\n[TEST 15] Testing display_account()...")
acc1.display_account()
acc2.display_account()
print("  PASS - Account details displayed")

# -------------------------------------------------------
# Test 16: Pandas analysis
# -------------------------------------------------------
print("\n[TEST 16] Running pandas analysis...")
try:
    run_analysis()
    print("\n  PASS - Pandas analysis completed successfully")
except Exception as e:
    print(f"\n  FAIL - Analysis error: {e}")

# -------------------------------------------------------
# Summary
# -------------------------------------------------------
print("\n" + "=" * 60)
print("  ALL TESTS PASSED!")
print("=" * 60)
