// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "CommonUI",
  platforms: [
    .iOS(.v13), .tvOS(.v13),
  ],
  products: [
    .library(
      name: "CommonUI",
      targets: ["CommonUI"]
    ),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "CommonUI",
      dependencies: [],
      resources: [.process("Resources")]
    ),
    .testTarget(
      name: "CommonUITests",
      dependencies: ["CommonUI"]
    ),
  ]
)
