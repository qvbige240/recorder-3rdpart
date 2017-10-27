#!/bin/bash

WORKDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "WORKDIR: $WORKDIR "
echo "BUILD_PATH: $BUILD_PATH "
#echo "${BASH_SOURCE[0]}"
#echo "$( dirname "${BASH_SOURCE[0]}" )"

export zlog_SRC=${WORKDIR}/zlog-1.2.7
export sqlite_SRC=${WORKDIR}/sqlite-autoconf-3190300
export jansson_SRC=${WORKDIR}/jansson-2.10
export curl_SRC=${WORKDIR}/curl-7.52.1
export libevent_SRC=${WORKDIR}/libevent-2.0.22-stable

# the include file of zlog needed attention
function build_zlog()
{
    echo "#####################    Build zlog   #####################"
    echo "   "
    #cd ${BUILD_PATH}
    #rm -rf *
    cd ${zlog_SRC}
    make clean
    make
    make PREFIX=${FINAL_PATH} install 
}

function build_sqlite()
{
    echo "#####################    Build sqlite   #####################"
    echo "   "
    echo "cd ${BUILD_PATH}"
    cd ${BUILD_PATH}
    rm -rf *
    ${sqlite_SRC}/configure --prefix=${FINAL_PATH} --host=$TARGETMACH \
        enable_threadsafe=yes
    make
    make install
}

function build_jansson()
{
    # need config
    echo "#####################    Build jansson   #####################"
    echo "   "
    echo "cd ${BUILD_PATH}"
    cd ${BUILD_PATH}
    rm -rf *
    ${jansson_SRC}/configure --prefix=${FINAL_PATH} --host=$TARGETMACH
    make
    make install
}

function build_curl()
{
    # nt966x use the target .so
    echo "#####################    Build curl   #####################"
    echo "   "
    echo "cd ${BUILD_PATH}"
    cd ${BUILD_PATH}
    rm -rf *
    #${curl_SRC}/configure --prefix=${FINAL_PATH} --host=$TARGETMACH --with-zlib
    ${curl_SRC}/configure --prefix=${FINAL_PATH} --host=$TARGETMACH --without-zlib 
    make
    make install
}

function build_libevent()
{
    echo "#####################    Build libevent   #####################"
    echo "   "
    echo "cd ${BUILD_PATH}"
    cd ${BUILD_PATH}
    rm -rf *
    #cd ${libevent_SRC}
    #${libevent_SRC}/autogen.sh
    ${libevent_SRC}/configure --prefix=${FINAL_PATH} --host=$TARGETMACH
    make
    #    make verify
    make install
}

build_sqlite
build_zlog
build_jansson
#build_curl
