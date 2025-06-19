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
        // C target containing the H3 C library (included as a submodule)
        .target(
            name: "CH3",
            path: "Sources/CH3",
            sources: ["h3/src/h3lib/lib"],       // compile all H3 C source files
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("h3/src/h3lib/include")
            ],
            linkerSettings: [
                .linkedLibrary("m", .when(platforms: [.linux]))  // link libm on Linux
            ]
        ),
        // Swift target providing the Swift wrapper API
        .target(
            name: "H3",
            dependencies: ["CH3"],
            path: "Sources/H3"
        ),
        // Unit test target for the Swift wrapper
        .testTarget(
            name: "H3Tests",
            dependencies: ["H3"],
            path: "Tests/H3Tests"
        )
    ]
)
