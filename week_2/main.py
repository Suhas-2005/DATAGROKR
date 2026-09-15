import csv
import os

from bank.account import BankAccount, SavingsAccount
from analysis.analysis import run_analysis


accounts = {}


def display_menu():
    print("\n===== BANKING SYSTEM =====")
    print("1. Create Account")
    print("2. Deposit")
    print("3. Withdraw")
    print("4. Check Balance")
    print("5. View Transaction History")
    print("6. View All Accounts")
    print("7. Run Pandas Analysis")
    print("8. Exit")


def create_account():
    print("\n--- Create Account ---")

    name = input("Enter account holder name: ").strip()

    if not name:
        print("Name cannot be empty.")
        return

    print("1. General Account")
    print("2. Savings Account")

    choice = input("Select account type: ").strip()

    try:
        balance = float(input("Enter initial balance: "))

        if balance < 0:
            print("Balance cannot be negative.")
            return

    except ValueError:
        print("Invalid balance.")
        return

    if choice == "1":
        account = BankAccount(name, balance)

    elif choice == "2":
        try:
            rate = float(input("Enter interest rate (%): ")) / 100

            if rate < 0:
                print("Interest rate cannot be negative.")
                return

            account = SavingsAccount(name, balance, rate)

        except ValueError:
            print("Invalid interest rate.")
            return

    else:
        print("Invalid account type.")
        return

    accounts[account.account_number] = account
    save_account_to_csv(account)

    print("\nAccount created successfully.")
    account.display_account()


def save_account_to_csv(account):
    csv_path = os.path.join(
        os.path.dirname(__file__),
        "data",
        "accounts.csv"
    )

    file_exists = os.path.exists(csv_path)

    try:
        with open(csv_path, "a", newline="", encoding="utf-8") as file:
            fields = [
                "account_number",
                "account_holder",
                "account_type",
                "initial_balance"
            ]

            writer = csv.DictWriter(file, fieldnames=fields)

            if not file_exists or os.path.getsize(csv_path) == 0:
                writer.writeheader()

            writer.writerow(account.to_dict())

    except OSError as e:
        print(f"Could not save account: {e}")


def find_account():
    account_number = input("Enter account number: ").strip().upper()

    account = accounts.get(account_number)

    if account is None:
        print("Account not found.")

    return account


def deposit():
    print("\n--- Deposit ---")

    account = find_account()

    if account is None:
        return

    amount = input("Enter deposit amount: ")
    account.deposit(amount)


def withdraw():
    print("\n--- Withdraw ---")

    account = find_account()

    if account is None:
        return

    amount = input("Enter withdrawal amount: ")
    account.withdraw(amount)


def check_balance():
    print("\n--- Balance ---")

    account = find_account()

    if account is None:
        return

    account.check_balance()


def view_transaction_history():
    print("\n--- Transaction History ---")

    account = find_account()

    if account is None:
        return

    account.display_transaction_history()


def view_all_accounts():
    print("\n--- All Accounts ---")

    if not accounts:
        print("No accounts created.")
        return

    for account in accounts.values():
        account.display_account()


def main():
    while True:
        display_menu()

        choice = input("Enter your choice: ").strip()

        if choice == "1":
            create_account()

        elif choice == "2":
            deposit()

        elif choice == "3":
            withdraw()

        elif choice == "4":
            check_balance()

        elif choice == "5":
            view_transaction_history()

        elif choice == "6":
            view_all_accounts()

        elif choice == "7":
            try:
                run_analysis()
            except (FileNotFoundError, ValueError, KeyError) as e:
                print(f"Analysis error: {e}")

        elif choice == "8":
            print("Thank you for using the Banking System.")
            break

        else:
            print("Invalid choice.")


if __name__ == "__main__":
    main()