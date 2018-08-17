#!/system/bin/sh
# CopyLeft (C) OPENTHOS 2018

if [ ! -e /data/data/de.robv.android.xposed.task/conf/enabled_modules.list ]; then
  /system/bin/cp -a /de.robv.android.xposed.task /data/data/
  /system/bin/mkdir /data/data/de.robv.android.xposed.installer 
fi
