FROM seemann/cpp-build-base:0.1.0 AS build

WORKDIR /src

RUN git clone https://github.com/solosTec/cyng && cd cyng

WORKDIR /src/cyng

RUN git checkout v0.8

RUN git submodule update --init --recursive

RUN mkdir -p build && \
    cd build &&  \
    cmake -DCMAKE_BUILD_TYPE=Release -DMYSQL_CONNECTOR_ROOT_DIR:PATH=/src/mysql-connector-cpp/build ..  &&  \
    make -j4 all &&  \
    make install
