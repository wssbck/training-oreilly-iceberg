FROM ubuntu:20.04

# set locale to avoid issues with interactive installations
# https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

# install required system-level packages
RUN apt-get update && apt-get install -y \
            openjdk-11-jdk \
            build-essential \
            libsasl2-dev \
            git \
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
ARG ICEBERG_VERSION=1.1.0
ARG ICEBERG_MAVEN_REPO=https://repo1.maven.org/maven2/org/apache/iceberg
#RUN wget $ICEBERG_MAVEN_REPO/iceberg-core/$ICEBERG_VERSION/iceberg-core-$ICEBERG_VERSION.jar \
#         $ICEBERG_MAVEN_REPO/iceberg-common/$ICEBERG_VERSION/iceberg-common-$ICEBERG_VERSION.jar \
#         $ICEBERG_MAVEN_REPO/iceberg-api/$ICEBERG_VERSION/iceberg-api-$ICEBERG_VERSION.jar \
         # $ICEBERG_MAVEN_REPO/iceberg-parquet/$ICEBERG_VERSION/iceberg-parquet-$ICEBERG_VERSION.jar \
RUN wget $ICEBERG_MAVEN_REPO/iceberg-spark-runtime-3.2_2.13/$ICEBERG_VERSION/iceberg-spark-runtime-3.2_2.13-$ICEBERG_VERSION.jar

ARG CAFFEINE_VERSION=3.1.2
RUN wget https://repo1.maven.org/maven2/com/github/ben-manes/caffeine/caffeine/$CAFFEINE_VERSION/caffeine-$CAFFEINE_VERSION.jar

ARG PARQUET_AVRO_VERSION=1.12.3
RUN wget https://repo1.maven.org/maven2/org/apache/parquet/parquet-avro/$PARQUET_AVRO_VERSION/parquet-avro-$PARQUET_AVRO_VERSION.jar

# RUN mkdir /jars
RUN mv *.jar /usr/local/lib/python3.8/dist-packages/pyspark/jars
# ENV CLASSPATH=/jars:/usr/local/lib/python3.8/dist-packages/pyspark/jars

# install Python Iceberg
#RUN git clone https://github.com/apache/iceberg.git
#RUN rm -rf ./iceberg/python && mv ./iceberg/python_legacy ./iceberg/python
#RUN pip3 install -e ./iceberg/python

# enable Scala in Jupyter
# RUN python3 -m spylon_kernel install

# install avro tools
ARG AVRO_VERSION=1.11.1
COPY avro /
RUN chmod +x avro
RUN wget https://dlcdn.apache.org/avro/avro-$AVRO_VERSION/java/avro-tools-$AVRO_VERSION.jar
RUN mv avro-tools-$AVRO_VERSION.jar avro.jar && mv avro* /usr/bin/

CMD ["jupyter", "notebook", "--allow-root", "--ip", "0.0.0.0", "--no-browser", "--NotebookApp.token=''", "--NotebookApp.password=''"]
