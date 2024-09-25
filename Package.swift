// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Telnetconnection",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Telnetconnection",
            targets: ["telentConnectionPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "telentConnectionPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/telentConnectionPlugin"),
        .testTarget(
            name: "telentConnectionPluginTests",
            dependencies: ["telentConnectionPlugin"],
            path: "ios/Tests/telentConnectionPluginTests")
    ]
)