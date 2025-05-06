import csv

with open("raw_sales_data.csv", "r") as infile, open("staging_sales_data.csv", "w", newline="") as outfile:
    reader = csv.DictReader(infile)
    fieldnames = ["customer_id", "product_id", "date", "quantity", "price"]
    writer = csv.DictWriter(outfile, fieldnames=fieldnames)
    writer.writeheader()

    for row in reader:
        try:
            if row["customer_id"] == "" or int(row["customer_id"]) <= 0:
                continue
            if row["product_id"] == "" or int(row["product_id"]) <= 0:
                continue
            if row["date"] == "":
                continue
            if row["quantity"] == "" or int(row["quantity"]) <= 0:
                continue

            price = float(row["price"])
            if price <= 0:
                continue

            writer.writerow({
                "customer_id": row["customer_id"],
                "product_id": row["product_id"],
                "date": row["date"],
                "quantity": row["quantity"],
                "price": f"{price:.2f}"
            })

        except Exception:
            continue

