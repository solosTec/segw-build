#!/bin/bash

#
# running as root!
#
if [ $EUID -ne 0 ]; then
	echo "$0 is not running as root"
	exit
fi

#
# (1) Install Ubuntu Bionic
#
echo "Ubuntu Bionic LTS required"

#
# (2) Install essentials needed to build
#

apt-get update && \
	apt-get install -y \
	build-essential \
	apt-utils \
	git \
	nano \
	cmake \
	autoconf \
	libtool \
	pkg-config \
	libssl-dev \
	wget \
	libreadline-dev \
	lsb-release \
	unixodbc-dev \
	libarchive-zip-perl \
	software-properties-common \
	libncurses-dev \
	gawk \
#	flex \
#	bison \
#	texlive-base \
#	texinfo \
	python-dev \
	fakeroot

#
# (3) Install additional compilers
#

apt-get install -y gcc-8 g++-8
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8
apt-get install -y gcc-8-multilib g++-8-multilib

# should be version 8
gcc  --version

#
# (4) Toolchain
#
wget https://debian.pengutronix.de/debian/pool/main/p/pengutronix-archive-keyring/pengutronix-archive-keyring_2020.02.11_all.deb
dpkg -i pengutronix-archive-keyring_2020.02.11_all.deb
add-apt-repository "deb http://debian.pengutronix.de/debian/ bionic main contrib non-free"
apt-get update
apt-get install -y oselas.toolchain-2018.12.0-arm-v5te-linux-gnueabi-gcc-8.2.1-glibc-2.28-binutils-2.31.1-kernel-4.19-sanitized

# extend the PATH variable with toolchain location
PATH="${PATH}:/opt/OSELAS.Toolchain-2018.12.0/arm-v5te-linux-gnueabi/gcc-8.2.1-glibc-2.28-binutils-2.31.1-kernel-4.19-sanitized/bin/"
echo "export PATH=$PATH" > /etc/environment


