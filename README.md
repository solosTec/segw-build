[![CircleCI](https://circleci.com/gh/mseemann/segw-build/tree/master.svg?style=shield)](https://circleci.com/gh/mseemann/segw-build/tree/master)


docker run --rm -it seemann/oecp-node:v0.8 bash


#How to get the ipk package

```

docker pull seemann/oecp-dist:v0.8
docker create --name oecp-dist seemann/oecp-dist:v0.8 
docker cp oecp-dist:/dist/node_0.8.2222_armel.ipk .
docker rm oecp-dist

```

#How to use the smf-dist image:

docker-compose.yml
```
version: "3.8"
services:

  master:
    image: seemann/smf-dist:v0.8
    entrypoint: ["/usr/bin/master", "-C", "/configs/master_v0.8.json"]
    volumes:
      - ./configs:/configs:ro

  dash:
    image: seemann/smf-dist:v0.8
    entrypoint: ["/usr/bin/dash", "-C", "/configs/dash.8.json"]
    volumes:
      - ./configs:/configs:ro
    ports:
      - "80:80"

```
