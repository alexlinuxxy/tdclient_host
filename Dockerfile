FROM debian:8.1
MAINTAINER "nikshuang@163.com"
RUN apt-get update && apt-get install git vim make automake gcc g++ wget -y
RUN git clone https://github.com/openssl/openssl.git /opt/openssl
RUN apt-get install bzip2 -y && wget https://nchc.dl.sourceforge.net/project/boost/boost/1.49.0/boost_1_49_0.tar.bz2 -P /tmp && \
tar -jxf /tmp/boost_1_49_0.tar.bz2 -C /opt
WORKDIR /opt/openssl
RUN git checkout OpenSSL_1_0_1c && ./config && make
WORKDIR /opt/boost_1_49_0 
RUN ./bootstrap.sh && ./b2 && ln -s /opt/boost_1_49_0/stage/lib /opt/boost_1_49_0/stage/lib/debian
VOLUME /opt
