#
# Define host system
#
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

#
# root path
#
SET(CROSS_ROOT /src/sysroot-target)
set(CMAKE_ROOT_PATH ${CROSS_ROOT})
set(CMAKE_FIND_ROOT_PATH ${CROSS_ROOT})

#
# cross compiler location
# Example for OSELAS toolchain
#
set(CROSS_TOOLS /opt/OSELAS.Toolchain-2018.12.0/arm-v5te-linux-gnueabi/gcc-8.2.1-glibc-2.28-binutils-2.31.1-kernel-4.19-sanitized)
set(CMAKE_C_COMPILER ${CROSS_TOOLS}/bin/arm-v5te-linux-gnueabi-gcc)
set(CMAKE_CXX_COMPILER ${CROSS_TOOLS}/bin/arm-v5te-linux-gnueabi-c++)

#
# include directories
#
include_directories(SYSTEM
	${CROSS_ROOT}/usr/include
	${CROSS_TOOLS}/arm-v5te-linux-gnueabi/include/c++/5.4.0
)

#
# link directories
#
link_directories(
	${CROSS_ROOT}/usr/lib
	${CROSS_TOOLS}/arm-v5te-linux-gnueabi/lib
)

#
# Boost support
#
#set(BOOST_ROOT  /boost_1_73_0)
#set(BOOST_INCLUDEDIR "${BOOST_ROOT}/include" CACHE PATH "BOOST_INCLUDEDIR")
#set(BOOST_LIBRARYDIR "${BOOST_ROOT}/lib" CACHE PATH "BOOST_LIBRARYDIR")

#
# OpenSSL support
#
set(OPENSSL_ROOT_DIR  /src/openssl-1.1.1d)
set(OPENSSL_INCLUDE_DIR ${OPENSSL_ROOT_DIR}/include)
set(OPENSSL_CRYPTO_LIBRARY ${OPENSSL_ROOT_DIR}/libcrypto.so)
set(OPENSLL_LIBRARY ${OPENSSL_ROOT_DIR}/lbssl.so)

#
# Use our definitions for compiler tools
#
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE NEVER)

#
# global compiler options
# this avoids a bunch of compiler errors
#
add_definitions("-DBOOST_ASIO_DISABLE_STD_FUTURE")
