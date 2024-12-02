FROM alpine:latest AS base
RUN apk update && apk upgrade && \
    apk add file musl-dev clang make lld compiler-rt libc++-dev libc++-static llvm-libunwind-static

FROM base
WORKDIR /devel
CMD ["/bin/sh"]
