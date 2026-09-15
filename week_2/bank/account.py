"""
Account Module
==============
Contains the BankAccount class (parent) and SavingsAccount class (child).
Demonstrates: OOP, __init__, instance methods, inheritance, super(), polymorphism, decorators.
"""

import csv
import os
from bank.transaction import Transaction


# ============================================================
# DECORATOR - Demonstrates the Week 2 decorator concept
# ============================================================
def log_transaction(func):
    """
    A simple decorator that prints a log message before and after
    a transaction method (deposit/withdraw) executes.

    Usage:
        @log_transaction
        def deposit(self, amount):
            ...
    """
    def wrapper(self, *args, **kwargs):
        print(f"\n--- Transaction Started: {func.__name__} ---")
        result = func(self, *args, **kwargs)
        print(f"--- Transaction Complete: {func.__name__} ---\n")
        return result
    return wrapper


class BankAccount:
    """
    Represents a general bank account.

    Attributes:
        account_number (str): Unique account identifier.
        account_holder (str): Name of the account owner.
        balance (float): Current account balance.
        transaction_history (list): List of Transaction objects.
    """

    # Class variable to auto-generate account numbers
    _next_account_number = 1001

    def __init__(self, account_holder, balance=0.0):
        """
        Initialize a BankAccount.

        Parameters:
            account_holder (str): Name of the account holder.
            balance (float): Starting balance (default 0.0).
        """
        self.account_number = f"ACC{BankAccount._next_account_number:04d}"
        BankAccount._next_account_number += 1

        self.account_holder = account_holder
        self.balance = balance
        self.transaction_history = []

    # ----------------------------------------------------------
    # POLYMORPHISM - This method returns different values
    # in BankAccount vs SavingsAccount
    # ----------------------------------------------------------
    def account_type(self):
        """Return the type of this account. Overridden in child classes."""
        return "General Account"

    @log_transaction
    def deposit(self, amount):
        """
        Deposit money into the account.

        Parameters:
            amount (float): Amount to deposit (must be > 0).

        Returns:
            bool: True if deposit was successful, False otherwise.
        """
        try:
            amount = float(amount)
        except (ValueError, TypeError):
            print("Error: Please enter a valid number for the deposit amount.")
            return False

        if amount <= 0:
            print("Error: Deposit amount must be greater than 0.")
            return False

        self.balance += amount

        # Create a Transaction object and add to history
        txn = Transaction(self.account_number, "Deposit", amount, self.balance)
        self.transaction_history.append(txn)

        # Save transaction to CSV (uses context manager inside)
        self._save_transaction_to_csv(txn)

        print(f"Deposited: +{amount:.2f}")
        print(f"New Balance: {self.balance:.2f}")
        return True

    @log_transaction
    def withdraw(self, amount):
        """
        Withdraw money from the account.

        Parameters:
            amount (float): Amount to withdraw (must be > 0 and <= balance).

        Returns:
            bool: True if withdrawal was successful, False otherwise.
        """
        try:
            amount = float(amount)
        except (ValueError, TypeError):
            print("Error: Please enter a valid number for the withdrawal amount.")
            return False

        if amount <= 0:
            print("Error: Withdrawal amount must be greater than 0.")
            return False

        if amount > self.balance:
            print(f"Error: Insufficient balance. Current balance: {self.balance:.2f}")
            return False

        self.balance -= amount

        # Create a Transaction object and add to history
        txn = Transaction(self.account_number, "Withdrawal", amount, self.balance)
        self.transaction_history.append(txn)

        # Save transaction to CSV (uses context manager inside)
        self._save_transaction_to_csv(txn)

        print(f"Withdrawn: -{amount:.2f}")
        print(f"New Balance: {self.balance:.2f}")
        return True

    def check_balance(self):
        """Display the current account balance."""
        print(f"\nAccount: {self.account_number}")
        print(f"Current Balance: {self.balance:.2f}")
        return self.balance

    def display_account(self):
        """Display full account details."""
        print("\n" + "=" * 40)
        print("         ACCOUNT DETAILS")
        print("=" * 40)
        print(f"  Account Number : {self.account_number}")
        print(f"  Account Holder : {self.account_holder}")
        print(f"  Account Type   : {self.account_type()}")
        print(f"  Balance        : {self.balance:.2f}")
        print("=" * 40)

    def display_transaction_history(self):
        """Display all transactions for this account."""
        print(f"\n--- Transaction History for {self.account_number} ---")
        if not self.transaction_history:
            print("No transactions yet.")
        else:
            for txn in self.transaction_history:
                print(txn)
        print("---" + "-" * 45 + "---")

    # ----------------------------------------------------------
    # CONTEXT MANAGER - Used when writing to the CSV file
    # ----------------------------------------------------------
    def _save_transaction_to_csv(self, txn):
        """
        Save a single transaction to the transactions.csv file.
        Uses a context manager (with open) for safe file handling.
        """
        csv_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), "data", "transactions.csv")

        # Check if file exists to decide whether to write headers
        file_exists = os.path.exists(csv_path)

        try:
            # CONTEXT MANAGER: 'with open(...)' ensures the file is
            # properly closed even if an error occurs
            with open(csv_path, mode="a", newline="", encoding="utf-8") as file:
                writer = csv.DictWriter(file, fieldnames=[
                    "transaction_id", "account_number", "transaction_type",
                    "amount", "balance_after", "date"
                ])

                # Write header only if the file is new/empty
                if not file_exists or os.path.getsize(csv_path) == 0:
                    writer.writeheader()

                writer.writerow(txn.to_dict())

        except IOError as e:
            print(f"Warning: Could not save transaction to CSV. Error: {e}")

    def to_dict(self):
        """Convert account info to a dictionary (useful for CSV writing)."""
        return {
            "account_number": self.account_number,
            "account_holder": self.account_holder,
            "account_type": self.account_type(),
            "initial_balance": self.balance
        }


# ============================================================
# INHERITANCE - SavingsAccount inherits from BankAccount
# ============================================================
class SavingsAccount(BankAccount):
    """
    A savings account that earns interest.
    Inherits all functionality from BankAccount and adds interest_rate.

    Demonstrates: Inheritance, super().__init__(), Polymorphism.
    """

    def __init__(self, account_holder, balance=0.0, interest_rate=0.05):
        """
        Initialize a SavingsAccount.

        Uses super().__init__() to call the parent class constructor,
        then adds the interest_rate attribute specific to SavingsAccount.

        Parameters:
            account_holder (str): Name of the account holder.
            balance (float): Starting balance (default 0.0).
            interest_rate (float): Annual interest rate (default 5% = 0.05).
        """
        # super() calls BankAccount.__init__() to set up inherited attributes
        super().__init__(account_holder, balance)
        self.interest_rate = interest_rate

    # ----------------------------------------------------------
    # POLYMORPHISM - Returns a different value than BankAccount
    # ----------------------------------------------------------
    def account_type(self):
        """Return 'Savings Account' (overrides parent method)."""
        return "Savings Account"

    def calculate_interest(self):
        """
        Calculate and display the interest earned on the current balance.

        Returns:
            float: The interest amount.
        """
        interest = self.balance * self.interest_rate
        print(f"\nInterest Rate: {self.interest_rate * 100:.1f}%")
        print(f"Current Balance: {self.balance:.2f}")
        print(f"Interest Earned: {interest:.2f}")
        return interest
