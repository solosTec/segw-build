#!/bin/bash
set -e

OWNPATH=$(dirname $0)
CURRENTDIR=$(pwd)
#echo "OWNPATH: $OWNPATH"
#echo "CURRENTDIR: $CURRENTDIR"

CROSSCMAKEFILE=$OWNPATH/cross.cmake
OPKGTOOLS=$OWNPATH/opkg-tools

WORKPATH="$1"
if [ -z "${WORKPATH}" ]; then
	WORKPATH=${HOME}
fi 

echo "\${WORKPATH}: ${WORKPATH}"

if [[ ! "$WORKPATH" =~ ^(\/).*  ]]; then
	echo "use absolute paths" 
	WORKPATH=${CURRENTDIR}/${WORKPATH}
	CROSSCMAKEFILE=${CURRENTDIR}/${CROSSCMAKEFILE}
	OPKGTOOLS=${CURRENTDIR}/${OPKGTOOLS}
fi

echo "\${WORKPATH}: ${WORKPATH}"

if [ ! -d ${WORKPATH} ]; then
	mkdir -p ${WORKPATH}
fi

#
# (1) Install Ubuntu Bionic
#
echo "Ubuntu Bionic LTS required"

#
# (2) Install essentials needed to build
# (3) Install additional compilers
# make sure that the toolchain is in the current search path
#
echo "call install-essentials.sh as root to make sure that all required environment variables are set"


install_boost()
{
BOOST_VERSION=1.74.0
BOOST_VERSION_NAME=1_74_0

if [ ! -f boost_$BOOST_VERSION_NAME.tar.bz2 ]; then
    echo "Download boost_$BOOST_VERSION_NAME.tar.bz2"
    wget --no-check-certificate https://dl.bintray.com/boostorg/release/$BOOST_VERSION/source/boost_$BOOST_VERSION_NAME.tar.bz2
else
    echo "boost_$BOOST_VERSION_NAME.tar.bz2 already downloaded"
fi

if [ ! -d boost_$BOOST_VERSION_NAME ]; then
    echo "Extract boost_$BOOST_VERSION_NAME.tar.bz2"
    tar xjvf boost_$BOOST_VERSION_NAME.tar.bz2
else
    echo "boost_$BOOST_VERSION_NAME.tar.bz2 already extracted"
fi

    echo "build boost_$BOOST_VERSION_NAME"
    cd boost_$BOOST_VERSION_NAME && \
    ./bootstrap.sh --with-libraries=filesystem,program_options,system,thread,timer,random,test,regex,date_time --prefix=$WORKPATH/install/v5te/boost && \
    sed -i 's/using gcc/using gcc : arm : arm-v5te-linux-gnueabi-c++/g'  project-config.jam && \
    ./b2 -j2 address-model=32 install toolset=gcc-arm

}

install_ssl()
{

SSL_VERSION=1.1.1g

if [ ! -f openssl-$SSL_VERSION.tar.gz ]; then
    echo "Download openssl-$SSL_VERSION.tar.gz"
    wget --no-check-certificate http://www.openssl.org/source/openssl-$SSL_VERSION.tar.gz
else
    echo "openssl-$SSL_VERSION.tar.gz already downloaded"
fi

if [ ! -d  openssl-$SSL_VERSION ]; then
    echo "Extract openssl-$SSL_VERSION.tar.gz"
    tar xzvf openssl-$SSL_VERSION.tar.gz
else
	echo "openssl-$SSL_VERSION.tar.gz already extracted"
fi

echo "build openssl-$SSL_VERSION"

cd openssl-$SSL_VERSION
if [ ! -f Makefile ]; then
    ./Configure linux-generic32 shared enable-ssl-trace --prefix=$WORKPATH/install/v5te/openssl --openssldir=$WORKPATH/install/v5te/openssl --cross-compile-prefix=arm-v5te-linux-gnueabi- PROCESSOR=ARM
fi

make -j4 && make install
}

install_cyng()
{
CYNG_VERSION=v0.8

if [ ! -d  cyng ]; then
    echo "Clone cyng"
    git clone https://github.com/solosTec/cyng && cd cyng
    git checkout $CYNG_VERSION
    git submodule update --init --recursive
	cd ..
else
	echo "cyng already cloned"
fi
cd cyng
if [ ! -d build/v5te ]; then
    mkdir -p build/v5te && \
    cd build/v5te &&  \
    cmake -DCMAKE_INSTALL_PREFIX:PATH=$WORKPATH/install/v5te/cyng -DBOOST_ROOT:PATH=$WORKPATH/install/v5te/boost -DBOOST_LIBRARYDIR:PATH=$WORKPATH/install/v5te/boost/lib -DBOOST_INCLUDEDIR:PATH=$WORKPATH/install/v5te/boost/include -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=${CROSSCMAKEFILE} ../..  
    cd ../..
fi

cd build/v5te &&  \
    make -j4 all &&  \
    make install
}

install_crypto()
{
if [ ! -d  crypto ]; then
	echo "Clone crypto"
	git clone https://github.com/solosTec/crypto
else
	echo "crypto already cloned"
fi

cd crypto

if [ ! -d build/v5te ]; then
# -DOPENSSL_ROOT_DIR:PATH=$WORKPATH/install/v5te/openssl -DOPENSSL_INCLUDE_DIR=$WORKPATH/install/v5te/openssl/include -DOPENSSL_CRYPTO_LIBRARY:PATH=$WORKPATH/install/v5te/openssl/lib -DOPENSSL_SSL_LIBRARY:FILEPATH=$WORKPATH/install/v5te/lib/libssl.so
    echo "Configure crypto"
    mkdir -p build/v5te
    cd build/v5te && \
    cmake -DCMAKE_INSTALL_PREFIX:PATH=$WORKPATH/install/v5te/crypto \
          -DCRYPT_BUILD_TEST:bool=OFF -DCMAKE_BUILD_TYPE=Release \
          -DCYNG_ROOT=$WORKPATH/cyng -DCYNG_INCLUDE=$WORKPATH/cyng/src/main/include -DCYNG_LIBRARY=$WORKPATH/cyng/build/v5te \
          -DOPENSSL_ROOT_DIR:PATH=$WORKPATH/install/v5te/openssl \
          -DCMAKE_TOOLCHAIN_FILE=${CROSSCMAKEFILE} ../.. 
    cd ../..
else
	echo "crypto already configured"
fi

cd build/v5te && \
    make && \
    make install
}

install_node()
{
NODE_VERSION=v0.8

if [ ! -d  node ]; then
    echo "Clone node"
    git clone https://github.com/solosTec/node && cd node
    git checkout $NODE_VERSION
	cd ..
else
	echo "node already cloned"
fi

cd node
if [ ! -d build/v5te ]; then
    echo "Configure node"

    mkdir -p build/v5te && \
    cd build/v5te && \
    cmake -DCMAKE_INSTALL_PREFIX:PATH=$WORKPATH/install/v5te/node -DOPENSSL_ROOT_DIR:PATH=$WORKPATH/install/v5te/openssl -DBOOST_ROOT:PATH=$WORKPATH/install/v5te/boost -DNODE_BUILD_TEST:BOOL=OFF -DNODE_CROSS_COMPILE:bool=ON -DNODE_SSL_SUPPORT:BOOL=ON -DCYNG_ROOT_DEV:PATH=$WORKPATH/cyng -DCYNG_ROOT_BUILD_SUBDIR:STRING=build/v5te -DCRYPT_ROOT:PATH=$WORKPATH/crypto -DCRYPT_BUILD:PATH=$WORKPATH/crypto/build/v5te -DCMAKE_BUILD_TYPE=Release -DCMAKE_FIND_DEBUG_MODE=ON -DCMAKE_TOOLCHAIN_FILE=${CROSSCMAKEFILE} ../.. 
    cd ../..
else
	echo "node already configured"
fi

cd build/v5te && \
    make segw
#    make -j4 all
}

#
# (4) Install latest Boost library
#

echo "===================================================================="
cd $WORKPATH
#install_boost


#
# (5) Install latest OpenSLL library
#
echo "===================================================================="
cd $WORKPATH
#install_ssl


#
# (6) Install cyng library v0.8
#

echo "===================================================================="
cd $WORKPATH
#install_cyng

#
# (7) Install crypto library
#

echo "===================================================================="
cd $WORKPATH
#install_crypto


#
# (8) Install node/smf library
#
echo "===================================================================="
cd $WORKPATH
#install_node



#
# build IPK
#
echo "OPKG package builder expected in $OPKGTOOLS"

cd $WORKPATH/node/build/v5te
fakeroot $OPKGTOOLS/opkg-buildpackage

cp $WORKPATH/node/build/v5te/node*ipk  $WORKPATH/
ls -l $WORKPATH/*ipk

