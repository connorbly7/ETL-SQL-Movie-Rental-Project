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

Prerequisites
1. Docker Desktop
2. Git

Setup
1.Clone repository
2. Build and run containers

```
docker compose up --build
```
You should see the following printed out:

Extract success
Transform success
Load success

3. Open up a MySQL terminal in the command line to run queries

```
docker exec -it movie_rental_project-db-1 mysql -umovierental_user -pmovierental_pass movierental
```

4. Run sample queries

Ex)

Average spend per customer
```
SELECT ROUND(AVG(total_due), 2) AS avg_total_due_per_customer
FROM (
    SELECT customer_id, 
    SUM(rental_fee * datediff(rentals.return_date, rentals.rental_date) + total_overdue_fee) AS total_due
    FROM rentals
    GROUP BY customer_id
) AS subquery;
```

5. When finished, stop containers

```
docker compose down -v
```


Technologies Used
- Python
- MySQL
- Docker
- pandas
- NumPy
- SQLAlchemy
- mysql-connector-python
