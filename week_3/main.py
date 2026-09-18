from api import fetch_data
from etl import transform_data, save_data


url = "https://jsonplaceholder.typicode.com/posts"

data = fetch_data(url)

if data:
    df = transform_data(data)
    save_data(df)
    print(df.head())
else:
    print("No data received.")