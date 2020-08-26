#!/bin/bash
set -e

#echo "home directory: $HOME"
OWNPATH=$(dirname $0)
CURRENTDIR=$(pwd)

WORKPATH="$1"
if [ -z "${WORKPATH}" ]; then
	WORKPATH=${HOME}
fi 

echo "\${WORKPATH}: ${WORKPATH}"

if [[ ! "$WORKPATH" =~ ^(\/).*  ]]; then
	echo "use absolute paths" 
	WORKPATH=${CURRENTDIR}/${WORKPATH}
fi

echo "\${WORKPATH}: ${WORKPATH}"

if [ ! -d ${WORKPATH} ]; then
	mkdir -p ${WORKPATH}
fi

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
    tar xjvf boost_$BOOST_VERSION_NAME.tar.bz2 && \
    cd boost_$BOOST_VERSION_NAME && \
    ./bootstrap.sh --with-libraries=filesystem,program_options,system,thread,timer,random,test,regex,date_time --prefix=$WORKPATH/install/x64/boost && \
    ./b2 install

else
	echo "boost_$BOOST_VERSION_NAME.tar.bz2 already extracted"
fi

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
	./config  --prefix=$WORKPATH/install/x64/openssl --openssldir=$WORKPATH/install/x64/openssl
fi
	./config  --prefix=$HOME/install/x64/openssl --openssldir=$WORKPATH/install/x64/openssl &&
	make -j4 &&
	make install
}

install_cyng()
{
CYNG_VERSION=v0.8

if [ ! -d  cyng ]; then
	echo "Clone cyng"
	git clone https://github.com/solosTec/cyng
else
	echo "cyng already cloned"
fi

cd cyng
git checkout $CYNG_VERSION
git submodule update --init --recursive

if [ ! -d build/x64 ]; then
	echo "Configure cyng"
    mkdir -p build/x64 && \
    cd build/x64 &&  \
    cmake -DCMAKE_INSTALL_PREFIX:PATH=$WORKPATH/install/x64/cyng -DBOOST_ROOT:PATH=$WORKPATH/install/x64/boost -DBOOST_LIBRARYDIR:PATH=$WORKPATH/install/x64/boost/lib -DBOOST_INCLUDEDIR:PATH=$WORKPATH/install/x64/boost/include -DCMAKE_BUILD_TYPE=Release ../.. 
    cd ../..
else
    echo "cyng already configured"
fi

cd build/x64 && \
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
if [ ! -d build/x64 ]; then
    mkdir -p build/x64 && cd build/x64 && \
    cmake -DCMAKE_INSTALL_PREFIX:PATH=$WORKPATH/install/x64/crypto -DCRYPT_BUILD_TEST:bool=OFF -DCMAKE_BUILD_TYPE=Release -DCYNG_ROOT=$WORKPATH/cyng -DCYNG_INCLUDE=$WORKPATH/cyng/src/main/include -DCYNG_LIBRARY=$WORKPATH/cyng/build/x64 ../..  && \
    cd ../..
else
	echo "crypto already configured"
fi

cd build/x64 && \
    make && \
    make install
}

#
# build only segw/amrd 
#
install_node()
{
echo "build segw/amrd"
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
if [ ! -d build/x64 ]; then
    echo "Configure node"
    mkdir -p build/x64 && \
    cd build/x64 && \
    cmake -DCMAKE_INSTALL_PREFIX:PATH=$WORKPATH/install/x64/node -DOPENSSL_ROOT_DIR:PATH=$WORKPATH/install/x64/openssl -DBOOST_ROOT:PATH=$WORKPATH/install/x64/boost -DNODE_BUILD_TEST:BOOL=OFF -DNODE_CROSS_COMPILE:bool=OFF -DNODE_SSL_SUPPORT:BOOL=ON -DCYNG_ROOT_DEV:PATH=$WORKPATH/cyng -DCYNG_ROOT_BUILD_SUBDIR:STRING=build/x64 -DCRYPT_ROOT:PATH=$WORKPATH/crypto -DCRYPT_BUILD:PATH=$WORKPATH/crypto/build/x64 -DCMAKE_BUILD_TYPE=Release -DCMAKE_FIND_DEBUG_MODE=ON ../.. 
    cd ../..
else
	echo "node already configured"
fi

#
# build only segw/amrd program
#
cd build/x64 && \
    make -j4 segw
#    make -j4 all
}



#
# (1) Install Ubuntu Bionic
#
echo "Ubuntu Bionic LTS required"

#
# (2) Install essentials needed to build
# (3) Install additional compilers
# First call install-essentials.sh as root
#
echo "call install-essentials.sh as root"

#
# (4) Install latest Boost library
#

echo "===================================================================="
cd $WORKPATH
install_boost


#
# (5) Install latest OpenSLL library
#

echo "===================================================================="
cd $WORKPATH
install_ssl


#
# (6) Install cyng library v0.8
#

echo "===================================================================="
cd $WORKPATH
install_cyng

#
# (6) Install crypto library
#

echo "===================================================================="
cd $WORKPATH
install_crypto

#
# (7) Install node/smf library
#

echo "===================================================================="
cd $WORKPATH
install_node

#
# (8) extract amrd/segw artifact from node/build/nodes/ipt/segw
#

echo "executable: ${WORKPATH}/node/build/x64/nodes/ipt/segw/segw"


