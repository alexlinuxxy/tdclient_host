FROM ubuntu:12.04
MAINTAINER "nikshuang@163.com"
RUN apt-get update && apt-get install git vim make autoconf automake gcc g++ bzip2 subversion -y
