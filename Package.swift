// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ElementaryUI",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "ElementaryUI", targets: ["ElementaryUI"]),
    ],
    targets: [
        .target(name: "ElementaryUI"),
        .testTarget(name: "ElementaryUITests", dependencies: [
            "ElementaryUI"
        ]),
    ]
)
