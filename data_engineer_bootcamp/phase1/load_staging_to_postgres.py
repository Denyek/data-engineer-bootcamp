import csv
import psycopg2

# Connect to PostgreSQL
conn = psycopg2.connect(
    dbname="salesdb",
    user="dataeng",
    password="pipeline123",
    host="localhost"
)

cur = conn.cursor()

# Open and read staging CSV
with open("staging_sales_data.csv", "r") as file:
    reader = csv.DictReader(file)
    for row in reader:
        cur.execute("""
            INSERT INTO staging_sales (customer_id, product_id, date, quantity, price)
            VALUES (%s, %s, %s, %s, %s)
        """, (
            int(row["customer_id"]),
            int(row["product_id"]),
            row["date"],
            int(row["quantity"]),
            float(row["price"])
        ))

conn.commit()
cur.close()
conn.close()

