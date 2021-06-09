// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "IGIdenticon",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v9),
        .watchOS(.v2),
        .tvOS(.v9)
    ],
    products: [
        .library(name: "IGIdenticon", targets: [ "IGIdenticon" ]),
    ],
    targets: [
        .target(name: "IGIdenticon", path: "Identicon")
    ]
)
