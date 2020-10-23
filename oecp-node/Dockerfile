ARG BASE_TAG
FROM solostec/oecp-crypto:${BASE_TAG} AS build

ARG BRANCH

WORKDIR /src

RUN git clone https://github.com/solosTec/node

WORKDIR /src/node

RUN git checkout ${BRANCH}

WORKDIR /src/node/build

ADD cross.cmake .
ADD oecp-node/opkg-buildpackage .
ADD oecp-node/opkg-build .
RUN chmod +x opkg-buildpackage

RUN cmake -DNODE_BUILD_TEST:BOOL=OFF -DNODE_CROSS_COMPILE:bool=ON -DNODE_SSL_SUPPORT:BOOL=ON -DCRYPT_ROOT:PATH=/src/crypto -DCRYPT_BUILD=/src/crypto/build -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=cross.cmake  ..
RUN ./opkg-buildpackage
