// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "appdecrypt",
    products: [
        .executable(name: "appdecrypt", targets: ["appdecrypt"])
    ],
    targets: [
        .target(name: "appdecrypt", dependencies: []),
    ]
)
