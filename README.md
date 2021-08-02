# appdecrypt

Decrypt application encrypted binaries on macOS when SIP-enabled.

This works well and compiles for iOS nicely, if you want use it at iOS devices, you can use ios branch. Thanks @dlevi309.

## How to use

```bash
Version 1.0

appdecrypt is a tool to make decrypt application encrypted binaries on macOS when SIP-enabled.

Examples:
    appdecrypt /Applicaiton/Test.app/Wrapper/Test.app/Test /Users/admin/Desktop/Test

USAGE: appdecrypt encryptMachO_Path decryptMachO_Path

ARGUMENTS:
  <encryptMachO_Path>     The encrypt machO file path.
  <decryptMachO_Path>     The path output decrypt machO file.

OPTIONS:
  -h, --help              Show help information.
```

## Principle
This was discovered independently when analyzing kernel sources, but it appears that the technique was first introduced on iOS : 

https://github.com/JohnCoates/flexdecrypt

but now works on macOS:

https://github.com/meme/apple-tools/tree/master/foulplay
