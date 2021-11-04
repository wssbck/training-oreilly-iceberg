#!/bin/sh

RUN hadoop fs -chmod g+w /usr/local/hadoop/warehouse
hive --service hiveserver2 --hiveconf hive.server2.transport.mode=binary
