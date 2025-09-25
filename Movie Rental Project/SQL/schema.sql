CREATE DATABASE IF NOT EXISTS movierental;
USE movierental;

CREATE TABLE customers (
  customer_id INT UNSIGNED NOT NULL,
  customer_fname VARCHAR(50) NOT NULL,
  customer_lname VARCHAR(50) NOT NULL,
  customer_email VARCHAR(100),
  customer_phone VARCHAR(20),
  
  PRIMARY KEY (customer_id)
);

CREATE TABLE employees (
  employee_id INT UNSIGNED NOT NULL,
  employee_fname VARCHAR(50) NOT NULL,
  employee_lname VARCHAR(50) NOT NULL,
  job_role  VARCHAR(50),
  salary DECIMAL(10,2),
  hire_date DATE,
  employee_email VARCHAR(100),
  employee_phone VARCHAR(20),
  days_since_hire INT,
  
  PRIMARY KEY (employee_id)
);

CREATE TABLE movies (
  movie_id INT UNSIGNED NOT NULL,
  title VARCHAR(150) NOT NULL,
  genre VARCHAR(50),
  release_date DATE,
  rating VARCHAR(10),
  runtime INT,
  
  PRIMARY KEY (movie_id)
);

CREATE TABLE rentals (
  rental_id INT UNSIGNED NOT NULL,
  customer_id INT UNSIGNED,
  employee_id INT UNSIGNED,
  movie_id INT UNSIGNED,
  rental_date DATETIME NOT NULL,
  due_date DATETIME NOT NULL,
  return_date DATETIME,
  rental_fee DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  is_overdue BOOLEAN NOT NULL DEFAULT 0,
  days_overdue INT,
  daily_overdue_fee DECIMAL(6,2),
  total_overdue_fee DECIMAL(8,2) NOT NULL DEFAULT 0.00,

  PRIMARY KEY (rental_id)
);

ALTER TABLE rentals
  ADD CONSTRAINT fk_rentals_customer
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON UPDATE CASCADE ON DELETE SET NULL,
  ADD CONSTRAINT fk_rentals_movie
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
    ON UPDATE CASCADE ON DELETE SET NULL,
  ADD CONSTRAINT fk_rentals_employee
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
    ON UPDATE CASCADE ON DELETE SET NULL;