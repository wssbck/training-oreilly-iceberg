FROM python:3.12-slim

ARG MAVEN_REPO=https://repo1.maven.org/maven2

ARG ICEBERG_VERSION=1.7.1
ARG ICEBERG_SPARK_RUNTIME_VERSION=3.5_2.12
ARG CAFFEINE_VERSION=3.2.0
ARG PARQUET_AVRO_VERSION=1.15.0
ARG AVRO_VERSION=1.12.0

ARG SPARK_HOME=/usr/local/lib/python3.12/site-packages/pyspark
ENV SPARK_HOME=${SPARK_HOME}

# set language and time zone
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# install required system-level packages and Python dependencies
COPY requirements.txt /
RUN apt -y update && \
    apt -y install jq openjdk-17-jre wget && \
    pip3 install -r requirements.txt && \
    rm requirements.txt

# set up Iceberg Java libraries and other jars for Spark
RUN wget ${MAVEN_REPO}/org/apache/iceberg/iceberg-spark-runtime-${ICEBERG_SPARK_RUNTIME_VERSION}/${ICEBERG_VERSION}/iceberg-spark-runtime-${ICEBERG_SPARK_RUNTIME_VERSION}-${ICEBERG_VERSION}.jar && \
    wget ${MAVEN_REPO}/org/apache/iceberg/iceberg-spark-extensions-${ICEBERG_SPARK_RUNTIME_VERSION}/${ICEBERG_VERSION}/iceberg-spark-extensions-${ICEBERG_SPARK_RUNTIME_VERSION}-${ICEBERG_VERSION}.jar && \
    wget ${MAVEN_REPO}/com/github/ben-manes/caffeine/caffeine/${CAFFEINE_VERSION}/caffeine-${CAFFEINE_VERSION}.jar && \
    wget ${MAVEN_REPO}/org/apache/parquet/parquet-avro/${PARQUET_AVRO_VERSION}/parquet-avro-${PARQUET_AVRO_VERSION}.jar && \
    mkdir ${SPARK_HOME}/conf && \
    mv *.jar ${SPARK_HOME}/jars

# configure Spark logging
COPY log4j2.properties ${SPARK_HOME}/conf

# install AVRO Tools
RUN wget ${MAVEN_REPO}/org/apache/avro/avro-tools/${AVRO_VERSION}/avro-tools-${AVRO_VERSION}.jar && \
    mv avro-tools-$AVRO_VERSION.jar avro.jar && mv avro* /usr/bin/

CMD ["jupyter", "notebook", "--allow-root", "--ip", "0.0.0.0", "--no-browser", "--NotebookApp.token=''", "--NotebookApp.password=''"]
