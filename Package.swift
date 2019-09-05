// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "APIClient",
    products: [
        .library(name: "APIClient", targets: ["APIClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/diegotl/OkLog-Swift.git", from: "0.2.1"),
    ],
    targets: [
        .target(name: "APIClient", /*dependencies: ["OkLog"], */path: "Sources/"),
        .testTarget(name: "APIClientTests", dependencies: ["APIClient"]),
    ]
)
