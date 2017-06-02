FROM ubuntu:12.04
MAINTAINER "nikshuang@163.com"
RUN apt-get update && apt-get install git vim make automake gcc g++ wget bzip2 -y
RUN git clone https://github.com/openssl/openssl.git /opt/openssl && wget https://nchc.dl.sourceforge.net/project/boost/boost/1.49.0/boost_1_49_0.tar.bz2 && tar xf boost_1_49_0.tar.bz2 -C /opt
RUN apt-get install subversion -y
