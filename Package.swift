// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "appdecrypt",
    products: [
        .executable(
            name: "appdecrypt",
            targets: ["appdecrypt"]
        )
    ],
    targets: [
        .target(name: "appdecrypt")
    ]
)
