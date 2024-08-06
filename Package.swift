// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LiveViewNativeCharts",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LiveViewNativeCharts",
            targets: ["LiveViewNativeCharts"]),
    ],
    dependencies: [
       .package(url: "https://github.com/liveview-native/liveview-client-swiftui", from: "0.3.0-rc.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LiveViewNativeCharts",
            dependencies: [
                .product(name: "LiveViewNative", package: "liveview-client-swiftui"),
                .product(name: "LiveViewNativeStylesheet", package: "liveview-client-swiftui"),
            ]
        ),
        .testTarget(
            name: "LiveViewNativeChartsTests",
            dependencies: ["LiveViewNativeCharts"]),
    ]
)
