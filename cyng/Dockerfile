ARG BASE_TAG
FROM seemann/cpp-build-base:${BASE_TAG} AS build

ARG BRANCH

WORKDIR /src

RUN git clone https://github.com/solosTec/cyng && cd cyng

WORKDIR /src/cyng

RUN git checkout ${BRANCH}

RUN git submodule update --init --recursive

# patch CMakeLists avoid install error
RUN sed -i 's/CyngConfigVersion.cmake/ConfigVersion.cmake/g' CMakeLists.txt

RUN mkdir -p build && \
    cd build &&  \
    cmake -DCMAKE_BUILD_TYPE=Release ..  &&  \
    make -j4 all &&  \
    make install
