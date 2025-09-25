# ETL-SQL-Movie-Rental-Project


Overview:
- This project demonstrates a complete ETL pipeline in Python that loads movie rental data into a MySQL database (movierental schema)
  and then analyzes it using SQL queries.
- This project showcases data engineering, database design, and how to use SQL for analytics to find business insights

Data
- Source: Created data myself based on a movie rental store.
- Employees: Includes information relating to employees of the store, such as first and last names and job role
- Customers: Information relating to customers of the store, such as first and last name
- Movies: Information about movies that the rental store is renting out, including the  name, rating, and genre
- Rentals: Data about each rental the store conducts, including the employee, customer, movie, as
  well as any costs and dates related to the rental.
- Each dataset has an id column which acts as the unique identifier (primary key in SQL) for each row of data

ETL
- Used Python in conjunction with NumPy, pandas, and SQLAlchemy to extract data from a csv file, transform and clean it, and load it into MySQL
- During transformation, added additional columns to the data such as total_overdue_cost to improve datasets
- Used a .env file to hide sensitive information

Analysis
- Used SQL to query the data for business insights
- Example query:
Compute average spend per customer:
```
SELECT ROUND(AVG(total_due), 2) AS avg_total_due_per_customer
FROM (
    SELECT customer_id, 
    SUM(rental_fee * datediff(rentals.return_date, rentals.rental_date) + total_overdue_fee) AS total_due
    FROM rentals
    GROUP BY customer_id
) AS subquery;
```

Setup
  1. Clone repository and move it into workspace.
  2. In a Python terminal, create and activate a virtual environment to run the ETL with required packages using the following commands:
```
     python -m venv .venv
     .venv\Scripts\Activate
```
  4. Run the following command to download the required packages:
```
     pip install -r requirements.txt
```
  6. In MySQL, run the following command found at the top of the queries file to setup the movierentals database:
```
     CREATE DATABASE IF NOT EXISTS movierental;
```
  8. Run run_etl.py in the etl folder to run the ETL pipeline.
  9. Make sure movierentals is the active schema in MySQL.
  10. When you are finished, enter deactivate in the Python terminal to deactivate virtual environment.

Technologies Used
- Python
- MySQL
- pandas
- NumPy
- SQLAlchemy
- mysql-connector-python
- dotenv
