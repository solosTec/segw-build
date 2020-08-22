ARG BASE_TAG
FROM seemann/crypto:${BASE_TAG} AS build

ARG BRANCH

WORKDIR /src

RUN git clone https://github.com/solosTec/node && cd node

WORKDIR /src/node

RUN git checkout ${BRANCH}

RUN mkdir -p build/x64 && \
    cd build/x64 && \
    cmake -DNODE_BUILD_TEST:BOOL=OFF -DNODE_CROSS_COMPILE:bool=OFF -DNODE_SSL_SUPPORT:BOOL=ON -DCRYPT_ROOT:PATH=/src/crypto -DCRYPT_BUILD=/src/crypto/build/x64 -DCMAKE_BUILD_TYPE=Release -DCMAKE_FIND_DEBUG_MODE=OFF ../.. && \
    make -j4 all && \
    make install && \
    cpack


RUN ls -la
