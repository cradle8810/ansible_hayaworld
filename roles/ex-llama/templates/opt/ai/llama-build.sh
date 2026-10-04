#!/bin/sh

#rm -fr build

cmake -B build \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_CXX_FLAGS=-fPIC \
  -DCMAKE_C_FLAGS=-fPIC \
  -DCMAKE_INSTALL_PREFIX=/opt/ai/mnt/binaries

cmake --build build --config Release -j $(nproc)

cd build/
sudo make install
