// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "NJKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
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
