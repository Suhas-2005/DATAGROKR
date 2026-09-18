import pandas as pd


def transform_data(data):
    df = pd.DataFrame(data)

    df = df[["id", "title", "body"]]

    df = df.dropna()

    return df


def save_data(df, filename="data/output.csv"):
    df.to_csv(filename, index=False)
    print("Data saved successfully.")