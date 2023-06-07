// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RefdsCore",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .macCatalyst(.v15),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "RefdsCore",
            targets: ["RefdsCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/refdsenterprise/refds-resource.git", branch: "main")
    ],
    targets: [
        .target(
            name: "RefdsCore",
            dependencies: [
                .product(name: "RefdsResource", package: "refds-resource")
            ]),
    ]
)
