FROM ubuntu:20.04

# set locale to avoid issues with interactive installations
# https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
# RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

ARG DEBIAN_FRONTEND=noninteractiv

# install required system-level packages
RUN apt-get update && apt-get install -y \
            openjdk-11-jdk \
            build-essential \
            libsasl2-dev \
            jq \
            wget \
            python3 \
            python3-dev \
            python3-pip \
            python3-wheel

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# install Python libraries
COPY requirements.txt /
RUN pip3 install --no-cache -r requirements.txt

# set up Iceberg Java libraries and other jars for Spark
ARG MAVEN_REPO=https://repo1.maven.org/maven2
ARG ICEBERG_VERSION=1.2.0
ARG SPARK_VERSION=3.3_2.12
ARG CAFFEINE_VERSION=3.1.5
ARG PARQUET_AVRO_VERSION=1.12.3

RUN wget ${MAVEN_REPO}/org/apache/iceberg/iceberg-spark-runtime-${SPARK_VERSION}/${ICEBERG_VERSION}/iceberg-spark-runtime-${SPARK_VERSION}-${ICEBERG_VERSION}.jar
RUN wget ${MAVEN_REPO}/org/apache/iceberg/iceberg-spark-extensions-${SPARK_VERSION}/${ICEBERG_VERSION}/iceberg-spark-extensions-${SPARK_VERSION}-${ICEBERG_VERSION}.jar
RUN wget ${MAVEN_REPO}/com/github/ben-manes/caffeine/caffeine/${CAFFEINE_VERSION}/caffeine-${CAFFEINE_VERSION}.jar
RUN wget ${MAVEN_REPO}/org/apache/parquet/parquet-avro/${PARQUET_AVRO_VERSION}/parquet-avro-${PARQUET_AVRO_VERSION}.jar

RUN mv *.jar /usr/local/lib/python3.8/dist-packages/pyspark/jars

# install avro tools
ARG AVRO_VERSION=1.11.1
RUN wget https://repo1.maven.org/maven2/org/apache/avro/avro-tools/${AVRO_VERSION}/avro-tools-${AVRO_VERSION}.jar
RUN mv avro-tools-$AVRO_VERSION.jar avro.jar && mv avro* /usr/bin/

CMD ["jupyter", "notebook", "--allow-root", "--ip", "0.0.0.0", "--no-browser", "--NotebookApp.token=''", "--NotebookApp.password=''"]
