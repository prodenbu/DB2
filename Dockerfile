FROM ubuntu:latest

RUN apt update && apt upgrade -y
RUN apt-get install -y wget dumb-init openssh-server sudo vim
RUN useradd -m -s /bin/bash user
RUN groupadd hadoop
RUN groupadd hive 
RUN groupadd kafka 
RUN groupadd mahout 
RUN groupadd hbase 
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
COPY ./core-site.xml .
COPY ./hbase-site.xml .
COPY ./hdfs-site.xml .
COPY ./hadoop-3.4.1.tar.gz .
COPY ./id_ed25519.pub .
COPY ./apache-hive-4.0.1-bin.tar.gz .
COPY ./kafka_2.13-3.9.0.tgz .
COPY ./apache-mahout-distribution-14.1.tar.gz ./mahout
COPY ./hbase-2.6.1-bin.tar.gz .
COPY ./init.sh /usr/bin/
COPY ./start.sh /usr/bin/
RUN /usr/bin/init.sh
ENTRYPOINT ["/usr/bin/dumb-init","--"]
CMD ["/usr/bin/start.sh"]
