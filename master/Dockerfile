ARG BASE_TAG
FROM seemann/node:${BASE_TAG} AS build

FROM ubuntu:bionic

RUN apt-get update && \
	apt-get install -y  \
	unixodbc

WORKDIR /app

COPY --from=build /src/node/build/x64/*.deb ./

RUN apt install -y *.deb

RUN rm *.deb
