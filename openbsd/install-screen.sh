#!/bin/bash



cd /opt
mkdir -p screen
cd screen
rm screen-4.2.0.tar.gz
wget http://ftp.gnu.org/gnu/screen/screen-4.2.0.tar.gz
tar xzvf screen-4.2.0.tar.gz
cd screen-4.2.0
export AUTOCONF_VERSION=2.69
export AUTOMAKE_VERSION=1.9
./autogen.sh
./configure
sed '28,29s/^/#/' Makefile > 1
mv 1 Makefile
sed '31s/^/#/' Makefile > 1
mv 1 Makefile
make && make install
