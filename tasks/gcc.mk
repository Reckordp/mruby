CC := gcc
CFLAGS = -g -O3 -Wall -Wundef -I $(ROOT_DIR)/include -std=gnu99 -Wdeclaration-after-statement -Werror-implicit-function-declaration $(CDEFS)
export CFLAGS CCFLAGS
