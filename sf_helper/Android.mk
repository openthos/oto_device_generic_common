LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
    sf_helper.c

LOCAL_MODULE := sf_helper

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    liblog

include $(BUILD_EXECUTABLE)

