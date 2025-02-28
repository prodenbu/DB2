#!/usr/bin/env bash
echo "starting services"
HADOOP_HOME="/usr/bin/hadoop-3.4.1"
service ssh start 
chown -R user:user /home/user/Aufgaben
/usr/bin/mysqld_safe&
su user -c "$HADOOP_HOME/sbin/stop-all.sh"
su user -c "$HADOOP_HOME/sbin/start-all.sh"
su -l user -c /usr/bin/hbase-2.6.1/bin/start-hbase.sh  
echo "services started... going to sleep"
while true; do
	sleep 10;
done
