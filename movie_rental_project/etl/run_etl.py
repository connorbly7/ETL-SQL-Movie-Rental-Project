from extract import extract_data
from transform import transform_data
from load import load_data


# Extract data
customers_data, employees_data, movies_data, rentals_data = extract_data()
print("Extract success\n")
# Transform data
customers_data, employees_data, movies_data, rentals_data = transform_data(customers_data, employees_data, movies_data, rentals_data)
print("Transform success\n")
# Load data
load_data(customers_data, employees_data, movies_data, rentals_data)
print("Load success\n")