import os
import pandas as pd
import numpy as np


def get_data_path(filename):
    base_dir = os.path.dirname(os.path.dirname(__file__))
    return os.path.join(base_dir, "data", filename)


def run_analysis():
    transactions_path = get_data_path("transactions.csv")
    accounts_path = get_data_path("accounts.csv")

    try:
        transactions = pd.read_csv(transactions_path)
        accounts = pd.read_csv(accounts_path)
    except FileNotFoundError:
        print("CSV file not found.")
        return

    print("\n--- Transactions ---")
    print(transactions.head())

    print("\n--- Accounts ---")
    print(accounts)

    print("\nTotal transaction amount:")
    print(transactions["amount"].sum())

    print("\nAverage transaction amount:")
    print(transactions["amount"].mean())

    print("\nTotal deposits:")
    deposits = transactions[transactions["transaction_type"] == "Deposit"]
    print(deposits["amount"].sum())

    print("\nTotal withdrawals:")
    withdrawals = transactions[
        transactions["transaction_type"] == "Withdrawal"
    ]
    print(withdrawals["amount"].sum())

    print("\nTransaction count by type:")
    print(transactions["transaction_type"].value_counts())

    print("\nTransactions per account:")
    print(transactions.groupby("account_number").size())

    print("\nTotal amount per account:")
    total_per_account = transactions.groupby("account_number")["amount"].sum()
    print(total_per_account)

    print("\nHighest transaction amount:")
    print(transactions["amount"].max())

    print("\nTransactions sorted by amount:")
    print(transactions.sort_values("amount", ascending=False).head())

    merged = pd.merge(
        transactions,
        accounts,
        on="account_number",
        how="left"
    )

    print("\n--- Merged Data ---")
    print(merged.head())

    print("\nTotal amount by account type:")
    print(merged.groupby("account_type")["amount"].sum())

    amounts = np.array(transactions["amount"])

    print("\n--- NumPy Analysis ---")
    print("Mean:", np.mean(amounts))
    print("Maximum:", np.max(amounts))
    print("Minimum:", np.min(amounts))
    print("Total:", np.sum(amounts))


if __name__ == "__main__":
    run_analysis()