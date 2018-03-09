#
# Copyright (C) 2017 The Android-x86 Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := Fennec
LOCAL_SRC_FILES := fennec-58.0.zh-CN.android-i686.apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_MODULE_TAGS := optional
LOCAL_CERTIFICATE := PRESIGNED
#LOCAL_OVERRIDES_PACKAGES := Browser

LOCAL_LIBS := $(shell zipinfo -1 $(LOCAL_PATH)/$(LOCAL_SRC_FILES) | grep ^lib/ | grep -v /$$)
LOCAL_MODULE_TARGET_ARCH := x86
LOCAL_PREBUILT_JNI_LIBS := $(addprefix @,$(filter lib/$(LOCAL_MODULE_TARGET_ARCH)/%,$(LOCAL_LIBS)))

include $(BUILD_PREBUILT)

