#!/bin/sh

RUN hadoop fs -chmod g+w /usr/local/hadoop/warehouse
hive --service metastore
