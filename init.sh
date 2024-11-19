#!/bin/bash
cd /tmp
HIVE_HOME=/usr/bin/apache-hive-4.0.1-bin
tar -xzf hadoop-3.4.1.tar.gz
tar -xzf apache-hive-4.0.1-bin.tar.gz
tar -xzf hbase-2.6.1-bin.tar.gz
tar -xzf kafka_2.13-3.9.0.tgz
cd mahout
tar -xzf apache-mahout-distribution-14.1.tar.gz&&rm apache-mahout-distribution-14.1.tar.gz
cd ..
JAVA_HOME=$(java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home'|cut -d "=" -f2| tr -d '[[:blank:]]')
sed -i "s:#  JAVA_HOME=/usr/java/testing hdfs dfs -ls:JAVA_HOME=$JAVA_HOME:g" hadoop-3.4.1/etc/hadoop/hadoop-env.sh
sed -i "s:# export JAVA_HOME=/usr/java/jdk1.8.0/:JAVA_HOME=$JAVA_HOME:g" hbase-2.6.1/conf/hbase-env.sh
mv core-site.xml hadoop-3.4.1/etc/hadoop
mv hdfs-site.xml hadoop-3.4.1/etc/hadoop
mv hbase-site.xml hbase-2.6.1/conf
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
echo "export PATH=$PATH:$HIVE_HOME/bin:/usr/bin/hadoop-3.4.1/bin:/usr/bin/kafka_2.13-3.9.0/bin:/usr/bin/mahout/bin:/usr/bin/hbase-2.6.1/bin">>/etc/profile
echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
ssh-keygen -t rsa -P '' -f /home/user/.ssh/id_rsa
ssh-keyscan localhost 127.0.0.1 >> /home/user/.ssh/known_hosts
cat id_ed25519.pub >> /home/user/.ssh/authorized_keys
cat /home/user/.ssh/id_rsa.pub>> /home/user/.ssh/authorized_keys
chmod 0600 /home/user/.ssh/authorized_keys
chown -R user:user /home/user/.ssh
