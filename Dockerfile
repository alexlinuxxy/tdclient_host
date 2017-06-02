FROM ubuntu:12.04
MAINTAINER "nikshuang@163.com"
RUN apt-get update && apt-get install vim make autoconf automake gcc g++ subversion zlib1g-dev -y
ADD boost_1_49_0.tar.bz2 /opt
ADD openssl-1.0.1c.zip /opt/openssl-1.0.1c
ADD prebuild.sh	/opt
