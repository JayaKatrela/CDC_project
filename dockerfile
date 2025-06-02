# Use an official Spark image or build your own
FROM bitnami/spark:3.4.1

USER root

# Install Python packages
RUN pip install pyspark boto3 psycopg2-binary

# Add your job script
COPY cdc.py /app/cdc.py

# Set environment variables for AWS (or override in Jenkins)
ENV AWS_ACCESS_KEY_ID=your-access-key
ENV AWS_SECRET_ACCESS_KEY=your-secret-key

WORKDIR /app

CMD ["spark-submit", "--packages", "org.postgresql:postgresql:42.5.0,org.apache.hadoop:hadoop-aws:3.2.0", "cdc.py"]
