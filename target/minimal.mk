include $(ROOT_DIR)/tasks/gcc.mk

CDEFS += -DDISABLE_GEMS
export CDEFS

all : $(MRUBY)

.PHONY : all

mrbc : $(MRBC)

.PHONY : mrbc
