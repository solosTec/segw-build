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

#How the build works:
There are 5 steps in the build process:
- base: provides a docker image that contains all tools and libs to build the project (e.g. gcc, boost, libsssl, ...)
- cyng: based on _base_ a docker image is created that contains the _cyng_ libs.
- crypto: based on _cyng_ a docker image is created that contains the _crypto_ lib.
- node: based on _crypto_ a docker image is created that contains the _node_ executables
- dist: a distribution image is created that contains only the libs and executables to run the application.

#What to do if a new branch is created in the c++ projects:

You should change the parameter in the _circleci.yml_ to the new branch name (current value is v0.8):
```
  branch:
    type: string
    default: v0.8
```
After that the build runs but will fail because the branch is not available in the _cyng_ and _node_ project.
Create a new branch in the _cyng_ project, push the branch to github. The build will fail at the _node_ build.
Create a new branch in the _node_ project, push the branch to github. The build will complete.

Note: the project _crypto_ runs always on master. Also note the next step in the build needs a docker image
tagged with the branch name - e.g. for the next step you need to wait until the step  before has finished.

Note: if you push anything to this github project a complete build will run. Except you put _`[skip ci]`_ in
the commit message.
