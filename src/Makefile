ROOT_DIR = $(abspath ..)

include $(ROOT_DIR)/tasks/common.mk

BISON = bison -y

CFLAGS += -I$(ROOT_DIR)/src
SRCS := $(wildcard ../src/*.c)
OBJS := $(subst ..,$(BUILD_DIR), $(SRCS:.c=.o) ../src/parse.o)
DEPS := $(OBJS:.o=.d)

-include $(DEPS)

all : $(LIBMRUBY)

.PHONY : all

$(LIBMRUBY) : $(OBJS)
	-rm -f $(LIBMRUBY)
	$(AR) rcD $@ $(LIBMRUBY) $(OBJS)

$(BUILD_DIR)/src/parse.o: $(BUILD_DIR)/src/parse.c
	$(CC) $(CFLAGS) -MMD -c -o $@ $<

$(BUILD_DIR)/src/%.o: %.c
	$(CC) $(CFLAGS) -MMD -c -o $@ $<

$(BUILD_DIR)/src/parse.c: parse.y
	$(YACC) -o $@ $<

lex.def : keywords
	gperf -L ANSI-C -C -p -j1 -i 1 -g -o -t -N mrb_reserved_word -k'1,3,$' > lex.def
