#!/bin/sh
set -e

PLAN9="/usr/local/plan9"

sudo git clone https://github.com/9fans/plan9port $PLAN9
cd $PLAN9
sudo ./INSTALL
