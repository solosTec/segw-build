ARG BASE_TAG
ARG BRANCH

FROM seemann/oecp-base:${BASE_TAG} AS build

WORKDIR /src

RUN git clone https://github.com/solosTec/cyng

WORKDIR /src/cyng

RUN git checkout ${BRANCH}

RUN git submodule update --init --recursive

WORKDIR /src/cyng
# patch CMakeLists avoid install error
RUN sed -i 's/CyngConfigVersion.cmake/ConfigVersion.cmake/g' CMakeLists.txt

WORKDIR /src/cyng/build

ADD cross.cmake .

RUN cmake -DCYNG_BUILD_TEST:bool=OFF -DCYNG_CROSS_COMPILE:bool=ON -DCYNG_SSL_SUPPORT:bool=ON -DCMAKE_TOOLCHAIN_FILE=cross.cmake .. && \
    make -j4 all && \
    make install




