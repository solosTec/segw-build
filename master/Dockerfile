FROM seemann/node:0.1.0 AS build

FROM ubuntu:bionic

RUN apt-get update && \
	apt-get install -y  \
	libssl-dev  \
	unixodbc

WORKDIR /app

COPY --from=build /src/node/build/x64/ ./
