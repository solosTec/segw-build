FROM ubuntu:bionic

ARG BOOST_VERSION=1.73.0

RUN apt-get update && \
	apt-get install -y build-essential apt-utils git cmake autoconf libtool pkg-config libssl-dev wget libreadline-dev

RUN wget https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_${BOOST_VERSION}.tar.bz2 && \
    tar xjvf boost_${BOOST_VERSION}.tar.bz2 && \
    cd boost_${BOOST_VERSION} && \
    ./bootstrap.sh --with-libraries=filesystem,program_options,system,thread,timer,random,test,regex && \
    ./b2 install
