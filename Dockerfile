FROM debian:8.1
MAINTAINER "nikshuang@163.com"
RUN apt-get update && apt-get install git vim make automake gcc g++ wget -y
WORKDIR /opt
RUN git clone https://github.com/openssl/openssl.git && git clone https://github.com/boostorg/boost.git
WORKDIR /
VOLUME /opt
