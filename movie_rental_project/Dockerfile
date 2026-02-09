FROM python:3.11-slim

WORKDIR /app

COPY etl/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY etl/ ./etl

COPY sql/ ./sql
COPY data/ ./data

CMD ["python", "-u", "etl/run_etl.py"]

