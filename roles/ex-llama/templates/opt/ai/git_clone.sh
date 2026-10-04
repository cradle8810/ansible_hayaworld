#!/bin/sh
set -e

BASE_DIR="/opt/ai/sources"
mkdir -p "$BASE_DIR"

# llama.cpp
LLAMA_DIR="$BASE_DIR/llama.cpp"
if [ ! -d "$LLAMA_DIR" ]; then
  git clone "https://github.com/ggml-org/llama.cpp.git" "$LLAMA_DIR"
else
  (cd "$LLAMA_DIR" && git fetch --all -p && git pull)
fi

# llama-swap
SWAP_DIR="$BASE_DIR/llama-swap"
if [ ! -d "$SWAP_DIR" ]; then
  git clone "https://github.com/mostlygeek/llama-swap.git" "$SWAP_DIR"
else
  (cd "$SWAP_DIR" && git fetch --all -p && git pull)
fi
