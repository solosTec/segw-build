FROM ubuntu:bionic

RUN apt-get update && \
	apt-get install -y  \
	build-essential  \
	apt-utils  \
	git  \
	cmake  \
	autoconf  \
	libtool  \
	pkg-config  \
	libssl-dev  \
	libarchive-zip-perl \
	wget  \
	libreadline-dev  \
	lsb-release \
	software-properties-common \
	libncurses-dev \
	gawk \
	flex \
	bison \
	texlive-base \
	texinfo  \
	python-dev \
	fakeroot

#https://askubuntu.com/questions/1028601/install-gcc-8-only-on-ubuntu-18-04
RUN apt-get install -y gcc-8 g++-8
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8

# gcc 8 should now be the default one
RUN gcc  --version


RUN wget https://debian.pengutronix.de/debian/pool/main/p/pengutronix-archive-keyring/pengutronix-archive-keyring_2020.02.11_all.deb
RUN dpkg -i pengutronix-archive-keyring_2020.02.11_all.deb
RUN add-apt-repository "deb http://debian.pengutronix.de/debian/ bionic main contrib non-free"
RUN apt-get update
RUN apt-get install -y oselas.toolchain-2018.12.0-arm-v5te-linux-gnueabi-gcc-8.2.1-glibc-2.28-binutils-2.31.1-kernel-4.19-sanitized

# install the boost version - version can be overriden by --build-args
ARG BOOST_VERSION=1.73.0
ARG BOOST_VERSION_NAME=1_73_0

RUN wget https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_${BOOST_VERSION_NAME}.tar.bz2 && \
    tar xjvf boost_${BOOST_VERSION_NAME}.tar.bz2 && \
    cd boost_${BOOST_VERSION_NAME} && \
    ./bootstrap.sh --with-libraries=filesystem,program_options,system,thread,timer,random,test,regex,date_time && \
    ./b2 install
