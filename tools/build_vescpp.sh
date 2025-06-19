#! /bin/bash

VESCPP="../src/explorer_ws/explorer_stack/libs/orthopus_vesc/lib/vescpp/"

cd "$VESCPP"
if [ -d build ]; then
    rm -rf build
fi
mkdir build
cmake . -B build
make -C build -j8 vescpp_cli
