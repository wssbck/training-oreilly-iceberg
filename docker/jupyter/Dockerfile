FROM alpine:3.14

# install required system-level packages
RUN apk add --no-cache \
            openjdk8 \
            build-base \
            cyrus-sasl-dev \
            libffi-dev \
            git \
            jq \
            python3 \
            python3-dev \
            py3-pip \
            py3-wheel

# install Python libraries
RUN pip3 install --no-cache \
                notebook==6.4.5 \
                spylon-kernel==0.4.1 \
                pyhive[hive]==0.6.4 \
                pyhive[trino]==0.6.4 \
                pyspark==3.2.0

# set up Iceberg Java libraries
ARG MAVEN_REPO=https://repo1.maven.org/maven2/org/apache/iceberg
ARG ICEBERG_VERSION=0.12.0
RUN wget $MAVEN_REPO/iceberg-core/$ICEBERG_VERSION/iceberg-core-$ICEBERG_VERSION.jar \
         $MAVEN_REPO/iceberg-common/$ICEBERG_VERSION/iceberg-common-$ICEBERG_VERSION.jar \
         $MAVEN_REPO/iceberg-api/$ICEBERG_VERSION/iceberg-api-$ICEBERG_VERSION.jar \
         $MAVEN_REPO/iceberg-parquet/$ICEBERG_VERSION/iceberg-parquet-$ICEBERG_VERSION.jar \
         $MAVEN_REPO/iceberg-spark3-runtime/$ICEBERG_VERSION/iceberg-spark3-runtime-$ICEBERG_VERSION.jar
RUN mkdir /jars
RUN mv iceberg*.jar /jars/
ENV CLASSPATH=/jars


# install Python Iceberg
RUN git clone https://github.com/apache/iceberg.git
RUN pip3 install -e ./iceberg/python
RUN rm -rf /iceberg/

# install avro tools
ARG AVRO_VERSION=1.11.0
COPY avro /
RUN chmod +x avro
RUN wget https://dlcdn.apache.org/avro/avro-$AVRO_VERSION/java/avro-tools-$AVRO_VERSION.jar
RUN mv avro-tools-$AVRO_VERSION.jar avro.jar && mv avro* /usr/bin/

# enable Scala in Jupyter
RUN python3 -m spylon_kernel install

# prepare environment for training
RUN mkdir _oreilly_iceberg

CMD ["jupyter", "notebook", "--allow-root", "--ip", "0.0.0.0", "--no-browser", "--NotebookApp.token=''", "--NotebookApp.password=''"]
