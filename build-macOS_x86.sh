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
    -Xswiftc "x86_64-apple-macosx11.0" \
    -Xcc "-arch" \
    -Xcc "x86_64" \
    -Xcc "--target=x86_64-apple-macosx11.0" \
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
