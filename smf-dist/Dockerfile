ARG BASE_TAG
FROM solostec/node:${BASE_TAG} AS build
FROM solostec/dashboard:develop AS dash

FROM ubuntu:bionic
#FROM ubuntu:focal

RUN apt-get update && \
	apt-get install -y  \
    libssl-dev \
	unixodbc \
	nano

# Backend installation
WORKDIR /app

COPY --from=build /usr/local/lib/libboost_* /usr/local/lib/
COPY --from=build /usr/local/lib/libsmfsec.so /usr/local/lib/
COPY --from=build /src/cyng/build/*.deb ./
COPY --from=build /src/node/build/x64/*.deb ./

RUN dpkg -i *.deb  && \
    rm *.deb  && \
    ldconfig

# Frontend installation
WORKDIR /app/dash

COPY --from=dash /app/dist-no-auth .

# ensure the working directory is config so the configs can be loaded by node
WORKDIR /configs
