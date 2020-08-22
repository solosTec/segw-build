FROM ubuntu:bionic

#install a current version of cmake
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
RUN sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
RUN sudo apt update
RUN sudo apt install cmake
RUN cmake --version

RUN apt-get update && \
	apt-get install -y \
	build-essential \
	apt-utils \
	git \
	nano \
	autoconf \
	libtool \
	pkg-config \
	libssl-dev \
	wget \
	libreadline-dev \
	lsb-release \
	unixodbc-dev


#https://askubuntu.com/questions/1028601/install-gcc-8-only-on-ubuntu-18-04
RUN apt-get install -y gcc-8 g++-8
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8

# gcc 8 should now be the default one
RUN gcc --version


# install the boost version - version can be overriden by --build-args
ARG BOOST_VERSION=1.73.0
ARG BOOST_VERSION_NAME=1_73_0

RUN wget https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_${BOOST_VERSION_NAME}.tar.bz2 && \
    tar xjvf boost_${BOOST_VERSION_NAME}.tar.bz2 && \
    cd boost_${BOOST_VERSION_NAME} && \
    ./bootstrap.sh --with-libraries=filesystem,program_options,system,thread,timer,random,test,regex,date_time && \
    ./b2 install
