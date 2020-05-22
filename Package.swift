// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "IGIdenticon",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v12)
    ],
    products: [
        .library(name: "IGIdenticon", targets: [ "IGIdenticon" ]),
    ],
    targets: [
        .target(name: "IGIdenticon", path: "Identicon")
    ]
)
