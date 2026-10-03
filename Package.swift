// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "NuqiGold",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "NuqiGold", targets: ["NuqiGold"]),
    ],
    targets: [
        .binaryTarget(
            name: "NuqiGold",
            url: "https://github.com/Vishal6951/nuqi-gold-ios/releases/download/1.0.0/NuqiGold-1.0.0.xcframework.zip",
            checksum: "9fdd3194f9e685649623957c8dd22c18006f749373d4eb4fbb5d366819d3cbf5"
        ),
    ]
)