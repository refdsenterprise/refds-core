// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RefdsCleanArchitecture",
    products: [
        .library(
            name: "RefdsCleanArchitecture",
            targets: ["RefdsCleanArchitecture"]),
        .library(name: "RefdsDomainLayer", targets: ["RefdsDomainLayer"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RefdsCleanArchitecture",
            dependencies: []),
        .testTarget(
            name: "RefdsCleanArchitectureTests",
            dependencies: ["RefdsCleanArchitecture"]),
        .target(name: "RefdsDomainLayer", dependencies: []),
    ]
)
