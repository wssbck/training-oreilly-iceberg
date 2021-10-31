# based on https://github.com/XDgov/weehive

# split downloads so the layers are cached independently, and the .tar.gzs aren't included in the final image (reducing the size)
# https://medium.com/@tonistiigi/advanced-multi-stage-build-patterns-6f741b852fae

FROM alpine as hadoop

ARG MIRROR=https://dlcdn.apache.org
ARG HADOOP_VERSION=3.3.1

# download remotely
RUN wget $MIRROR/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
RUN tar -xzf hadoop-$HADOOP_VERSION.tar.gz

# copy from local - to use, remove .dockerignore
# ADD hadoop-$HADOOP_VERSION.tar.gz .

RUN mv hadoop-$HADOOP_VERSION hadoop


FROM alpine as hive
ARG MIRROR=https://dlcdn.apache.org
ARG HIVE_VERSION=3.1.2

# download remotely
RUN wget $MIRROR/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz
RUN tar -xzf apache-hive-$HIVE_VERSION-bin.tar.gz

# copy from local - to use, remove .dockerignore
# ADD apache-hive-$HIVE_VERSION-bin.tar.gz .

RUN mv apache-hive-$HIVE_VERSION-bin hive
# https://stackoverflow.com/a/41789082/358804
RUN rm hive/lib/log4j-slf4j-impl-2.10.0.jar

# replace guava versions - issue: https://issues.apache.org/jira/browse/HIVE-22915
RUN rm hive/lib/guava-19.0.jar
RUN wget https://repo1.maven.org/maven2/com/google/guava/guava/29.0-jre/guava-29.0-jre.jar
RUN mv guava-29.0-jre.jar hive/lib/


# https://www.digitalocean.com/community/tutorials/how-to-install-hadoop-in-stand-alone-mode-on-ubuntu-18-04

FROM ubuntu:bionic

WORKDIR /usr/local/hadoop

RUN apt-get update && apt-get install -y openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

COPY --from=hadoop /hadoop hadoop
ENV HADOOP_HOME /usr/local/hadoop/hadoop
ENV PATH="${HADOOP_HOME}/bin:${PATH}"

COPY --from=hive /hive hive
ENV HIVE_HOME /usr/local/hadoop/hive
ENV PATH="${HIVE_HOME}/bin:${PATH}"
COPY hive-site.xml $HIVE_HOME/conf/

ARG HADOOP_STORAGE=/usr/local/hadoop/warehouse
# https://stackoverflow.com/a/13651963/358804
ARG METASTORE_DB=/usr/local/hadoop/metastore_db

# https://cwiki.apache.org/confluence/display/Hive/GettingStarted#GettingStarted-RunningHive
RUN hadoop fs -mkdir -p /tmp
RUN hadoop fs -mkdir -p $HADOOP_STORAGE
RUN hadoop fs -chmod g+w /tmp
RUN hadoop fs -chmod g+w $HADOOP_STORAGE

# https://cwiki.apache.org/confluence/display/Hive/GettingStarted#GettingStarted-RunningHiveServer2andBeeline.1
RUN schematool -dbType derby -initSchema
VOLUME [ "${HADOOP_STORAGE}", "${METASTORE_DB}" ]
#CMD beeline -u jdbc:hive2://
CMD ["hiveserver2"]
