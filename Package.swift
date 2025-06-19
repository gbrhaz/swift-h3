// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "swift-h3",
    platforms: [
        .iOS(.v13), .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "H3",
            targets: ["H3"]
        )
    ],
    targets: [
        .target(
            name: "CH3",
            path: "Sources/CH3",
            sources: ["h3/src/h3lib/lib", "h3api_ext.c"],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("h3/src/h3lib/include")
            ],
            linkerSettings: [
                .linkedLibrary("m", .when(platforms: [.linux]))  // link libm on Linux
            ]
        ),
        .target(
            name: "H3",
            dependencies: ["CH3"],
            path: "Sources/H3"
        ),
        .testTarget(
            name: "H3Tests",
            dependencies: ["H3"],
            path: "Tests/H3Tests"
        )
    ]
)
