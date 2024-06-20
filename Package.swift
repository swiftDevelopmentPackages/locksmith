// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "locksmith",
    platforms: [
        .iOS(.v16),
        .macOS(.v11)
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
