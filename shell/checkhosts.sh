#!/bin/sh
# 
# ping /etc/hosts
#

#------------------ FUNCTIONS -------------------
function usage() {
    echo "hostscheck.sh [PING_COUNT] [TIMEOUT(seconds)]"
}

#------------------ INITALIZE -------------------
if [ $# != 2 ]; then
    usage;
    exit 1;
fi

_COUNT=$1
_TIMEOUT=$2
_OUTPUT=/dev/null
_SUCCESS_LIST=""
_FAILED_LIST=""

#------------------ MAIN ------------------------
for ipAddr in `cat /etc/hosts | grep -v "#" | sed '/^ *$/d' | awk '{print $2}'`
do
   domain=`cat /etc/hosts | grep ${ipAddr} | tail -n 1 | awk '{print $1}'`
   echo "#----- "${ipAddr}"-----"
   echo "> ID : "${domain}
   echo -n "> PING : "
   rtt=`ping -c ${_COUNT} -W ${_TIMEOUT} ${ipAddr} | grep rtt`
   if [ $? -eq 0 ]; then
     echo "OK";
     _SUCCESS_LIST=${_SUCCESS_LIST}${ipAddr}"     "${domain}"\n"
   else
     echo "NG";
     _FAILED_LIST=${_FAILED_LIST}${ipAddr}"     "${domain}"\n"
   fi
   echo "> RTT : "${rtt}
   echo
done

echo "SUCCESS"
echo -e ${_SUCCESS_LIST}

echo "FAILED"
echo -e ${_FAILED_LIST}