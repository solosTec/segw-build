FROM seemann/oecp-cyng:0.1.0 AS build

WORKDIR /src

RUN git clone https://github.com/solosTec/crypto && cd crypto

WORKDIR /src/crypto

WORKDIR /src/crypto/cross

ADD cross.cmake .

RUN mkdir -p build/x64

RUN cd build/x64 && \
    cmake -DCRYPT_BUILD_TEST:bool=OFF -DCMAKE_BUILD_TYPE=Debug -DCYNG_ROOT=/src/cyng -DCYNG_INCLUDE=/src/cyng/src/main/include -DCYNG_LIBRARY=/src/cyng/build -DCMAKE_TOOLCHAIN_FILE=cross.cmake ../../..  && \
    make && \
    make install
