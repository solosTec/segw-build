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
	wget  \
	libreadline-dev  \
	lsb-release  \
	unixodbc-dev  \
	#libmysqlcppconn7v5


#https://askubuntu.com/questions/1028601/install-gcc-8-only-on-ubuntu-18-04
RUN apt-get install -y gcc-8 g++-8
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8

# gcc 8 should now be the default one
RUN gcc  --version

# install the boost version - version can be overriden by --build-args
ARG BOOST_VERSION=1.73.0
ARG BOOST_VERSION_NAME=1_73_0

RUN wget https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_${BOOST_VERSION_NAME}.tar.bz2 && \
    tar xjvf boost_${BOOST_VERSION_NAME}.tar.bz2 && \
    cd boost_${BOOST_VERSION_NAME} && \
    ./bootstrap.sh --with-libraries=filesystem,program_options,system,thread,timer,random,test,regex,date_time && \
    ./b2 install

# install mysql connector from src
#WORKDIR /src
#RUN git clone https://github.com/mysql/mysql-connector-cpp && \
#    cd mysql-connector-cpp/ && \
#    mkdir build &&  \
#    cd build && \
#    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DWITH_CONCPP=/usr/local/lib && \
#    cmake --build . --target install
