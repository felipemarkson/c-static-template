CC = clang
CPP = clang++
SRC_DIR = src
OUT_DIR = out
OBJS_DIR = $(OUT_DIR)/objs
# DEBUG = 1

CFLAGS   = -Wall -Wextra -Wno-unused-command-line-argument -flto -fuse-ld=lld --rtlib=compiler-rt -nodefaultlibs
CLINKS   = -l:libc.a -l:libm.a
CPPFLAGS = -stdlib=libc++ $(CFLAGS)
CPPLINKS =  $(CLINKS) -l:libc++.a -l:libc++abi.a -l:libunwind.a

ifdef DEBUG
	CFLAGS := -O1 -ggdb
	STRIP  := touch  # disable strip
else
	CFLAGS := -O3
	STRIP  := strip  # enable strip
endif


all: $(OUT_DIR)/helloworld_cpp $(OUT_DIR)/helloworld_c

clean:
	rm  -rf out/*

.PHONY: all clean

$(OBJS_DIR)/helloworld_cpp.o: $(SRC_DIR)/helloworld.cpp
	mkdir -p out/objs
	$(CPP) $(CPPFLAGS) -o $@ -c $<

$(OBJS_DIR)/helloworld_c.o: $(SRC_DIR)/helloworld.c
	mkdir -p out/objs
	$(CC)  $(CFLAGS)   -o $@ -c $<

$(OUT_DIR)/helloworld_cpp: $(OBJS_DIR)/helloworld_cpp.o
	$(CPP) $(CPPFLAGS) -static  -o $@ $< $(CPPLINKS)
	$(STRIP) $@

$(OUT_DIR)/helloworld_c: $(OBJS_DIR)/helloworld_c.o
	$(CC) $(CFLAGS) -static -o $@ $<  $(CLINKS)
	$(STRIP) $@