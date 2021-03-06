// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SmartCache",
    products: [
        .library(name: "SmartCache", targets: ["SmartCache"]),
    ],
    targets: [
        .target(name: "SmartCache", dependencies: []),
    ]
)
