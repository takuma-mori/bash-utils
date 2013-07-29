#!/bin/sh
#
# show server statifications
# 
# description : 
#     show server statifications , disk memory processors
# role : only root
# env  : redhat-linux
#


# CONFIGURATIONS
_SPLITTER="---------------------------------------------------------";


if [ `id -u` != 0 ]; then
echo 'permission denied. only root can run';
    exit 1;
fi

# FUNCTION
echo_title() {
    echo ""
    echo ${_SPLITTER}
    echo ">> "$1
    if [ "x"$2 != "x" ]; then
        echo "    cmd : "$2;
    fi
    echo ${_SPLITTER}
}

# MAIN

# OS
_COMMAND_OS="cat /etc/redhat-release"
echo_title OS
eval ${_COMMAND_OS}

# Kernel version
_COMMAND_KERNEL="uname -a"
echo_title Kernel version
eval ${_COMMAND_KERNEL}

# MEMORY
_COMMAND_MEMORY="free"
echo_title Memory
eval ${_COMMAND_MEMORY}

# CPU
_COMMAND_CPU="cat /proc/cpuinfo | grep MHz"
echo_title CPU
eval ${_COMMAND_CPU}

# DISK SPACE USAGE
_COMMAND_DISK="df -h"
echo_title DISK_SPACE_USAGE
eval ${_COMMAND_DISK}

# RAID
_COMMAND_RAID="cat /proc/mdstat"
echo_title RAID
eval ${_COMMAND_RAID}