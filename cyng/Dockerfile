ARG BASE_TAG
FROM solostec/cpp-build-base:${BASE_TAG} AS build

ARG BRANCH

WORKDIR /src

RUN git clone https://github.com/solosTec/cyng && cd cyng

WORKDIR /src/cyng

RUN git checkout ${BRANCH}

RUN git submodule update --init --recursive

RUN mkdir -p build && \
    cd build &&  \
    cmake -DCMAKE_BUILD_TYPE=Release -G Ninja ..  &&  \
    ninja -j4 all &&  \
    ninja install &&  \
    cpack
