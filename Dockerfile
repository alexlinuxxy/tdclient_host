FROM debian:8.1
MAINTAINER "nikshuang@163.com"
RUN apt-get update && apt-get install git vim make automake gcc g++ wget -y
RUN mkdir /opt
WORKDIR /opt
RUN git clone https://github.com/openssl/openssl.git && git clone https://github.com/boostorg/boost.git
WORKDIR /opt/boost
RUN get checkout -b 1.49.0 boost-1.49.0 && ./bootstrap.sh && ./b2
WORKDIR /opt/openssl
RUN get checkout -b 1.0.1c OpenSSL_1_0_1c && ./config && make
WORKDIR /opt

VOLUME /opt
