FROM seemann/cpp-build-base:0.1.0 AS build

WORKDIR /src

RUN git clone https://github.com/solosTec/cyng && cd cyng

RUN git checkout v0.8

RUN git submodule update --init --recursive

RUN mkdir -p build

RUN cd build && cmake -D CMAKE_BUILD_TYPE=Release ..  && make -j4 all && make install
