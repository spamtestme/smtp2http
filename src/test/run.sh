#!/bin/bash

. /init.sh

function setHostAlias(){
    local hostip=$(ip route show | awk '/default/ {print $3}')
    echo $hostip 'host.docker.internal' >> /etc/hosts
}

setHostAlias
main
