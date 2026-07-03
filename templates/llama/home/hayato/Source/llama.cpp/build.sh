#!/bin/sh

#rm -fr build

export VULKAN_SDK=/opt/vulkan/x86_64 

cmake -B build \
  -DGGML_VULKAN=1 \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_CXX_FLAGS=-fPIC \
  -DCMAKE_C_FLAGS=-fPIC \
  -DVulkan_LIBRARY=/opt/vulkan/x86_64/lib/VulkanLoader/lib/libvulkan.so \
  -DVulkan_INCLUDE_DIR=/opt/vulkan/x86_64/include

cmake --build build --config Release -j $(nproc)

cd build/
sudo make install
