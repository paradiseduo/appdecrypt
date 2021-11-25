#!/bin/bash

set -e

NAME=appdecrypt

function build() {
  START=$(date +%s)

  swift build --product $NAME \
    -c release \
    -Xswiftc "-sdk" \
    -Xswiftc "$(xcrun --sdk macosx --show-sdk-path)" \
    -Xswiftc "-target" \
    -Xswiftc "arm64-apple-macosx11.0" \
    -Xcc "-arch" \
    -Xcc "arm64" \
    -Xcc "--target=arm64-apple-macosx11.0" \
    -Xcc "-isysroot" \
    -Xcc "$(xcrun --sdk macosx --show-sdk-path)"

  END=$(date +%s)
  TIME=$(($END - $START))
  echo "build in $TIME seconds"
}

function main() {
  build
}

main

mv .build/release/appdecrypt .
chmod +x appdecrypt
