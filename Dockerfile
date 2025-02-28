FROM ubuntu:latest

RUN apt update && apt upgrade -y
RUN apt-get install -y wget dumb-init openssh-server sudo vim
RUN apt-get install -y maven gcc g++ make python3.12-venv
RUN apt-get install -y protobuf-compiler mysql-server mysql-client
RUN useradd -m -s /bin/bash user
RUN groupadd hadoop
RUN groupadd hive 
RUN groupadd kafka 
RUN groupadd mahout 
RUN groupadd hbase 
RUN groupadd tez 
RUN usermod -aG tez user
RUN usermod -aG hbase user
RUN usermod -aG mahout user
RUN usermod -aG hadoop user
RUN usermod -aG kafka user
RUN usermod -aG hive user
RUN usermod -aG sudo user
RUN apt-get -y install openjdk-21-jdk
WORKDIR /tmp
RUN mkdir mahout
RUN mkdir /var/hadoop_home
RUN mkdir /home/user/.ssh
ARG JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"
ARG MAHOUT_HOME="/usr/bin/mahout"
ARG MAHOUT_LOCAL=true
ARG HADOOP_HOME="/usr/bin/hadoop-3.4.1"
ARG TEZ_HOME="/usr/bin/apache-tez-0.10.3-bin"
ARG HIVE_HOME="/usr/bin/apache-hive-4.0.1-bin"
COPY ./core-site.xml .
COPY ./hive-site.xml .
COPY ./mapred-site.xml .
COPY ./yarn-site.xml .
COPY ./protobuf-28.3.tar.gz .
COPY ./hbase-site.xml .
COPY ./tez-site.xml .
COPY ./hdfs-site.xml .
COPY ./hadoop-3.4.1.tar.gz .
COPY ./id_ed25519.pub .
COPY ./apache-hive-4.0.1-bin.tar.gz .
COPY ./kafka_2.13-3.9.0.tgz .
COPY ./apache-mahout-distribution-14.1.tar.gz ./mahout
COPY ./hbase-2.6.1-bin.tar.gz .
COPY ./apache-tez-0.10.3-bin.tar.gz .
COPY ./init.sh /usr/bin/
COPY ./sleep.sh /usr/bin/
COPY ./connectHive.sh /home/user

RUN ["/usr/bin/init.sh",">>","/tmp/init.log"]
# ENTRYPOINT ["/usr/bin/dumb-init","--"]
ENTRYPOINT "/usr/bin/sleep.sh"
