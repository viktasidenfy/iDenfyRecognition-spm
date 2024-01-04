// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "8.3.0.5"

enum Checksums {
    static let iDenfyInternalLoggerChecksum = "04e4cbca20c8e263c3cd8f778f59e7ddea56d74cb21dd5e593504c688fd52909"
    static let iDenfyDocRecognitionChecksum = "23f96ea2bcb8ab6c61e18a302262e36393fb9e2728752ca1b3b78b95eb94fd9b"
    static let idengineChecksum = "4760f1eaa02947cd5ab5736e8c503c42802935193c728da14a39275a95a5f7d6"
    static let FaceTecSDKChecksum = "77b98308ca3326f2cf50c43ec6ea73cd5e3db3226d882fd541af7979d7f5eba8"
    static let iDenfyLivenessChecksum = "c932115184b8e43add176b47d9a91d349a843ccb7fb678951aea292f743b0a5b"
    static let idenfyviewsChecksum = "64d146c6192392e324b3804c62ed136803d9ee10b15e7644e9e0952d5dbf57a1"
    static let iDenfySDKChecksum = "a3a40e54cda11bb55503c372c75b581c1c491aaf8d964042d1978a5aded7234a"
    static let idenfycoreChecksum = "d2139f2818f6b8d8ec29ab7f705ad18a7878a30deef29985650f47dbc76f9aa9"
    static let idenfyNFCReadingChecksum = "044a046b8e066d026d400f4d3ce4b8a6afeaa1870dc4abb3d1fa2e24122c702e"
    static let openSSLChecksum = "64db1f29c44cb4231ee4fd452f35eefff51f18d1db11ab4fe34aec1edb5ebf7d"
}

let package = Package(
    name: "iDenfyRecognition",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "iDenfyRecognition-Dynamic",
            type: .dynamic,
            targets: ["iDenfySDKTarget"]),
        .library(
            name: "iDenfyRecognition",
            targets: ["iDenfySDKTarget"]),
    ],
    dependencies: [
        .package(url: "https://github.com/airbnb/lottie-spm.git", "4.2.0"..<"4.2.1"),
    ],
    targets: [
        //IdenfyViews
        .target(
            name: "idenfyviewsTarget",
            dependencies: [.target(name: "idenfyviewsWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/idenfyviewsWrap"
        ),
        .target(
            name: "idenfyviewsWrapper",
            dependencies: [
                .target(
                    name: "idenfyviews",
                    condition: .when(platforms: [.iOS])
                ),
                .target(name: "idenfycore",
                        condition: .when(platforms: [.iOS])),
                .product(name: "Lottie",
                         package: "lottie-spm",
                         condition: .when(platforms: [.iOS])),
            ],
            path: "idenfyviewsWrapper"
        ),
        //IdenfyNFCReading
        .target(
            name: "idenfyNFCReadingTarget",
            dependencies: [.target(name: "idenfyNFCReadingWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/idenfyNFCReadingWrap"
        ),
        .target(
            name: "idenfyNFCReadingWrapper",
            dependencies: [
                .target(
                    name: "idenfyNFCReading",
                    condition: .when(platforms: [.iOS])
                ),
                .target(name: "OpenSSL",
                        condition: .when(platforms: [.iOS])),
            ],
            path: "idenfyNFCReadingWrapper"
        ),
        //IdenfyLiveness
        .target(
            name: "IdenfyLivenessTarget",
            dependencies: [.target(name: "IdenfyLivenessWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/IdenfyLivenessWrap"
        ),
        .target(
            name: "IdenfyLivenessWrapper",
            dependencies: [
                .target(
                    name: "IdenfyLiveness",
                    condition: .when(platforms: [.iOS])
                ),
                .target(name: "FaceTecSDK",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idenfyviewsTarget",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idenfycore",
                        condition: .when(platforms: [.iOS])),
            ],
            path: "IdenfyLivenessWrapper"
        ),
        //IdenfyRecognition
        .target(
            name: "iDenfyDocRecognitionTarget",
            dependencies: [.target(name: "iDenfyDocRecognitionWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/iDenfyDocRecognitionWrap"
        ),
        .target(
            name: "iDenfyDocRecognitionWrapper",
            dependencies: [
                .target(
                    name: "iDenfyDocRecognition",
                    condition: .when(platforms: [.iOS])
                ),
            ],
            path: "iDenfyDocRecognitionWrapper"
        ),
        //iDenfySDK
        .target(
            name: "iDenfySDKTarget",
            dependencies: [.target(name: "iDenfySDKWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/iDenfySDKWrap",
            cSettings: [
                .define("CLANG_MODULES_AUTOLINK", to: "YES"),
                .define("OTHER_LDFLAGS[sdk=iphoneos*]", to: "-ObjC -l\"idengine-ios\""),
                .define("OTHER_LDFLAGS[sdk=iphonesimulator*]", to: "-ObjC -l\"idengine-ios-simulator\""),
                .define("EXCLUDED_ARCHS[sdk=iphonesimulator*]", to: "i386"),
            ]
        ),
        .target(
            name: "iDenfySDKWrapper",
            dependencies: [
                .target(
                    name: "iDenfySDK",
                    condition: .when(platforms: [.iOS])),
                .product(name: "Lottie",
                         package: "lottie-spm",
                         condition: .when(platforms: [.iOS])),
                .target(name: "idenfycore",
                        condition: .when(platforms: [.iOS])),
                .target(name: "iDenfyInternalLogger",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idenfyNFCReadingTarget",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idenfyviewsTarget",
                        condition: .when(platforms: [.iOS])),
                .target(name: "FaceTecSDK",
                        condition: .when(platforms: [.iOS])),
                .target(name: "IdenfyLivenessTarget",
                        condition: .when(platforms: [.iOS])),
                .target(name: "iDenfyDocRecognitionTarget",
                        condition: .when(platforms: [.iOS])),
                .target(name: "idengine",
                        condition: .when(platforms: [.iOS])),
            ],
            path: "iDenfySDKWrapper"
        ),
        // Binaries
        .binaryTarget(name: "iDenfyInternalLogger",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/iDenfyInternalLogger.zip", checksum: Checksums.iDenfyInternalLoggerChecksum),
        .binaryTarget(name: "iDenfyDocRecognition",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/iDenfyDocRecognition.zip", checksum: Checksums.iDenfyDocRecognitionChecksum),
        .binaryTarget(name: "idengine",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/idengine.zip", checksum: Checksums.idengineChecksum),
        .binaryTarget(name: "FaceTecSDK",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/FaceTecSDK.zip", checksum: Checksums.FaceTecSDKChecksum),
        .binaryTarget(name: "IdenfyLiveness",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/IdenfyLiveness.zip", checksum: Checksums.iDenfyLivenessChecksum),
        .binaryTarget(name: "idenfyviews",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/idenfyviews.zip", checksum: Checksums.idenfyviewsChecksum),
        .binaryTarget(name: "iDenfySDK",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/iDenfySDK.zip", checksum: Checksums.iDenfySDKChecksum),
        .binaryTarget(name: "idenfycore",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/idenfycore.zip", checksum: Checksums.idenfycoreChecksum),
        .binaryTarget(name: "idenfyNFCReading",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/idenfyNFCReading.zip", checksum: Checksums.idenfyNFCReadingChecksum),
        .binaryTarget(name: "OpenSSL",
                      url: "https://s3.eu-west-1.amazonaws.com/sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/OpenSSL.zip", checksum: Checksums.openSSLChecksum),
    ]
)
