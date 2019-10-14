TARGET_DIR = $(ROOT_DIR)/target
BUILD_DIR = $(ROOT_DIR)/build/$(TARGET)
INCLUDE_DIR = $(ROOT_DIR)/include

EXEEXT = 
LIBEXT = .a

LIBMRUBY = $(BUILD_DIR)/lib/libmruby$(LIBEXT)

MRBC = $(ROOT_DIR)/build/$(TARGET)/bin/mrbc$(EXEEXT)
MRUBY = $(ROOT_DIR)/build/$(TARGET)/bin/mruby$(EXEEXT)

.DEFAULT_GOAL = all

clean :
	@rm -rf $(BUILD_DIR)/src/*
	@rm -rf $(BUILD_DIR)/lib/*
	@rm -rf $(BUILD_DIR)/bin/*

distclean :
	rm -rf $(BUILD_DIR)

.PHONY : clean distclean
