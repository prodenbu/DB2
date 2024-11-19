#!/bin/bash
service ssh start 
source /etc/profile
ssh-keyscan 127.0.0.1 >> /home/user/.ssh/known_hosts
su -l user -c "/usr/bin/hadoop-3.4.1/bin/hdfs namenode -format"
su -l user -c /usr/bin/hadoop-3.4.1/sbin/start-dfs.sh
su -l user -c /usr/bin/hbase-2.6.1/bin/start-hbase.sh
su -l user -c "/usr/bin/kafka_2.13-3.9.0/bin/kafka-server-start.sh /usr/bin/kafka_2.13-3.9.0/config/server.properties" &
while true; do
	sleep 10;
done
