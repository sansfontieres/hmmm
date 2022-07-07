#!/bin/sh -e

cd /tmp
git clone https://github.com/janet-lang/janet
cd janet

git checkout "$(git describe --tags `git rev-list --tags --max-count=1`)"

make
make test
PREFIX="$HOME"/.local/janet make install

cd ..
rm -rf janet
