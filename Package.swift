// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RouletteKit",
    platforms: [
      .iOS(.v16), .macOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RouletteKit",
            targets: ["RouletteKit"]
        ),
    ],
    dependencies: [
      .package(url: "https://github.com/apple/swift-async-algorithms.git", from: Version(1, 0, 0)),
      .package(url: "https://github.com/swiftlang/swift-testing.git", from: Version(0, 1, 1)),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
          name: "RouletteKit",
          dependencies: [.product(name: "AsyncAlgorithms", package: "swift-async-algorithms")]
        ),
        .testTarget(
            name: "RouletteKitTests",
            dependencies: [
              "RouletteKit",
              .product(name: "Testing", package: "swift-testing"),
            ]
        ),
    ]
)
