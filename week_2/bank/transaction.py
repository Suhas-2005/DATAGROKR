from datetime import datetime


class Transaction:
    _next_id = 1

    def __init__(self, account_number, transaction_type, amount, balance_after):
        self.transaction_id = f"TXN{Transaction._next_id:04d}"
        Transaction._next_id += 1

        self.account_number = account_number
        self.transaction_type = transaction_type
        self.amount = amount
        self.balance_after = balance_after
        self.date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    def __str__(self):
        sign = "+" if self.transaction_type == "Deposit" else "-"

        return (
            f"[{self.transaction_id}] "
            f"{self.date} | "
            f"{self.transaction_type}: {sign}{self.amount:.2f} | "
            f"Balance: {self.balance_after:.2f}"
        )

    def to_dict(self):
        return {
            "transaction_id": self.transaction_id,
            "account_number": self.account_number,
            "transaction_type": self.transaction_type,
            "amount": self.amount,
            "balance_after": self.balance_after,
            "date": self.date
        }