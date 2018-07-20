LOCAL_PATH:= $(call my-dir)

#include $(CLEAR_VARS)
#LOCAL_MODULE := prepair_external_apk
#LOCAL_MODULE_CLASS := ETC
#LOCAL_SRC_FILES := preinstalled.list $(shell $(LOCAL_PATH)/loadapks.sh > /dev/null)
#include $(BUILD_PREBUILT)

#manager_apk := $(patsubst $(LOCAL_PATH)/%,%,$(wildcard $(LOCAL_PATH)/*.apk))
manager_apk := $(shell $(LOCAL_PATH)/loadapks.sh)

$(foreach f,$(manager_apk), \
  $(eval include $(CLEAR_VARS)) \
  $(eval LOCAL_MODULE := $(notdir $(f))) \
  $(eval LOCAL_MODULE_TAGS := optional) \
  $(eval LOCAL_MODULE_CLASS := ETC) \
  $(eval LOCAL_MODULE_PATH := $(TARGET_OUT)/preinstall) \
  $(eval LOCAL_SRC_FILES   := $(f)) \
  $(eval include $(BUILD_PREBUILT)) \
  $(eval ALL_DEFAULT_INSTALLED_MODULES += $(f)) \
)

