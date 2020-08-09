[![CircleCI](https://circleci.com/gh/mseemann/segw-build/tree/master.svg?style=shield)](https://circleci.com/gh/mseemann/segw-build/tree/master)


docker run --rm -it seemann/master:v0.8 /app/hello

docker run --rm -it seemann/oecp-node:v0.8 bash

docker run --rm -it seemann/oecp-node:v0.8 bash


#How to get the ipk package

```

docker pull seemann/oecp-dist:v0.8
docker create -name oecp-dist seemann/oecp-dist:v0.8 
docker cp oecp-dist:/dist/node_0.8.2222_armel.ipk .
docker rm oecp-dist

```
