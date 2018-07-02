#!/system/bin/sh
# CopyLeft (C) OPENTHOS 2018

if [ ! -e /data/data/de.robv.android.xposed.installer/conf/enabled_modules.list ]; then
  /system/bin/cp -a /de.robv.android.xposed.installer /data/data/
fi
