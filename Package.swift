// swift-tools-version: 5.10

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "ElementaryUI",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "ElementaryUI", targets: ["ElementaryUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "510.0.0"),
        .package(url: "https://github.com/buildexperience/MacrosKit.git", branch: "main")
    ],
    targets: [
        .macro(
            name: "ElementaryUIMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                .product(name: "MacrosKit", package: "MacrosKit")
            ]
        ),
        
        .testTarget(
            name: "ElementaryUIMacrosTests",
            dependencies: [
                "ElementaryUIMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
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
