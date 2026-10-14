#!/bin/sh
set -e

export VULKAN_SDK="/opt/vulkan/x86_64"
export PATH="${VULKAN_SDK}/bin:${PATH}"
export LD_LIBRARY_PATH="/opt/vulkan/x86_64/lib/VulkanLoader/lib:${VULKAN_SDK}/lib:${LD_LIBRARY_PATH}"

cmake -B build \
  -DCMAKE_BUILD_TYPE=Release \
  -DGGML_VULKAN=ON \
  -DBUILD_SHARED_LIBS=OFF \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
  -DVulkan_LIBRARY="/opt/vulkan/x86_64/lib/VulkanLoader/lib/libvulkan.so" \
  -DVulkan_INCLUDE_DIR="${VULKAN_SDK}/include"

cmake --build build --config Release -j $(nproc)

sudo cmake --install build