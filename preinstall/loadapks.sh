#!/bin/sh
LOCAL_PATH=`dirname $0`
URI_BASE=http://192.168.0.180/openthos/preinstall
APKLIST=applist
rm $LOCAL_PATH/*.apk 2>/dev/null
curl  $URI_BASE/$APKLIST 2>/dev/null | \
  while read line; do
    file=`echo $line | awk '{print $1}'`
    wget -P $LOCAL_PATH $URI_BASE/$file 1>&2 
    printf "$file "
  done
