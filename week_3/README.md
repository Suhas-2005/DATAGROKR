# Week 3 - ETL Data Pipeline

A simple Python ETL pipeline that fetches data from a REST API, processes it using pandas, and saves the result into a CSV file.

## Project Flow

API → JSON → pandas DataFrame → Transform → CSV

## Features

- Fetches data from a REST API using `requests`
- Converts JSON data into a pandas DataFrame
- Selects required columns
- Removes missing values
- Saves processed data into a CSV file

## Project Structure

week_3/
│
├── main.py
├── api.py
├── etl.py
├── data/
│   └── output.csv
├── requirements.txt
└── README.md

## Technologies Used

- Python
- Requests
- pandas
- REST API
- CSV

## Files

### api.py

Contains the function used to fetch data from the REST API.

### etl.py

Contains functions for transforming the data using pandas and saving it to CSV.

### main.py

Runs the complete ETL pipeline.

### data/output.csv

Stores the processed data obtained from the API.

## How to Run

### 1. Install dependencies

```bash
pip install -r requirements.txt