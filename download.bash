#!/bin/bash

curl -u "$2:$3" -L "https://download.maxmind.com/geoip/databases/GeoLite2-${1}/download?suffix=tar.gz" -o GeoLite2-${1}.tar.gz
curl -u "$2:$3" -L "https://download.maxmind.com/geoip/databases/GeoLite2-${1}/download?suffix=tar.gz.sha256" -o GeoLite2-${1}.tar.gz.sha256

SHA256=`cat GeoLite2-${1}.tar.gz.sha256 | grep ${1} | cut -d " " -f 1`

CHECK_SHA256=`sha256sum GeoLite2-${1}.tar.gz | grep ${1} | cut -d " " -f 1`

if [[ $SHA256 == $CHECK_SHA256 ]]
then
    tar -zxf GeoLite2-${1}.tar.gz
    mv GeoLite2-*/GeoLite2-${1}.mmdb .
    rm -rf GeoLite2-${1}_* GeoLite2-${1}.tar.gz.sha256
else
    exit 1
fi
