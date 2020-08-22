ARG BASE_TAG
FROM seemann/node:${BASE_TAG} AS build

FROM ubuntu:bionic

RUN apt-get update && \
	apt-get install -y  \
	unixodbc

WORKDIR /app

COPY --from=build /src/cyng/build/*.deb ./
COPY --from=build /src/node/build/x64/*.deb ./

#RUN dpkg -i *.deb

#RUN rm *.deb
