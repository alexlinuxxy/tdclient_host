#!/bin/bash

OPENSSL=openssl
BOOST=boost_1_49_0
TARGET=ubuntu-12.04
BOOST_DIR=/opt/$BOOST
OPENSSL_DIR=/opt/$OPENSSL
TD_CLI_SRC_DIR=/mnt/tdclient/$TARGET
CPUCORES=$((`cat /proc/cpuinfo | grep processor | wc -l` * 2))

# boost & openssl
cd $BOOST_DIR && ./bootstrap.sh --with-libraries="thread,system,serialization,regex,filesystem" && ./b2 -j$CPUCORES
ln -s $BOOST_DIR/stage/lib $BOOST_DIR/stage/lib/debian
cd $OPENSSL_DIR && git checkout OpenSSL_1_0_1c && ./config && make -j$CPUCORES

# td
export BOOST_HOME=$BOOST_DIR
export LIBRARY_PATH=$OPENSSL_DIR
mkdir -p $TD_CLI_SRC_DIR
rm -rf $TD_CLI_SRC_DIR/*
cd $TD_CLI_SRC_DIR && svn checkout https://sh-ssvn.sh.intel.com/empg_repos/svn_td/td/trunk/tdclient --username huangshx
cd $TD_CLI_SRC_DIR/tdclient/tdclient/ && patch -p1 < /opt/g++_std.patch
cd $TD_CLI_SRC_DIR/tdclient/tdclient/libs/ && chmod +x build.ubuntu.sh && sed -i "s/BOOST_HOME=\(.*\)make$/BOOST_HOME=\1make -j$CPUCORES/g" build.ubuntu.sh && ./build.ubuntu.sh
cd $TD_CLI_SRC_DIR/tdclient/tdclient/linux/ && chmod +x build.ubuntu.sh && sed -i "s/BOOST_HOME=\(.*\)make$/BOOST_HOME=\1make -j$CPUCORES/g" build.ubuntu.sh && ./build.ubuntu.sh
