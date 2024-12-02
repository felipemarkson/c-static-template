#!/bin/sh
docker build -t builder . 1>/dev/null
docker run -it -v .:/devel builder