#
# Copyright (C) 2018 The Android-x86 Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := $(notdir $(LOCAL_PATH))
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_BUILT_MODULE_STEM := package.apk
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MULTILIB := $(if $(TARGET_2ND_ARCH),both,first)
LOCAL_LIBS := $(shell zipinfo -1 $(LOCAL_PATH)/$(LOCAL_SRC_FILES) | grep ^lib/ | grep -v /$$)
LOCAL_PREBUILT_JNI_LIBS_$(TARGET_ARCH) := $(addprefix @,$(filter lib/$(TARGET_ARCH)/%,$(LOCAL_LIBS)))
LOCAL_PREBUILT_JNI_LIBS_$(TARGET_2ND_ARCH) := $(addprefix @,$(filter lib/$(TARGET_2ND_ARCH)/%,$(LOCAL_LIBS)))

LOCAL_PRIVILEGED_MODULE := false
LOCAL_OVERRIDES_PACKAGES := webview
LOCAL_DEX_PREOPT := true
LOCAL_REQUIRED_MODULES := libwebviewchromium_loader libwebviewchromium_plat_support

include $(BUILD_PREBUILT)
