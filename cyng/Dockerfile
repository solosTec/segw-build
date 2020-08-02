FROM seemann/cpp-build-base:0.1.0 AS build

WORKDIR /src

RUN git clone https://github.com/solosTec/cyng && cd cyng

WORKDIR /src/cyng

RUN git checkout v0.8

RUN git submodule update --init --recursive

# patch CMakeLists set compiler version to link against stdc++fs and avoid install error
RUN sed -i 's/CyngConfigVersion.cmake/ConfigVersion.cmake/g' CMakeLists.txt && \
    sed -i 's/:8.2.1>/:8.4.0>/g' CMakeLists.txt

RUN mkdir -p build && \
    cd build &&  \
    cmake -DCMAKE_BUILD_TYPE=Release ..  &&  \
    make -j4 all &&  \
    make install
