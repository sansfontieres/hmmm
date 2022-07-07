#!/bin/sh -e

cd /tmp
git clone https://git.sr.ht/~technomancy/fennel
cd fennel

git checkout "$(git describe --tags `git rev-list --tags --max-count=1`)"

make
PREFIX="$HOME"/.local/fennel make install

mkdir -p "$HOME"/.config/vis/
cp fennel.lua "$HOME"/.config/vis

cd ..
rm -rf fennel

git clone https://git.sr.ht/~technomancy/fnlfmt
cd fnlfmt
make
cp fnlfmt "$HOME"/bin
