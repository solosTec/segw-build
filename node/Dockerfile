ARG BASE_TAG
FROM solostec/crypto:${BASE_TAG} AS build

ARG BRANCH

WORKDIR /src

RUN git clone https://github.com/solosTec/node && cd node

WORKDIR /src/node

RUN git checkout ${BRANCH}

RUN mkdir -p build/x64 && \
    cd build/x64 && \
    cmake -DSMF_UNIT_TEST:BOOL=OFF -DNODE_CROSS_COMPILE:bool=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_FIND_DEBUG_MODE=OFF -G Ninja ../.. && \
    ninja -j4 all && \
    ninja install && \
    cpack
