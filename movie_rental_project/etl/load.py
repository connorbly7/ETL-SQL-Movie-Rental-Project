from sqlalchemy import create_engine, MetaData, Table, Column, ForeignKey
from sqlalchemy.dialects.mysql import INTEGER, VARCHAR, DECIMAL, DATE, DATETIME, BOOLEAN
from dotenv import load_dotenv
import os




def load_data(customers_data, employees_data, movies_data, rentals_data):
    """
        Loads the cleaned data into MySQL as the movierental database
        
        Parameters:
            customers: Cleaned customer data
            employees: Cleaned employee data
            movies: Cleaned movie data
            rentals: Cleaned rental data
    """
    
    load_dotenv()
    username = "root"
    host = "localhost"
    port = 3306
    database = "movierental"
    password = os.getenv("PASSWORD")

    engine = create_engine(f"mysql+mysqlconnector://{username}:{password}@{host}:{port}/{database}")


    metadata = MetaData()

    customers = Table(
        "customers", metadata,
        Column("customer_id", INTEGER(unsigned=True), primary_key=True, autoincrement=False),
        Column("customer_fname", VARCHAR(50), nullable=True),
        Column("customer_lname", VARCHAR(50), nullable=True),
        Column("customer_email", VARCHAR(100)),
        Column("customer_phone", VARCHAR(20)),
    )

    employees = Table(
        "employees", metadata,
        Column("employee_id", INTEGER(unsigned=True), primary_key=True, autoincrement=False),
        Column("employee_fname", VARCHAR(50), nullable=True),
        Column("employee_lname", VARCHAR(50), nullable=True),
        Column("job_role", VARCHAR(50)),
        Column("salary", DECIMAL(10, 2)),
        Column("hire_date", DATE),
        Column("employee_email", VARCHAR(100)),
        Column("employee_phone", VARCHAR(20)),
        Column("days_since_hire", INTEGER),
    )

    movies = Table(
        "movies", metadata,
        Column("movie_id", INTEGER(unsigned=True), primary_key=True, autoincrement=False),
        Column("title", VARCHAR(150), nullable=True),
        Column("genre", VARCHAR(50)),
        Column("release_date", DATE),
        Column("rating", VARCHAR(10)),
        Column("runtime", INTEGER),
    )

    rentals = Table(
        "rentals", metadata,
        Column("rental_id", INTEGER(unsigned=True), primary_key=True, autoincrement=False),
        Column("customer_id", INTEGER(unsigned=True), ForeignKey("customers.customer_id", onupdate="CASCADE", ondelete="SET NULL")),
        Column("employee_id", INTEGER(unsigned=True), ForeignKey("employees.employee_id", onupdate="CASCADE", ondelete="SET NULL")),
        Column("movie_id", INTEGER(unsigned=True), ForeignKey("movies.movie_id", onupdate="CASCADE", ondelete="SET NULL")),
        Column("rental_date", DATETIME, nullable=True),
        Column("due_date", DATETIME, nullable=True),
        Column("return_date", DATETIME),
        Column("rental_fee", DECIMAL(8, 2), nullable=True, default=0.00),
        Column("is_overdue", BOOLEAN, nullable=True, default=False),
        Column("days_overdue", INTEGER),
        Column("daily_overdue_fee", DECIMAL(6, 2)),
        Column("total_overdue_fee", DECIMAL(8, 2), nullable=True, default=0.00),
    )

    metadata.drop_all(engine)
    metadata.create_all(engine)

    customers_data.to_sql("customers", con=engine, if_exists="append", index=False)
    employees_data.to_sql("employees", con=engine, if_exists="append", index=False)
    movies_data.to_sql("movies", con=engine, if_exists="append", index=False)
    rentals_data.to_sql("rentals", con=engine, if_exists="append", index=False)
