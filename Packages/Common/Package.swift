// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "Common",
  platforms: [
    .macOS(.v10_13), .iOS(.v11), .tvOS(.v11),
  ],
  products: [
    .library(
      name: "Common",
      targets: ["Common"]
    ),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "Common",
      dependencies: []
    ),
    .testTarget(
      name: "CommonTests",
      dependencies: ["Common"]
    ),
  ]
)
