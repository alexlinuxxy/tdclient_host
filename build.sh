#!/bin/bash

BOOST=boost-1_49_0
OPENSSL=openssl
BOOST_DIR=/opt/$BOOST
OPENSSL_DIR=/opt/$OPENSSL
TD_CLI_SRC_DIR=/mnt/tdclient/ubuntu-12.04
CPUCORES=$((`cat /proc/cpuinfo | grep processor | wc -l` * 2))
export BOOST_HOME=$BOOST_DIR
export LIBRARY_PATH=$OPENSSL_DIR

find $BOOST_DIR -name *.sh | xargs -I{} chmod +x {}
cd $BOOST_DIR && ./bootstrap.sh && ./b2 -j$CPUCORES
ln -s $BOOST_DIR/stage/lib $BOOST_DIR/stage/lib/debian
cd $OPENSSL_DIR && git checkout OpenSSL_1_0_1c && ./config && make -j$CPUCORES

mkdir -p $TD_CLI_SRC_DIR
rm -rf $TD_CLI_SRC_DIR/*
cd $TD_CLI_SRC_DIR && svn checkout https://sh-ssvn.sh.intel.com/empg_repos/svn_td/td/trunk/tdclient --username huangshx && patch -p0 < /opt/g++_std.patch
cd $TD_CLI_SRC_DIR/tdclient/tdclient/libs/ && chmod +x build.ubuntu.sh && ./build.ubuntu.sh
cd $TD_CLI_SRC_DIR/tdclient/tdclient/linux/ && chmod +x build.ubuntu.sh && ./build.ubuntu.sh

bash
