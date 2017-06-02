#!/bin/bash

BOOST=boost-1.49.0
OPENSSL=openssl-1.0.1c
BOOST_DIR=/opt/$BOOST
OPENSSL_DIR=/opt/$OPENSSL
CPUCORES=$((`cat /proc/cpuinfo | grep processor | wc -l` * 2))

find $BOOST_DIR -name *.sh | xargs -I{} chmod +x {}
cd $BOOST_DIR && ./bootstrap.sh && b2 -j$CPUCORES
cd $OPENSSL_DIR && ./config && make -j$CPUCORES

export LIBRARY_PATH=$BOOST_DIR:$OPENSSL_DIR

bash
