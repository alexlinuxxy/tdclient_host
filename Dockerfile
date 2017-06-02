FROM ubuntu:12.04
MAINTAINER "nikshuang@163.com"
RUN apt-get update && apt-get install git vim make autoconf automake gcc g++ subversion zlib1g-dev libtool -y
ADD https://nchc.dl.sourceforge.net/project/boost/boost/1.49.0/boost_1_49_0.tar.bz2 /opt/
RUN git clone https://github.com/openssl/openssl.git /opt/openssl
COPY prebuild.sh /opt/
COPY 30proxy /etc/apt/apt.conf.d/30proxy
RUN tar xf /opt/boost_1_49_0.tar.bz2 -C /opt/ && rm -f /opt/boost_1_49_0.tar.bz2
