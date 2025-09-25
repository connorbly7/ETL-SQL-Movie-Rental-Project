use movierental;

-- 1. List all customers
select * from customers;

-- 2. List all employees
select * from employees;

-- 3. List all movies
select * from movies;

-- 4. List all rentals
select * from rentals;

-- Rental amounts per customer with highest going first
SELECT rentals.customer_id,
round(SUM(rentals.rental_fee), 2) AS total_rental_amount
FROM rentals
GROUP BY rentals.customer_id
ORDER BY total_rental_amount DESC;

-- 6.	Top 5 employees with the most rentals
select employees.employee_fname,
employees.employee_lname,
count(rentals.rental_id) AS "rental_count"
from employees
INNER JOIN rentals ON employees.employee_id = rentals.employee_id
GROUP BY employees.employee_fname, employees.employee_lname
order by rental_count DESC limit 5;

-- Total revenue, total rentals, and average rental length
SELECT COUNT(rentals.rental_id) AS total_rentals,
SUM((rentals.rental_fee * datediff(rentals.return_date, rentals.rental_date)) + rentals.total_overdue_fee) AS total_revenue,
ROUND(AVG(datediff(rentals.return_date, rentals.rental_date)), 2) AS avg_rental_length
FROM rentals;


-- 7. Average spend per customer
SELECT ROUND(AVG(total_due), 2) AS avg_total_due_per_customer
FROM (
    SELECT customer_id, 
    SUM(rental_fee * datediff(rentals.return_date, rentals.rental_date) + total_overdue_fee) AS total_due
    FROM rentals
    GROUP BY customer_id
) AS subquery;

-- 8. Every movie and the number of times they've been rented
SELECT movies.movie_id,
movies.title,
COUNT(rentals.rental_id) AS times_rented
FROM movies
LEFT JOIN rentals ON movies.movie_id = rentals.movie_id
GROUP BY movies.movie_id, movies.title
ORDER BY times_rented DESC;