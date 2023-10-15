// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "appdecrypt",
    products: [
        .executable(name: "appdecrypt", targets: ["appdecrypt"])
    ],
    targets: [
        .executableTarget(name: "appdecrypt", dependencies: []),
    ]
)
