#!/bin/bash
[ "$TRAVIS_CI" != "" ] && sudo apt-get install clang -y -qq || true

# output version
bash printinfo.sh

make clean > /dev/null

scan_build=$(which scan-build)
[ -z "$scan_build" ] && scan_build=$(find /usr/share/clang* -type f -name scan-build) || true
[ -z "$scan_build" ] && { echo "couldn't find clang scan-build"; exit 1; } || true
$scan_build make -f makefile.unix all
