// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RefdsCleanArchitecture",
    platforms: [
        .iOS(.v13),
        .macOS(.v12),
        .macCatalyst(.v15)
    ],
    products: [
        .library(name: "RefdsDomainLayer", targets: ["RefdsDomainLayer"]),
        .library(name: "RefdsDataLayer", targets: ["RefdsDataLayer"]),
        .library(name: "RefdsInfraLayer", targets: ["RefdsInfraLayer"])
    ],
    dependencies: [],
    targets: [
        .target(name: "RefdsDomainLayer", dependencies: []),
        .target(name: "RefdsDataLayer", dependencies: ["RefdsDomainLayer"]),
        .target(name: "RefdsInfraLayer", dependencies: ["RefdsDataLayer", "RefdsDomainLayer"])
    ]
)
