#!/bin/sh

#rm -fr build

VULKAN_SDK=/opt/vulkan/x86_64 cmake -B build \
  -DGGML_VULKAN=1 \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_CXX_FLAGS=-fPIC \
  -DCMAKE_C_FLAGS=-fPIC \
#  -DLLAMA_CCACHE=OFF \
  -DVulkan_LIBRARY=/opt/vulkan/x86_64/lib/VulkanLoader/lib/libvulkan.solibvulkan.so \
  -DVulkan_INCLUDE_DIR=/opt/vulkan/x86_64/include

cmake --build build --config Release -j $(nproc)

cd build/
sudo make install
