ARG BASE_TAG
FROM seemann/node:${BASE_TAG} AS build

FROM ubuntu:bionic

RUN apt-get update && \
	apt-get install -y  \
	unixodbc \
	nano

WORKDIR /app

COPY --from=build /usr/local/lib/libboost_* /usr/local/lib/
COPY --from=build /usr/local/lib/libcrypto.so /usr/local/lib/
COPY --from=build /src/cyng/build/*.deb ./
COPY --from=build /src/node/build/x64/*.deb ./

RUN dpkg -i *.deb
RUN rm *.deb
RUN ldconfig
