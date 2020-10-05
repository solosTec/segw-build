#
# Setup cross compilation environment with CMake.
#
# Usage: 
# cmake -DCMAKE_TOOLCHAIN_FILE=~/projects/cross.cmake ..
# 
# -DCMAKE_TOOLCHAIN_FILE:PATH="../cross-oecp.cmake" -DCMAKE_BUILD_TYPE=Release ..
#

#
# Define host system
#
#   This sets CMAKE_CROSSCOMPILING to true
#
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

#
# set a project specific variable TRUE if crosscompiling
#
set(${PROJECT_NAME}_CROSS_COMPILE TRUE)

#
# root path
# This is a copy from /usr directory from the original target system 
#
# Note: "libcls" is the project name in lower case. This name is important since it has
#	to match the package name in the CONTROL file from the OPKG tools
#
#
set(CROSS_ROOT "/tmp/smf/usr/local" CACHE PATH "root directory for cross compiling")
message(STATUS "** CROSS_ROOT:             ${CROSS_ROOT}")

set(CMAKE_ROOT_PATH ${CROSS_ROOT})
set(CMAKE_FIND_ROOT_PATH ${CROSS_ROOT})
#set(CMAKE_INSTALL_PREFIX ${CROSS_ROOT} CACHE PATH "install path for cross compiling" FORCE)

#
# cross compiler location
#
set(CROSS_TOOLS /opt/OSELAS.Toolchain-2018.12.0/arm-v5te-linux-gnueabi/gcc-8.2.1-glibc-2.28-binutils-2.31.1-kernel-4.19-sanitized)
set(CMAKE_C_COMPILER ${CROSS_TOOLS}/bin/arm-v5te-linux-gnueabi-gcc)
set(CMAKE_CXX_COMPILER ${CROSS_TOOLS}/bin/arm-v5te-linux-gnueabi-c++)
# should be found automatically
#set(CMAKE_AR ${CROSS_TOOLS}/bin/arm-v5te-linux-gnueabi-ar)
#set(CMAKE_CXX_LINK_EXECUTABLE ...
#set(CMAKE_C_LINK_EXECUTABLE ...

#
# include directories
# Don't forget to copy json-c include files to copy into ${CROSS_ROOT}/usr/include directory
#
include_directories(SYSTEM
	${CROSS_ROOT}/usr/include
	${CROSS_TOOLS}/arm-v5te-linux-gnueabi/include/c++/8.2.1
)

#
# link directories
# Don't forget to copy json-c library files to copy into ${CROSS_ROOT}/usr/lib directory
#
link_directories(
	${CROSS_ROOT}/usr/lib
	${CROSS_TOOLS}/arm-v5te-linux-gnueabi/lib
)

#
# Boost support
#
set(BOOST_INCLUDEDIR "${BOOST_ROOT}/include" CACHE PATH "BOOST_INCLUDEDIR")
set(BOOST_LIBRARYDIR "${BOOST_ROOT}/lib" CACHE PATH "BOOST_LIBRARYDIR")

#
# OpenSSL support
#
set(OPENSSL_INCLUDE_DIR ${OPENSSL_ROOT_DIR}/include)
set(OPENSSL_CRYPTO_LIBRARY ${OPENSSL_ROOT_DIR}/lib/libcrypto.so)
set(OPENSLL_LIBRARY ${OPENSSL_ROOT_DIR}/lib/lbssl.so)


#
# Use our definitions for compiler tools
#
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE NEVER)

#
# global compiler options
#
add_definitions("-DBOOST_ASIO_DISABLE_STD_FUTURE")

#
# some explanations:
# (1) -DBOOST_ASIO_DISABLE_STD_FUTURE is required to get rid of a bunch of compiler errors like: 'current_exception' is not a member of 'std'
# 	see https://github.com/chriskohlhoff/asio/issues/232
#
