FROM debian:8.1
MAINTAINER "nikshuang@163.com"
RUN apt-get update && apt-get install git vim make automake gcc g++ wget -y
RUN git clone https://github.com/openssl/openssl.git /opt/openssl
RUN wget https://nchc.dl.sourceforge.net/project/boost/boost/1.49.0/boost_1_49_0.tar.bz2 -P /tmp && \
tar xf /tmp/boost_1_49_0.tar.bz2 -C /opt
VOLUME /opt
