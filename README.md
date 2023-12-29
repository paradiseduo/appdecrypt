# appdecrypt
Decrypt application's encrypted binaries on macOS when SIP-enabled (macOS 11.2.3 or below). *Even if it can decrypt all applications, some iOS apps won't be possible to run on the mac, even after decryption.*

This works well and compiles for iOS nicely, if you want use it at iOS devices, you can use build-ios.sh (Thanks @dlevi309).

## How to use

### On mac with M1 CPU

```bash
> git clone https://github.com/paradiseduo/appdecrypt.git
> cd appdecrypt
> chmod +x build-macOS_arm.sh
> ./build-macOS_arm.sh
> ./appdecrypt
Version 2.1

appdecrypt is a tool to make decrypt application encrypted binaries on macOS when SIP-enabled.

Examples:
    mac:
        appdecrypt /Application/Test.app /Users/admin/Desktop/Test.app
    iPhone:
        appdecrypt /var/containers/Bundle/Application/XXXXXX /tmp

USAGE: appdecrypt encryptMachO_Path decryptMachO_Path

ARGUMENTS:
  <encryptApp_Path>     The encrypt app file path.
  <decrypt_Path>        The path output file.

OPTIONS:
  -h, --help              Show help information.
  --ignore-ios-check      Decrypt the app even if M1 can't run it.
```

#### For Example

```bash
> ./appdecrypt /Applicaiton/Test.app /Users/admin/Desktop/Test.app
Success to copy file.
Dump /Applications/Test.app/Wrapper/Test.app/Test Success
Dump /Applications/Test.app/Wrapper/Test.app/PlugIns/TestNotificationService.appex/TestNotificationService Success
Dump /Applications/Test.app/Wrapper/Test.app/Frameworks/trackerSDK.framework/trackerSDK Success
Dump /Applications/Test.app/Wrapper/Test.app/Frameworks/AgoraRtcKit.framework/AgoraRtcKit Success
> cd /Users/admin/Desktop/Test.app
> ls
WrappedBundle Wrapper
> cd Wrapper
> ls
BundleMetadata.plist Test.app            iTunesMetadata.plist
```

### On Jailbreak iPhone with arm64 CPU

First you should connect jailbreak iPhone with USB.
```bash
> brew install ldid
> git clone https://github.com/paradiseduo/appdecrypt.git
> cd appdecrypt
> chmod +x build-iOS.sh
> ./build-iOS.sh
> scp -P 2222 appdecrypt root@127.0.0.1:/tmp

// In iPhone shell
> cd /tmp
> ./appdecrypt
Version 2.1

appdecrypt is a tool to make decrypt application encrypted binaries on macOS when SIP-enabled.

Examples:
    mac:
        appdecrypt /Applicaiton/Test.app /Users/admin/Desktop/Test.app
    iPhone:
        appdecrypt /var/containers/Bundle/Application/XXXXXX /tmp

USAGE: appdecrypt encryptMachO_Path decryptMachO_Path

ARGUMENTS:
  <encryptApp_Path>     The encrypt app file path.
  <decrypt_Path>        The path output file.

OPTIONS:
  -h, --help              Show help information.
```

#### For Example
```bash
// In iPhone shell
> ./appdecrypt /var/containers/Bundle/Application/5B5D4E97-E760-4AC5-BFEE-F0FF72EBB19E /tmp
Success to copy file.
Dump /var/containers/Bundle/Application/5B5D4E97-E760-4AC5-BFEE-F0FF72EBB19E/KingsRaid.app/KingsRaid Success
Dump /var/containers/Bundle/Application/5B5D4E97-E760-4AC5-BFEE-F0FF72EBB19E/KingsRaid.app/Frameworks/FBSDKGamingServicesKit.framework/FBSDKGamingServicesKit Success
Dump /var/containers/Bundle/Application/5B5D4E97-E760-4AC5-BFEE-F0FF72EBB19E/KingsRaid.app/Frameworks/FBLPromises.framework/FBLPromises Success
Dump /var/containers/Bundle/Application/5B5D4E97-E760-4AC5-BFEE-F0FF72EBB19E/KingsRaid.app/Frameworks/FBSDKShareKit.framework/FBSDKShareKit Success
Dump /var/containers/Bundle/Application/5B5D4E97-E760-4AC5-BFEE-F0FF72EBB19E/KingsRaid.app/Frameworks/GoogleUtilities.framework/GoogleUtilities Success
Dump /var/containers/Bundle/Application/5B5D4E97-E760-4AC5-BFEE-F0FF72EBB19E/KingsRaid.app/Frameworks/FBSDKLoginKit.framework/FBSDKLoginKit Success
Dump /var/containers/Bundle/Application/5B5D4E97-E760-4AC5-BFEE-F0FF72EBB19E/KingsRaid.app/Frameworks/nanopb.framework/nanopb Success
Dump /var/containers/Bundle/Application/5B5D4E97-E760-4AC5-BFEE-F0FF72EBB19E/KingsRaid.app/Frameworks/FBSDKCoreKit.framework/FBSDKCoreKit Success
Dump /var/containers/Bundle/Application/5B5D4E97-E760-4AC5-BFEE-F0FF72EBB19E/KingsRaid.app/Frameworks/Protobuf.framework/Protobuf Success
> cd Payload
> ls
BundleMetadata.plist  KingsRaid.app/  iTunesMetadata.plist
> tar -cvf /tmp/dump.tar ./


// In mac shell
> cd ~/Desktop
> scp -P 2222 root@127.0.0.1:/tmp/dump.tar .
dump.tar
```

## Principle
This was discovered independently when analyzing kernel sources, but it appears that the technique was first introduced on iOS : 

https://github.com/JohnCoates/flexdecrypt

but now works on macOS:

https://github.com/meme/apple-tools/tree/master/foulplay


## LICENSE

This software is released under the GPL-3.0 license.


## Stargazers over time

[![Stargazers over time](https://starchart.cc/paradiseduo/appdecrypt.svg)](https://starchart.cc/paradiseduo/appdecrypt)

