#!/bin/bash

set -e

OUT_DIR=/mnt
OPENSSL=openssl
BOOST=boost_1_49_0
TARGET=ubuntu-14.04
BOOST_DIR=/opt/$BOOST
OPENSSL_DIR=/opt/$OPENSSL
TD_CLI_SRC_DIR=/mnt/tdclient/$TARGET
TD_CLI_RELEASE_DIR=$TD_CLI_SRC_DIR/lib/release/tdclient_deb
CPUCORES=$((`cat /proc/cpuinfo | grep processor | wc -l` * 2))

export BOOST_HOME=$BOOST_DIR
export LIBRARY_PATH=$BOOST_DIR/stage/lib:$OPENSSL_DIR

# boost & openssl
cd $BOOST_DIR && patch -p1 < /opt/boost.patch && ./bootstrap.sh --with-libraries="thread,system,serialization,regex,filesystem" && ./b2 -j$CPUCORES || 
cd $OPENSSL_DIR && git checkout OpenSSL_1_0_1c && ./config && make -j$CPUCORES

# td
mkdir -p $TD_CLI_SRC_DIR
rm -rf $TD_CLI_SRC_DIR/*
cd $TD_CLI_SRC_DIR && svn checkout https://sh-ssvn.sh.intel.com/empg_repos/svn_td/td/trunk/tdclient --username huangshx && svn checkout https://sh-ssvn.sh.intel.com/empg_repos/svn_td/td/trunk/build_framework --username huangshx
cd $TD_CLI_SRC_DIR/tdclient/tdclient/ && patch -p0 < /opt/tdcli.patch
cd $TD_CLI_SRC_DIR/tdclient/tdclient/libs/ && chmod +x build.ubuntu.sh && sed -i "s/BOOST_HOME=\(.*\)make$/BOOST_HOME=\1make -j$CPUCORES/g" build.ubuntu.sh && ./build.ubuntu.sh
cd $TD_CLI_SRC_DIR/tdclient/tdclient/linux/ && chmod +x build.ubuntu.sh && sed -i "s/BOOST_HOME=\(.*\)make$/BOOST_HOME=\1make -j$CPUCORES/g" build.ubuntu.sh && ./build.ubuntu.sh
cd $TD_CLI_SRC_DIR/tdclient/tdclient/linux/ui && chmod +x build.ubuntu.sh && ./build.ubuntu.sh

# package
cd $TD_CLI_RELEASE_DIR && tar jcf $OUT_DIR/tdcli_$TARGET.tar.bz2 *
