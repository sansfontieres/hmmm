#!/bin/sh -e

QUERY="$(uname)-$(uname -m)"

INFOS=`curl -s https://ziglang.org/download/index.json | grep -iA1 "builds/zig-$QUERY" | awk '{print $2}' | sed 's/[",]//g'`

URL=`printf "%s" "$INFOS" | sed 1q`
SHASUM=`printf "%s" "$INFOS" | sed -n 2p`

printf "Downloading latest’s build tarball...\n"
curl --progress-bar "$URL" -o /tmp/zig.tar.xz

printf "Comparing checksums...\n"
if ! printf "%s /tmp/zig.tar.xz" "$SHASUM" | sha256sum --check --status ; then
    printf "Checksum failed\n"
    exit 1
fi

printf "Replacing the old zig installation...\n"
rm -rf "$HOME"/.local/zig
mkdir -p "$HOME"/.local/zig
tar -xvJf /tmp/zig.tar.xz -C "$HOME"/.local/zig --strip-components=1

printf "DONE\n"
which zig
zig version
