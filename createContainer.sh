#!/bin/bash

if [[ ! -e hadoop-3.4.1.tar.gz ]]; then
wget https://dlcdn.apache.org/hadoop/common/stable/hadoop-3.4.1.tar.gz
fi
if [[ ! -e apache-hive-4.0.1-bin.tar.gz ]]; then
wget https://dlcdn.apache.org/hive/hive-4.0.1/apache-hive-4.0.1-bin.tar.gz
fi
if [[ ! -e kafka_2.13-3.9.0.tgz ]]; then
wget https://dlcdn.apache.org/kafka/3.9.0/kafka_2.13-3.9.0.tgz
fi
if [[ ! -e apache-mahout-distribution-14.1.tar.gz ]]; then
wget https://downloads.apache.org/mahout/14.1/apache-mahout-distribution-14.1.tar.gz
fi
if [[ ! -e hbase-2.6.1-bin.tar.gz ]]; then
wget https://dlcdn.apache.org/hbase/2.6.1/hbase-2.6.1-bin.tar.gz
fi
docker image build -t db2 .
