#!/bin/bash

set -e

NAME=appdecrypt
SDK_VERSION=11.0

function build() {
  START=$(date +%s)

  swift build --product $NAME \
    -c release \
    -Xswiftc "-sdk" \
    -Xswiftc "$(xcrun --sdk iphoneos --show-sdk-path)" \
    -Xswiftc "-target" \
    -Xswiftc "arm64-apple-ios$SDK_VERSION" \
    -Xcc "-arch" \
    -Xcc "arm64" \
    -Xcc "--target=arm64-apple-ios$SDK_VERSION" \
    -Xcc "-isysroot" \
    -Xcc "$(xcrun --sdk iphoneos --show-sdk-path)" \
    -Xcc "-mios-version-min=$SDK_VERSION" \
    -Xcc "-miphoneos-version-min=$SDK_VERSION"

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

# if ip is provided, send to the device in one go
if [ -n "$1" ]; then
  scp appdecrypt mobile@$1:/var/mobile/Documents/appdecrypt
fi
