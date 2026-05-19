// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "nb_utils",
    platforms: [
        .macOS("10.11")
    ],
    products: [
        .library(name: "nb-utils", targets: ["nb_utils"])
    ],
    dependencies: [
        .package(name: "FlutterMacOS", path: "FlutterMacOS")
    ],
    targets: [
        .target(
            name: "nb_utils",
            dependencies: [
                .product(name: "FlutterMacOS", package: "FlutterMacOS")
            ],
            path: "Classes"
        )
    ]
)
