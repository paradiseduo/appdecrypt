#!/bin/bash

set -e

NAME=appdecrypt

function build() {
  START=$(date +%s)

  swift build --product $NAME \
    -c release \
    -Xswiftc "-sdk" \
    -Xswiftc "$(xcrun --sdk iphoneos --show-sdk-path)" \
    -Xswiftc "-target" \
    -Xswiftc "arm64-apple-ios11.0" \
    -Xcc "-arch" \
    -Xcc "arm64" \
    -Xcc "--target=arm64-apple-ios11.0" \
    -Xcc "-isysroot" \
    -Xcc "$(xcrun --sdk iphoneos --show-sdk-path)" \
    -Xcc "-mios-version-min=10.0" \
    -Xcc "-miphoneos-version-min=11.0"

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
ldid -Sglobal.xml appdecrypt
