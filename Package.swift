// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "liveview-native-swiftui-charts",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "liveview-native-swiftui-charts",
            targets: ["liveview-native-swiftui-charts"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "liveview-native-swiftui-charts"),
        .testTarget(
            name: "liveview-native-swiftui-chartsTests",
            dependencies: ["liveview-native-swiftui-charts"]),
    ]
)
