FROM seemann/crypto:0.1.0 AS build

WORKDIR /src

RUN git clone https://github.com/solosTec/node && cd node

WORKDIR /src/node

RUN git checkout v0.8

RUN mkdir build/x64 && \
    cd build/x64 && \
    cmake -DNODE_BUILD_TEST:BOOL=OFF -DNODE_CROSS_COMPILE:bool=OFF -DNODE_SSL_SUPPORT:BOOL=ON -DDCYNG_ROOT:PATH=/src/cyng -DCYNG_ROOT_BUILD_SUBDIR:STRING=build/x64 -DCRYPT_ROOT:PATH=/src/crypto -DCMAKE_BUILD_TYPE=Debug ../.. && \
    make -j4 all && \
    make install
