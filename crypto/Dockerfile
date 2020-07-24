FROM seemann/cyng:0.1.0 AS build

RUN wget https://dl.bintray.com/boostorg/release/1.73.0/source/boost_1_73_0.tar.bz2 && \
    tar xjvf boost_1_73_0.tar.bz2 && \
    cd boost_1_73_0 && \
    ./bootstrap.sh --with-libraries=filesystem,program_options,system,thread,timer,random,test,regex && \
    ./b2 install

WORKDIR /src-crypto

RUN git clone https://github.com/solosTec/crypto .

RUN mkdir -p build/x64

RUN cd build/x64 && cmake -DCRYPT_BUILD_TEST:bool=ON -DCMAKE_BUILD_TYPE=Debug ../..  && make && make install
