# appdecrypt

Decrypt application encrypted binaries on macOS when SIP-enabled.

This works well and compiles for iOS nicely, if you want use it at iOS devices, you can use build-ios.sh (Thanks @dlevi309).

## How to use

### On mac with M1 CPU

```bash
> git clone https://github.com/paradiseduo/appdecrypt.git
> cd appdecrypt
> chmod +x build-macOS_arm.sh
> ./build-macOS_arm.sh
> cd .build/release
> ./appdecrypt
Version 2.0

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
> git clone https://github.com/paradiseduo/appdecrypt.git
> cd appdecrypt
> chmod +x build-iOS.sh
> ./build-iOS.sh
> scp -P 2222 global.xml root@127.0.0.1:/tmp
> cd .build/release
> scp -P 2222 appdecrypt root@127.0.0.1:/tmp

// In iPhone shell
> cd /tmp
> ldid -Sglobal.xml appdecrypt 
> ./appdecrypt
Version 2.0

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
> ./appdecrypt /var/containers/Bundle/Application/23E4B0B4-7275-46CE-8EEA-18CADE61FDB8 /tmp
Success to copy file.
Dump /var/containers/Bundle/Application/23E4B0B4-7275-46CE-8EEA-18CADE61FDB8/Aweme.app/Aweme Success
Dump /var/containers/Bundle/Application/23E4B0B4-7275-46CE-8EEA-18CADE61FDB8/Aweme.app/PlugIns/AwemeDYShareExtension.appex/AwemeDYShareExtension Success
Dump /var/containers/Bundle/Application/23E4B0B4-7275-46CE-8EEA-18CADE61FDB8/Aweme.app/PlugIns/AwemeNotificationService.appex/AwemeNotificationService Success
Dump /var/containers/Bundle/Application/23E4B0B4-7275-46CE-8EEA-18CADE61FDB8/Aweme.app/PlugIns/AwemeWidgetExtension.appex/AwemeWidgetExtension Success
Dump /var/containers/Bundle/Application/23E4B0B4-7275-46CE-8EEA-18CADE61FDB8/Aweme.app/PlugIns/AWEVideoWidget.appex/AWEVideoWidget Success
Dump /var/containers/Bundle/Application/23E4B0B4-7275-46CE-8EEA-18CADE61FDB8/Aweme.app/PlugIns/AwemeBroadcastExtension.appex/AwemeBroadcastExtension Success
Dump /var/containers/Bundle/Application/23E4B0B4-7275-46CE-8EEA-18CADE61FDB8/Aweme.app/PlugIns/AWEFriendsWidgets.appex/AWEFriendsWidgets Success
Dump /var/containers/Bundle/Application/23E4B0B4-7275-46CE-8EEA-18CADE61FDB8/Aweme.app/PlugIns/AwemeVideoNotification.appex/AwemeVideoNotification Success
Dump /var/containers/Bundle/Application/23E4B0B4-7275-46CE-8EEA-18CADE61FDB8/Aweme.app/Frameworks/ByteRtcEngineKit.framework/ByteRtcEngineKit Success
Dump /var/containers/Bundle/Application/23E4B0B4-7275-46CE-8EEA-18CADE61FDB8/Aweme.app/Frameworks/byteaudio.framework/byteaudio Success
> ls
Payload/
> cd Payload
> ls
Aweme.app/  BundleMetadata.plist  iTunesMetadata.plist
```

## Principle
This was discovered independently when analyzing kernel sources, but it appears that the technique was first introduced on iOS : 

https://github.com/JohnCoates/flexdecrypt

but now works on macOS:

https://github.com/meme/apple-tools/tree/master/foulplay



## Stargazers over time

[![Stargazers over time](https://starchart.cc/paradiseduo/appdecrypt.svg)](https://starchart.cc/paradiseduo/appdecrypt)

