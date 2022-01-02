// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "KeyChain",
	platforms: [
	  .iOS(.v11),
	],
    products: [
        .library(
            name: "KeyChain",
            targets: ["KeyChain"]
		),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "KeyChain",
            dependencies: []),
        .testTarget(
            name: "KeyChainTests",
            dependencies: ["KeyChain"]),
    ]
)
