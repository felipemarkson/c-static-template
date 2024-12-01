# Static linkC

This project aims to create the tooling necessary to build and linked C and C++ programs and libraries in Linux avoiding license issues with GNU/GCC/GPL.

## Dependencies

You must have `clang` in your `PATH` env var (installed in your system).

## How to build

Just run `make` in the project root directory. You can also set the enviroment variable `PREFIX` (full path) to change the installation location, by default it is `./staticlinkc`. After that `musl libc` and the tooling should be under the `dist` folder.
```sh
PREFIX=/path/to/install/location make
```

## How to use

Check one of the examples
```sh
<PREFIX>/bin/musl-clang -o dist/examples/helloworld examples/helloworld.c
<PREFIX>/bin/musl-ldd dist/examples/helloworld
```

## Copyright and License

Static linkC is licensed under MIT License. Check `LICENSE` or `<PREFIX>/LICENSE` for more details.

musl libc has its own license. Check `musl/COPYRIGHT` or `<PREFIX>/musl-LICENSE` for more details.
