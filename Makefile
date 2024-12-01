ifndef PREFIX
	PREFIX=$(shell pwd)/staticlinkc
endif

all: musl examples README.md LICENSE
	cp README.md $(PREFIX)/
	cp LICENSE $(PREFIX)/
	cp musl/COPYRIGHT $(PREFIX)/musl-COPYRIGHT
	cp musl/README $(PREFIX)/musl-README

examples: $(PREFIX)/examples/helloworld

musl: $(PREFIX)/bin/musl-clang

clean:
	cd musl && make clean

.PHONY: all examples musl clean


$(PREFIX)/bin/musl-clang:
	cd musl && CC=clang ./configure --prefix=$(PREFIX) --syslibdir=$(PREFIX)/lib && make -j$(shell nproc) && make -j$(shell nproc) install
	ln -s $(PREFIX)/lib/libc.so $(PREFIX)/bin/musl-ldd

$(PREFIX)/examples/helloworld: $(PREFIX)/bin/musl-clang examples/helloworld.c
	mkdir -p $(PREFIX)/examples
	$(PREFIX)/bin/musl-clang -o $(PREFIX)/examples/helloworld examples/helloworld.c

