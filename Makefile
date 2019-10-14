ROOT_DIR = $(abspath .)

RAKE = rake
TARGET = minimal

include $(ROOT_DIR)/tasks/common.mk

TEST = $(ROOT_DIR)/build/$(TARGET)/bin/mrbtest$(EXEEXT)

TEST_SRC = $(wildcard $(ROOT_DIR)/tools/mrbtest/*.c)
TEST_OBJ = $(subst $(ROOT_DIR)/tools,$(BUILD_DIR),$(TEST_SRC))
TEST_DEP = $(TEST_OBJ:.o=.d)

include $(TARGET_DIR)/$(TARGET).mk

OPTIONS = 
$(foreach OPTION,$(OPTIONS),$(eval $(include $(ROOT_DIR)/tasks/$(OPTION).mk)))

MRBC_SRC = $(wildcard $(ROOT_DIR)/tools/mrbc/*.c)
MRBC_OBJ = $(subst $(ROOT_DIR)/tools/mrbc,$(BUILD_DIR),$(MRBC_SRC:.c=.o))
MRBC_DEP = $(MRBC_OBJ:.o=.d)

$(MRBC) : $(LIBMRUBY) $(MRBC_OBJ)
	@mkdir -p $(BUILD_DIR)/bin
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(MRBC_OBJ) $(LIBMRUBY) -lm

$(BUILD_DIR)/mrbc.o: $(ROOT_DIR)/tools/mrbc/mrbc.c
	$(CC) $(CFLAGS) -c -o $@ $<

-include $(MRBC_DEPS)

MRUBY_SRC = $(wildcard $(ROOT_DIR)/tools/mruby/*.c)
MRUBY_OBJ = $(subst $(ROOT_DIR)/tools/mruby,$(BUILD_DIR),$(MRUBY_SRC:.c=.o))
MRUBY_DEP = $(MRUBY_OBJ:.o=.d)

$(MRUBY) : libmruby $(MRUBY_OBJ)
	@mkdir -p $(BUILD_DIR)/bin
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(MRUBY_OBJ) $(LIBMRUBY) -lm

$(BUILD_DIR)/mruby.o: $(ROOT_DIR)/tools/mruby/mruby.c
	$(CC) $(CFLAGS) -c -o $@ $<

-include $(MRUBY_DEPS)

MRBLIB_RB  = $(sort $(wildcard $(ROOT_DIR)/mrblib/*.rb))
MRBLIB_SRC = $(BUILD_DIR)/mrblib.c
MRBLIB_OBJ = $(MRBLIB_SRC:.c=.o)

$(MRBLIB_SRC) : $(MRBLIB_RB)
	cp $(ROOT_DIR)/mrblib/init_mrblib.c $(MRBLIB_SRC)
	$(MRBC) -Bmrblib_irep -o- $(MRBLIB_RB) >> $(MRBLIB_SRC)

$(MRBLIB_OBJ) : $(MRBLIB_SRC)
	$(CC) $(CFLAGS) -c -o $@ $<

libmruby : $(MRBC) $(LIBMRUBY) $(MRBLIB_OBJ)
	$(AR) r $(LIBMRUBY) $(MRBLIB_OBJ)

$(LIBMRUBY) :
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)/src
	@mkdir -p $(BUILD_DIR)/lib
	make -C src all TARGET=$(TARGET)

-include $(TEST_DEPS)
