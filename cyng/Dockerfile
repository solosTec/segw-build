FROM seemann/cpp-build-base:0.1.0 AS build

WORKDIR /src

RUN git clone https://github.com/solosTec/cyng .

RUN mkdir -p build

RUN cd build && cmake ..  && make -j4 all
