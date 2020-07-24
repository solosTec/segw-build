FROM seemann/crypto:0.1.0 AS build

WORKDIR /src

RUN git clone https://github.com/solosTec/node .

RUN mkdir -p build

RUN cd build && cmake cmake -DNODE_BUILD_TEST:bool=ON ..  && make -j4 all && make install
