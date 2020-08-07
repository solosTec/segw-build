FROM seemann/oecp-base:0.1.0 AS build

WORKDIR /src

RUN git clone https://github.com/solosTec/cyng && cd cyng

WORKDIR /src/cyng

RUN git checkout v0.8

RUN git submodule update --init --recursive

WORKDIR /src/cyng
# patch CMakeLists avoid install error
RUN sed -i 's/CyngConfigVersion.cmake/ConfigVersion.cmake/g' CMakeLists.txt

WORKDIR /src/cyng/cross

# extend path with oselas.toolchain
RUN "source /etc/profile"

ADD cross.cmake .

RUN cmake -DCYNG_BUILD_TEST:bool=OFF -DCYNG_CROSS_COMPILE:bool=ON -DCYNG_SSL_SUPPORT:bool=ON -DCMAKE_TOOLCHAIN_FILE=cross.cmake .. && \
    make -j4 all && \
    make install




