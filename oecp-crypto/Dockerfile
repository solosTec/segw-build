FROM seemann/oecp-cyng:0.1.0 AS build

WORKDIR /src

RUN wget http://www.openssl.org/source/openssl-1.1.1d.tar.gz
RUN tar -xvzf openssl-1.1.1d.tar.gz

WORKDIR /src/openssl-1.1.1d
RUN m
RUN make
RUN install

RUN git clone https://github.com/solosTec/crypto && cd crypto

WORKDIR /src/crypto/cross

RUN mkdir -p build/arm

ADD cross.cmake .

RUN cd build/arm && \
    cmake -DCRYPT_BUILD_TEST:bool=OFF -DCMAKE_BUILD_TYPE=Debug -DCYNG_ROOT=/src/cyng -DCYNG_INCLUDE=/src/cyng/src/main/include -DCYNG_LIBRARY=/src/cyng/build -DCMAKE_TOOLCHAIN_FILE=cross.cmake ../../..  && \
    make && \
    make install
