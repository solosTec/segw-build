# 
FROM ubuntu:bionic
# try 20.04
# FROM ubuntu:focal
# focal produces the error: std::bad_alloc on most services
ENV TZ=Europe/Berlin
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get install -y \
	build-essential \
	tzdata \
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
	software-properties-common \
	unixodbc-dev \
	gpg \
	libsystemd-dev \
	ninja-build

#install a current version of cmake
RUN apt purge --auto-remove cmake
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
RUN apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
#RUN apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main'
RUN apt update
RUN apt install -y cmake
RUN cmake --version

RUN apt-get install -y gcc-8 g++-8
#RUN apt-get install -y gcc-9 g++-9
RUN apt-get install -y libstdc++6
#RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 70 --slave /usr/bin/g++ g++ /usr/bin/g++-7
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 80 --slave /usr/bin/g++ g++ /usr/bin/g++-8
#RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9

# gcc 9 should now be the default one
RUN gcc --version


# install the boost version - version can be overriden by --build-args
ARG BOOST_VERSION=1.77.0
ARG BOOST_VERSION_NAME=1_77_0

#RUN wget https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_${BOOST_VERSION_NAME}.tar.bz2 && \
# use this from version 1.77 upwards
RUN wget https://boostorg.jfrog.io/artifactory/main/release/${BOOST_VERSION}/source/boost_${BOOST_VERSION_NAME}.tar.bz2 && \
    tar xjvf boost_${BOOST_VERSION_NAME}.tar.bz2 && \
    cd boost_${BOOST_VERSION_NAME} && \
    ./bootstrap.sh --with-libraries=filesystem,iostreams,program_options,system,thread,timer,random,test,regex,date_time,locale && \
    ./b2 -d0 install
