// swift-tools-version: 5.9

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "ElementaryUI",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "ElementaryUI", targets: ["ElementaryUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
    ],
    targets: [
        .macro(
            name: "ElementaryUIMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        
        .testTarget(
            name: "ElementaryUIMacrosTests",
            dependencies: [
                "ElementaryUIMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency"),
                .unsafeFlags([
                    "-Xfrontend", 
                    "-warn-concurrency"
                ])
            ]
        ),
        
        .target(
            name: "ElementaryUI",
            dependencies: [
                "ElementaryUIMacros"
            ]
        ),
    ]
)
