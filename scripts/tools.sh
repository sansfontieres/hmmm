#!/bin/sh

mkdir -p tools
git clone https://git.sansfontieres.com/~romi/esper tools/esper

set -e

cd tools/esper
zig build -Drelease-safe
cp zig-out/bin/* "$HOME"/bin
cp bin/* "$HOME"/bin
