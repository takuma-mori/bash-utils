#!/bin/sh
#
# convertImages
#
#

#------------------ FUNCTIONS -------------------
function usage () {
   echo "/bin/sh convertImages.sh [DIRECTORY] [QUALITY] [BACKUO_DIRECTORY]";
}

#------------------ INITIALIZE ------------------
# check number of arguments
if [ $# != 3 ]; then
    usage;
    exit 1;
fi

# check $1 is directory
if [ ! -d $1 ]; then
   usage;
   exit 1;
fi

_DIRECTORY=$(cd $(dirname $1);pwd)"/"$(basename $1)
_QUALITY=$2
_BACKUP_DIRECTORY=$3

# create backup directory
mkdir ${_BACKUP_DIRECTORY}
if [ $? -eq 1 ]; then
    exit 1;
fi

#------------------ MAIN ------------------------
for file in $(find ${_DIRECTORY} -type f |  egrep -i "\.jpg|\.png|\.bmp|\.gif"); do
    # backup
    cp $file backup/$(basename $file)

    filesize_before=$(du -b $file | awk '{print $1}')
    echo -n "REGULAR    : "
    echo "size : "$filesize_before", file : "$file;

    # commpress
    mogrify -quality $2 $file
    filesize_after=$(du -b $file | awk '{print $1}')
    echo -n "COMPLESSED : "
    echo "size : "$filesize_after", file : "$file;

    # if compressed file size is bigger than regular, rollback
    if [ $filesize_before -lt $filesize_after ]; then
         echo "WARN       : commpressed file size is bigger than regular, rollback done..."
         cp backup/$(basename $file) $file
    fi
    echo
done
