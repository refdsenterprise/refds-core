// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RefdsCore",
    platforms: [
        .iOS(.v13),
        .macOS(.v12),
        .macCatalyst(.v15)
    ],
    products: [
        .library(
            name: "RefdsCore",
            targets: ["RefdsDomain", "RefdsData", "RefdsInfra"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RefdsDomain",
            dependencies: []),
        .target(
            name: "RefdsData",
            dependencies: ["RefdsDomain"]),
        .target(
            name: "RefdsInfra",
            dependencies: ["RefdsData", "RefdsDomain"]),
    ]
)
