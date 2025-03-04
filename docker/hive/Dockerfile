# based on https://github.com/XDgov/weehive

# split downloads so the layers are cached independently, and the .tar.gzs aren't included in the final image (reducing the size)
# https://medium.com/@tonistiigi/advanced-multi-stage-build-patterns-6f741b852fae

FROM alpine:3.21.2 as hadoop

ARG HADOOP_VERSION=3.4.1
ARG MIRROR=https://dlcdn.apache.org

# download remotely
RUN wget $MIRROR/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
RUN tar -xzf hadoop-$HADOOP_VERSION.tar.gz
RUN mv hadoop-$HADOOP_VERSION hadoop


FROM alpine:3.21.2 as hive

ARG HIVE_VERSION=3.1.3
ARG MIRROR=https://archive.apache.org/

# download remotely
RUN wget $MIRROR/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz
RUN tar -xzf apache-hive-$HIVE_VERSION-bin.tar.gz
RUN mv apache-hive-$HIVE_VERSION-bin hive
# https://stackoverflow.com/a/41789082/358804
RUN rm hive/lib/log4j-slf4j-impl-*.jar

# replace guava versions - issue: https://issues.apache.org/jira/browse/HIVE-22915
RUN rm hive/lib/guava-19.0.jar
RUN wget https://repo1.maven.org/maven2/com/google/guava/guava/29.0-jre/guava-29.0-jre.jar
RUN mv guava-29.0-jre.jar hive/lib/


# https://www.digitalocean.com/community/tutorials/how-to-install-hadoop-in-stand-alone-mode-on-ubuntu-18-04
FROM openjdk:17-jdk-slim

WORKDIR /usr/local/hadoop

COPY --from=hadoop /hadoop hadoop
ENV HADOOP_HOME /usr/local/hadoop/hadoop
ENV PATH="${HADOOP_HOME}/bin:${PATH}"

COPY --from=hive /hive hive
ENV HIVE_HOME /usr/local/hadoop/hive
ENV PATH="${HIVE_HOME}/bin:${PATH}"
COPY hive-site.xml $HIVE_HOME/conf/

# https://cwiki.apache.org/confluence/display/Hive/GettingStarted#GettingStarted-RunningHive
RUN hadoop fs -mkdir -p /tmp && \
    hadoop fs -chmod g+w /tmp && \
    hadoop fs -mkdir -p /usr/local/hadoop/warehouse

# https://cwiki.apache.org/confluence/display/Hive/GettingStarted#GettingStarted-RunningHiveServer2andBeeline.1
COPY run_metastore.sh /
RUN schematool -dbType derby -initSchema && \
    chmod +x /run_metastore.sh

CMD ["/run_metastore.sh"]
