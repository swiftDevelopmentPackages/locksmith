// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "locksmith",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13)
      ],
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
