ARG BASE_TAG
FROM seemann/oecp-cyng:${BASE_TAG} AS build

ARG BRANCH

WORKDIR /src

RUN git clone https://github.com/solosTec/crypto

WORKDIR /src/crypto/

RUN git checkout ${BRANCH}

WORKDIR /src/crypto/build

ADD cross.cmake .

RUN cmake -DCRYPT_BUILD_TEST:bool=OFF -DCMAKE_BUILD_TYPE=Debug -DCYNG_ROOT=/src/cyng -DCYNG_INCLUDE=/src/cyng/src/main/include -DCYNG_LIBRARY=/src/cyng/build -DCMAKE_TOOLCHAIN_FILE=cross.cmake ..  && \
    make && \
    make install
