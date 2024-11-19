#!/bin/bash

./createContainer.sh
./startContainer.sh
ssh-keygen -f '/home/prodenbu/.ssh/known_hosts' -R "$(docker container exec testing hostname -I)"
ssh user@$(docker container exec testing hostname -I)
