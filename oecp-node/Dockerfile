FROM seemann/oecp-crypto:0.1.0 AS build

WORKDIR /src

RUN git clone https://github.com/solosTec/node && cd node

WORKDIR /src/node

RUN git checkout v0.8

# patch CMakeLists set compiler version to link against stdc++fs
RUN find . -type f -name 'CMakeLists.txt' -exec sed -i 's/:8.2.1>/:8.4.0>/g' {} \;

WORKDIR /src/node/cross

ADD cross.cmake .

RUN mkdir -p build/arm && \
    cd build/arm && \
    cmake -DNODE_BUILD_TEST:BOOL=OFF -DNODE_CROSS_COMPILE:bool=ON -DNODE_SSL_SUPPORT:BOOL=ON -DCRYPT_ROOT:PATH=/src/crypto -DCRYPT_BUILD=/src/crypto/cross/build/arm -DCMAKE_BUILD_TYPE=Release -DCMAKE_FIND_DEBUG_MODE=ON -DCMAKE_TOOLCHAIN_FILE=cross.cmake  ../../.. && \
    make -j4 all
    #make install
