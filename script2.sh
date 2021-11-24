#!/bin/bash

# kontener t1
docker run -itd --name t1 alpine sh

# siec bridge1
docker network create -d bridge --subnet 10.0.10.0/24 bridge1

# kontener t2
docker run -itd --name t2 -p 80:80 -p 10.0.10.0:8000:80 nginx

# kontener d1
docker run -itd --name d1 --net bridge1 --ip 10.0.10.254 --network-alias host1 alpine sh

docker network connect bridge1 t2

# siec bridge2
docker network create -d bridge --subnet 10.0.2.15/24 bridge2

# kontener s1
docker run -itd --name s1 --net bridge2 --network-alias host2 ubuntu sh

# kontener d2
docker run -itd --name d2 --net bridge1 -p 10.0.10.0:8080:80 --network-alias apa1 -p 10.0.2.15:8081:80 busybox sh

docker network connect --alias apa2 bridge2 d2