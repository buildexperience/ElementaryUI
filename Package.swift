// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "NJKit",
    products: [
        .library(name: "NJKit", targets: ["NJKit"]),
    ],
    targets: [
        .target(name: "NJKit"),
        .testTarget(name: "NJKitTests", dependencies: [
            "NJKit"
        ]),
    ]
)
