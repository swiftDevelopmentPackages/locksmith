// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "locksmith",
    products: [
        .library(
            name: "locksmith",
            targets: ["locksmith"]),
    ],
    targets: [
        .target(
            name: "locksmith")
    ]
)
