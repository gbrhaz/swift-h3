// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "swift-h3",
    products: [
        .library(name: "H3Kit", targets: ["H3Kit"]),
    ],
    targets: [
        .target(
            name: "CH3",
            path: "Sources/CH3",
            sources: ["csrc"],
            publicHeadersPath: "include"
        ),
        .target(
            name: "H3Kit",
            dependencies: ["CH3"]
        )
    ]
)
