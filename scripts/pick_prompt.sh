#!/bin/sh
set -e

if command -v fpc;then
	fpc -O2 prompt
	cp prompt "$HOME"/bin
elif command -v zig; then
	zig build-exe -Drelease-safe prompt.zig
	cp zig-out/bin/prompt "$HOME"/bin
else
	echo "printf '; '" > "$HOME"/bin/prompt
fi
