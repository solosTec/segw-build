FROM seemann/crypto:0.1.0 AS build

WORKDIR /src

RUN git clone https://github.com/solosTec/node && cd node

RUN git checkout v0.8

RUN mkdir build/x64 && cd build/x64

RUN cmake -DNODE_BUILD_TEST:BOOL=ON -DNODE_CROSS_COMPILE:bool=OFF -DNODE_SSL_SUPPORT:BOOL=ON -DOPENSSL_ROOT_DIR:PATH=/projects/install/x64/openssl -DBOOST_ROOT:PATH=/projects/install/x64/boost -DDCYNG_ROOT:PATH=/projects/cyng -DCYNG_ROOT_BUILD_SUBDIR:STRING=build/x64 -DCRYPT_ROOT:PATH=/projects/crypto -DCMAKE_BUILD_TYPE=Debug ../..

RUN make -j4 all

RUN make install
