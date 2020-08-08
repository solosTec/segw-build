FROM seemann/oecp-cyng:0.1.0 AS build

WORKDIR /src

RUN git clone https://github.com/solosTec/crypto

WORKDIR /src/crypto/build

ADD cross.cmake .

RUN cmake -DCRYPT_BUILD_TEST:bool=OFF -DCMAKE_BUILD_TYPE=Debug -DCYNG_ROOT=/src/cyng -DCYNG_INCLUDE=/src/cyng/src/main/include -DCYNG_LIBRARY=/src/cyng/build -DCMAKE_TOOLCHAIN_FILE=cross.cmake ../../..  && \
    make && \
    make install
