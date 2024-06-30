#!/usr/bin/env bash

#Change the current working directory
cd "`dirname "$0"`"

echo "Booting FakeFS iOS 15.0 to 15.8.2..."
sleep 2

./palera1n-macos-universal -p

sleep 3

./palera1n-macos-universal -f
