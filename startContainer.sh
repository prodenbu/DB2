#!/bin/bash
./stopContainer.sh
HIVE_VERSION=4.0.1
docker run -d -p 10000:10000 -p 10002:10002 --env SERVICE_NAME=hiveserver2 --name hive4 apache/hive:${HIVE_VERSION}
ip=$(docker container exec hive4 hostname -I|tr -d " ");
sed "s/IPADDR/$ip/g" connectHive.template > connectHive.sh
sed "s/IPADDR/$ip/g" Aufgaben/Hive/Java/Create.java.template > Aufgaben/Hive/Java/Create.java
sed "s/IPADDR/$ip/g" Aufgaben/Hive/Java/Create.java.template > Aufgaben/Hive/Java/Create.java
sed "s/IPADDR/$ip/g" Aufgaben/Hive/actions.sh.template > Aufgaben/Hive/actions.sh
sed "s/IPADDR/$ip/g" Aufgaben/Hive/tables.sh.template > Aufgaben/Hive/tables.sh
docker container create \
	--name testing \
	-p 16010:16010 \
	-p 9868:9868 \
	-p 9870:9870 \
	db2
docker container cp "./sleep.sh" "testing:/usr/bin"
docker container cp "Aufgaben" "testing:/home/user"
docker container cp "connectHive.sh" "testing:/home/user"
docker container start testing
ip=$(docker container exec testing hostname -I)
echo "$ip"
# docker logs -f testing
