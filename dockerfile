FROM bitnami/spark:3.4.1

USER root

RUN pip install pyspark boto3 psycopg2-binary

COPY cdc.py /app/cdc.py

# Receive AWS credentials from Jenkins
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

WORKDIR /app

CMD ["spark-submit", "--packages", "org.postgresql:postgresql:42.5.0,org.apache.hadoop:hadoop-aws:3.2.0", "cdc.py"]
