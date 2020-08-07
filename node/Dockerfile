FROM seemann/crypto:0.1.0 AS build

WORKDIR /src

RUN git clone https://github.com/solosTec/node && cd node

WORKDIR /src/node

RUN git checkout v0.8

# patch CMakeLists set compiler version to link against stdc++fs
RUN find . -type f -name 'CMakeLists.txt' -exec sed -i 's/:8.2.1>/:8.4.0>/g' {} \;

RUN mkdir -p build/x64 && \
    cd build/x64 && \
    cmake -DNODE_BUILD_TEST:BOOL=OFF -DNODE_CROSS_COMPILE:bool=OFF -DNODE_SSL_SUPPORT:BOOL=ON -DCRYPT_ROOT:PATH=/src/crypto -DCRYPT_BUILD=/src/crypto/build/x64 -DCMAKE_BUILD_TYPE=Release -DCMAKE_FIND_DEBUG_MODE=ON ../.. && \
    make -j4 all
    #make install
