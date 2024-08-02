// swift-tools-version: 5.10

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "ElementaryUI",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8),
        .tvOS(.v15),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "ElementaryUI", targets: ["ElementaryUI"]),
        .library(name: "HexDecoder", targets: ["HexDecoder"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-syntax.git",
            from: "510.0.0"
        ),
        
        .package(
            url: "https://github.com/buildexperience/MacrosKit.git",
            branch: "main"
        )
    ],
    targets: [
        .macro(
            name: "ElementaryUIMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                .product(name: "MacrosKit", package: "MacrosKit"),
                "HexDecoder"
            ]
        ),
        .testTarget(
            name: "ElementaryUIMacrosTests",
            dependencies: [
                .product(
                    name: "SwiftSyntaxMacrosTestSupport",
                    package: "swift-syntax"
                ),
                "ElementaryUIMacros",
                "HexDecoder",
            ]
        ),
        
        .target(name: "HexDecoder"),
        .testTarget(
            name: "HexDecoderTests",
            dependencies: [
                "HexDecoder"
            ]
        ),
        
        .target(
            name: "ElementaryUI",
            dependencies: [
                "HexDecoder",
                "ElementaryUIMacros"
            ]
        ),
    ]
)
