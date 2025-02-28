#!/usr/bin/env bash

docker cp Aufgaben testing:/home/user
docker container exec testing chown -R user:user /home/user/Aufgaben
docker container exec testing chmod -R +x /home/user/Aufgaben
