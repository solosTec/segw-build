FROM ubuntu:bionic

RUN apt-get update && \
	apt-get install -y build-essential apt-utils git cmake autoconf libtool pkg-config libssl-dev wget libreadline-dev

RUN wget https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.bz2 && \
    tar xjvf boost_1_69_0.tar.bz2 && \
    cd boost_1_69_0 && \
    ./bootstrap.sh --with-libraries=filesystem,program_options,system,thread,timer,random,test,regex && \
    ./b2 install
