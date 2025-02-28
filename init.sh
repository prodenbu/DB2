#!/bin/bash
cat /tmp/id_ed25519.pub >> /home/user/.ssh/authorized_keys
service ssh start 
BASE_PATH=/tmp
cd $BASE_PATH

HIVE_HOME=/usr/bin/apache-hive-4.0.1-bin
# Entpacken und aufräumen
tar -xvzf hadoop-3.4.1.tar.gz && rm hadoop-3.4.1.tar.gz
tar -xvzf apache-hive-4.0.1-bin.tar.gz &&  rm apache-hive-4.0.1-bin.tar.gz
tar -xvzf hbase-2.6.1-bin.tar.gz && rm hbase-2.6.1-bin.tar.gz
tar -xvzf kafka_2.13-3.9.0.tgz && rm kafka_2.13-3.9.0.tgz
tar -xvzf protobuf-28.3.tar.gz && rm protobuf-28.3.tar.gz
tar -xvzf apache-tez-0.10.3-bin.tar.gz
cd apache-tez-0.10.3-bin
tar zcvf ../apache-tez-0.10.3-bin.tar.gz * 
cd $BASE_PATH
chown -R user:tez apache-tez-0.10.3-bin
cp -r apache-tez-0.10.3-bin /usr/bin/
cd mahout
tar -xzf apache-mahout-distribution-14.1.tar.gz && rm apache-mahout-distribution-14.1.tar.gz
cd ..
JAVA_HOME=$(java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home'|cut -d "=" -f2| tr -d '[[:blank:]]')
TEZ_HOME=/usr/bin/apache-tez-0.10.3-bin
TEZ_CONF_DIR=$TEZ_HOME/conf
TEZ_JARS=$TEZ_HOME
HADOOP_CLASSPATH=$TEZ_HOME/*:$TEZ_HOME/conf
echo "# JAVA_HOME
export JAVA_HOME=$JAVA_HOME
export TEZ_CONF_DIR=$TEZ_CONF_DIR
export TEZ_JARS=$TEZ_JARS" >> hadoop-3.4.1/etc/hadoop/hadoop-env.sh
echo '
export HADOOP_CLASSPATH=${TEZ_CONF_DIR}:${TEZ_JARS}/*:${TEZ_JARS}/lib/*:${HADOOP_CLASSPATH}:\${JAVA_JDBC_LIBS}:\${MAPREDUCE_LIBS}' >> hadoop-3.4.1/etc/hadoop/hadoop-env.sh
mv core-site.xml hadoop-3.4.1/etc/hadoop
mv mapred-site.xml hadoop-3.4.1/etc/hadoop
mv yarn-site.xml hadoop-3.4.1/etc/hadoop
mv hdfs-site.xml hadoop-3.4.1/etc/hadoop
mv hbase-site.xml hbase-2.6.1/conf
mv hive-site.xml apache-hive-4.0.1-bin/conf
chown -R user:hadoop hadoop-3.4.1 
chown -R user:hbase  hbase-2.6.1
chown -R user:mahout mahout
chown -R user:kafka kafka_2.13-3.9.0
chown -R user:hive apache-hive-4.0.1-bin
mv hadoop-3.4.1 /usr/bin/
mv mahout /usr/bin/
mv kafka_2.13-3.9.0 /usr/bin/
mv hbase-2.6.1 /usr/bin/
mv apache-hive-4.0.1-bin /usr/bin/
echo "export HIVE_HOME=$HIVE_HOME">>/etc/profile
echo "JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64">>/etc/environment
echo "export JAVA_HOME=$JAVA_HOME">>/etc/profile
echo "export MAHOUT_HOME=/usr/bin/mahout">>/etc/profile
echo "export MAHOUT_LOCAL=true">>/etc/profile
HADOOP_HOME="/usr/bin/hadoop-3.4.1"
echo "export HADOOP_HOME=$HADOOP_HOME">>/etc/profile
echo "export TEZ_HOME=/usr/bin/apache-tez-0.10.3-bin">>/etc/profile
echo "export PATH=$PATH:$HIVE_HOME/bin:/usr/bin/hadoop-3.4.1/bin:/usr/bin/kafka_2.13-3.9.0/bin:/usr/bin/mahout/bin:/usr/bin/hbase-2.6.1/bin">>/etc/profile
echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
ssh-keygen -t rsa -P '' -f /home/user/.ssh/id_rsa
ssh-keyscan localhost 127.0.0.1 >> /home/user/.ssh/known_hosts
cat /home/user/.ssh/id_rsa.pub>> /home/user/.ssh/authorized_keys
chmod 0600 /home/user/.ssh/authorized_keys
chown -R user:user /home/user/.ssh
source /etc/profile
ssh-keyscan 127.0.0.1 >> /home/user/.ssh/known_hosts
su -l user -c "/usr/bin/hadoop-3.4.1/bin/hdfs namenode -format" && \
su -l user -c /usr/bin/hadoop-3.4.1/sbin/start-dfs.sh && \
su -l user -c /usr/bin/hbase-2.6.1/bin/start-hbase.sh  && \
su -l user -c "/usr/bin/kafka_2.13-3.9.0/bin/kafka-server-start.sh /usr/bin/kafka_2.13-3.9.0/config/server.properties">/tmp/kafka_boot.log &
echo "Creating Home"
while true; do
	su user -c "$HADOOP_HOME/bin/hdfs dfsadmin -report" && break;
	echo "waiting for dfs"
	sleep 1;
done
su user -c "$HADOOP_HOME/bin/hadoop fs -mkdir -p /apps/tez && echo 'created home' || echo 'creating failed';
$HADOOP_HOME/bin/hadoop fs -mkdir -p /user 
$HADOOP_HOME/bin/hadoop fs -mkdir -p /user/hive
$HADOOP_HOME/bin/hadoop fs -mkdir -p /user/hive/metastore
$HADOOP_HOME/bin/hadoop fs -put /tmp/apache-tez-0.10.3-bin.tar.gz /apps/tez;
$HADOOP_HOME/bin/hadoop fs -put /tmp/apache-tez-0.10.3-bin /apps/tez;"
mv tez-site.xml $TEZ_HOME/conf/tez-site.xml
echo "export TEZ_HOME=$TEZ_HOME" >> /etc/profile
echo "export HADOOP_CLASSPATH=$HADOOP_CLASSPATH" >> /etc/profile
# su user -c "$HADOOP_HOME/sbin/stop-all.sh"
# su user -c "$HADOOP_HOME/sbin/start-all.sh"
# while true; do
# 	sleep 10;
# done
