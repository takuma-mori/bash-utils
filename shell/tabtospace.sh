#!/bin/bash
#
# thisis charactor replace script.
# tag charactor replaced to space charactor
#

# ------------- FUNCTIONS ---------------
function usage() {
    echo "/bin/sh tabtospace [TAB_NUMBER] [SOURTH_DIRECTORY] [DISTINATION_DIRECTORY]";
}

function createDirectory() {
    if [ -d ${_DESTINATION_DIRECTORY} ]; then
        echo ${_DESTINATION_DIRECTORY}" is already exists";
        exit 1;
    fi
    mkdir -p ${_DESTINATION_DIRECTORY}
}
 
function replace() {
    for file in `ls ${_SOURCE_DIRECTORY}`
    do
        if [ -f ${file} ]; then
            `expand -${_TAB_NUMBER} ${file} > ./${_DESTINATION_DIRECTORY}/${file}`
            echo -n ${file}":"
            if [ $? == 0 ];then
                echo "successed";
            else
                echo "failed"
            fi
        fi
    done
}

#------------------ INITIALIZE ------------------
if [ $# != 3 ]; then
    usage;
    exit 1;
fi

readonly _TAB_NUMBER=$1
readonly _SOURCE_DIRECTORY=$2
readonly _DESTINATION_DIRECTORY=$3

#------------------ MAIN ------------------------
createDirectory
replace
