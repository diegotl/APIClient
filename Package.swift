// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "APIClient",
    products: [
        .library(name: "APIClient", targets: ["APIClient"]),
        .library(name: "APIClientOkLog", targets: ["APIClient", "APIClientOkLog"]),
    ],
    dependencies: [
        .package(url: "https://github.com/diegotl/OkLog-Swift.git", from: "0.2.1"),
    ],
    targets: [
        .target(name: "APIClient", path: "Sources/Core"),
        .target(name: "APIClientOkLog", dependencies: ["OkLog"], path: "Sources/OkLog"),
        .testTarget(name: "APIClientTests", dependencies: ["APIClient"]),
    ]
)
