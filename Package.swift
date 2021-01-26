// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "APIClient",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(name: "APIClient", targets: ["APIClient"]),
        .library(name: "APIClientOkLog", targets: ["APIClientOkLog"]),
        .library(name: "APIClientCombine", targets: ["APIClientCombine"]),
    ],
    dependencies: [
        .package(name: "OkLog", url: "https://github.com/diegotl/OkLog-Swift.git", from: "0.2.4"),
    ],
    targets: [
        .target(name: "APIClient", path: "Sources/Core"),
        .target(name: "APIClientCombine", path: "Sources/Combine"),
        .target(name: "APIClientOkLog", dependencies: ["APIClient", "OkLog"], path: "Sources/OkLog"),
        .testTarget(name: "APIClientTests", dependencies: ["APIClient"]),
        .testTarget(name: "APIClientCombineTests", dependencies: ["APIClientCombine"]),
    ]
)
