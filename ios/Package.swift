// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "nb_utils",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "nb-utils", targets: ["nb_utils"])
    ],
    dependencies: [
        .package(name: "Flutter", path: "Flutter")
    ],
    targets: [
        .target(
            name: "nb_utils",
            dependencies: [
                .product(name: "Flutter", package: "Flutter")
            ],
            path: "Classes"
        )
    ]
)
