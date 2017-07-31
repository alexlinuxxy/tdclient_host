#!/bin/bash

LSB=$1
CONTAINER=tdcli_$LSB

docker run -it --name $CONTAINER -v ~/work:/mnt --net host -h $CONTAINER alexlinuxxy/tdclient_host:$LSB bash
