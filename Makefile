PREFIX := /usr
LIBVNCSERVER_PREFIX := /usr

ifdef THEOS

TARGET = iphone:clang:11.4:10.0

include $(THEOS)/makefiles/common.mk

TOOL_NAME = screendumpd
$(TOOL_NAME)_FILES = main.mm
$(TOOL_NAME)_FRAMEWORKS := IOSurface IOKit
$(TOOL_NAME)_PRIVATE_FRAMEWORKS := IOMobileFramebuffer IOSurface
$(TOOL_NAME)_OBJCFLAGS += -I$(LIBVNCSERVER_PREFIX)/include
$(TOOL_NAME)_LDFLAGS += -Wl,-segalign,4000,-stack_size,100000 -L$(LIBVNCSERVER_PREFIX)/lib -lvncserver
$(TOOL_NAME)_CFLAGS = -w
$(TOOL_NAME)_CODESIGN_FLAGS = "-Sen.plist"
$(TOOL_NAME)_INSTALL_PATH = $(PREFIX)/libexec
export ARCHS = arm64
$(TOOL_NAME)_ARCHS = arm64

include $(THEOS_MAKE_PATH)/tool.mk

endif  # <-- Add this line

else

all:
	@echo "Please manually compile it by `$$(IOS_CLANG) -x objective-c++ main.mm -w -Wl,-segalign,4000,-stack_size,100000 -lvncserver`"

endif  # <-- This line closes the 'else' block
