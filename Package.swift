// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "opencode-sdk-swift",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "opencode-sdk-swift",
            targets: ["opencode-sdk-swift"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "opencode-sdk-swift"
        ),
        .testTarget(
            name: "opencode-sdk-swiftTests",
            dependencies: ["opencode-sdk-swift"]
        ),
    ]
)
