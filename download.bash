#!/bin/bash

wget -q "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-${1}&license_key=${2}&suffix=tar.gz" -O GeoLite2-${1}.tar.gz
wget -q "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-${1}&license_key=${2}&suffix=tar.gz.sha256" -O GeoLite2-${1}.tar.gz.sha256
SHA256=`cat GeoLite2-${1}.tar.gz.sha256 | grep ${1} |cut -d " " -f 1`
rm -rf GeoLite2-${1}.tar.gz.sha256
CHECK_SHA256=`sha256sum GeoLite2-${1}.tar.gz | grep ${1} |cut -d " " -f 1`

if [[ $SHA256 == $CHECK_SHA256 ]]
then
    tar -zxf GeoLite2-${1}.tar.gz
    mv GeoLite2-*/GeoLite2-${1}.mmdb .
    rm -rf GeoLite2-${1}_*
else
    exit 1
fi
