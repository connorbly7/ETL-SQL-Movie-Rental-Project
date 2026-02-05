FROM python:3.11-slim

WORKDIR /app

# Install dependencies first for better caching
COPY etl/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy ETL code
COPY etl/ ./etl

# (Optional) copy sql + data if your ETL reads them from the repo
COPY sql/ ./sql
COPY data/ ./data

# Run the ETL
CMD ["python", "-u", "etl/run_etl.py"]
