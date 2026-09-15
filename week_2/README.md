# OOP Banking System with Transaction History and Pandas Analysis

A Python-based banking system that demonstrates Object-Oriented Programming, file handling, and data analysis using pandas and NumPy. Built as a Week 2 learning project.

---

## Features

- **Create Bank Accounts** – General Account and Savings Account
- **Deposit & Withdraw** – With full input validation
- **Transaction History** – Every transaction is recorded with ID, type, amount, balance, and timestamp
- **CSV Storage** – Transactions and accounts are saved to CSV files
- **Pandas Analysis** – 15 different analyses on banking data (groupby, merge, sort, etc.)
- **NumPy Calculations** – Mean, max, min, sum, std deviation on transaction amounts

---

## Week 2 Concepts Demonstrated

| Concept              | Where It's Used                                      |
|----------------------|------------------------------------------------------|
| OOP / Classes        | `BankAccount`, `SavingsAccount`, `Transaction`       |
| `__init__()`         | Every class constructor                              |
| Objects              | Creating account and transaction instances            |
| Instance Methods     | `deposit()`, `withdraw()`, `check_balance()`, etc.   |
| Inheritance          | `SavingsAccount` inherits from `BankAccount`         |
| `super()`            | `SavingsAccount.__init__()` calls parent constructor |
| Polymorphism         | `account_type()` returns different values per class  |
| Decorator            | `@log_transaction` wraps deposit/withdraw methods    |
| Context Manager      | `with open(...)` used for all CSV file operations    |
| pandas               | `analysis.py` – read_csv, groupby, merge, etc.       |
| NumPy                | `analysis.py` – np.array, np.mean, np.max, np.min   |
| Modules & Packages   | `bank/` package, `analysis/` module, imports         |
| Exception Handling   | try/except throughout for invalid input, missing files|
| Clean Code           | Small functions, meaningful names, comments          |

---

## Project Structure

```
week_2/
│
├── main.py                  # Entry point - menu-driven CLI
│
├── bank/                    # Banking package
│   ├── __init__.py          # Package init - exports classes
│   ├── account.py           # BankAccount & SavingsAccount classes
│   └── transaction.py       # Transaction class
│
├── data/                    # CSV data files
│   ├── transactions.csv     # Transaction records
│   └── accounts.csv         # Account information
│
├── analysis/                # Data analysis module
│   └── analysis.py          # Pandas & NumPy analysis
│
├── requirements.txt         # External dependencies
└── README.md                # This file
```

---

## Technologies Used

- **Python 3** – Core programming language
- **pandas** – Data analysis and manipulation
- **NumPy** – Numerical computations
- **csv** – Built-in CSV file handling
- **datetime** – Transaction timestamps
- **os** – File path management

---

## Setup Instructions

### 1. Create a Virtual Environment

```bash
python -m venv venv
```

### 2. Activate the Virtual Environment

**Windows PowerShell:**
```powershell
venv\Scripts\Activate.ps1
```

**Windows CMD:**
```cmd
venv\Scripts\activate.bat
```

**macOS/Linux:**
```bash
source venv/bin/activate
```

### 3. Install Requirements

```bash
pip install -r requirements.txt
```

---

## How to Run

From the `week_2/` directory:

```bash
python main.py
```

---

## Example Usage

### Main Menu

```
========================================
         BANKING SYSTEM
========================================
  1. Create Account
  2. Deposit
  3. Withdraw
  4. Check Balance
  5. View Transaction History
  6. View All Accounts
  7. Run Pandas Analysis
  8. Exit
========================================
Enter your choice (1-8):
```

### Creating an Account

```
--- Create New Account ---
Enter account holder name: John Doe

Account Types:
  1. General Account
  2. Savings Account
Select account type (1 or 2): 2
Enter initial balance: 5000
Enter annual interest rate (e.g., 5 for 5%): 5

Account created successfully!

========================================
         ACCOUNT DETAILS
========================================
  Account Number : ACC1011
  Account Holder : John Doe
  Account Type   : Savings Account
  Balance        : 5000.00
========================================
```

### Making a Deposit

```
--- Deposit ---
Enter account number: ACC1011
Enter deposit amount: 500

--- Transaction Started: deposit ---
Deposited: +500.00
New Balance: 5500.00
--- Transaction Complete: deposit ---
```

### Pandas Analysis (Sample Output)

```
[4] Total Transaction Amount: 94000.00
[5] Average Transaction Amount: 3760.00
[6] Total Deposits: 73000.00
[7] Total Withdrawals: 21000.00

[8] Transaction Count by Type:
Deposit       15
Withdrawal    10

[11] Account with Highest Total: ACC1002 (15500.00)

          NUMPY ANALYSIS
  np.mean()  → Mean Amount:    3760.00
  np.max()   → Max Amount:     15000.00
  np.min()   → Min Amount:     500.00
```

---

## Class Diagram

```
BankAccount (Parent)
├── account_number
├── account_holder
├── balance
├── transaction_history
├── deposit()          ← @log_transaction decorator
├── withdraw()         ← @log_transaction decorator
├── check_balance()
├── display_account()
├── display_transaction_history()
└── account_type() → "General Account"
        │
        │ inherits (super().__init__())
        ▼
SavingsAccount (Child)
├── interest_rate      ← additional attribute
├── calculate_interest()
└── account_type() → "Savings Account"  ← polymorphism

Transaction
├── transaction_id
├── account_number
├── transaction_type
├── amount
├── balance_after
└── date
```

---

## License

This project is for educational purposes only.
