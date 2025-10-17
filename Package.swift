// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "2.0.7"

enum Checksums {
    static let iDenfyInternalLoggerChecksum = "09ba4c83fde488b04d70ac418dd30eeb2cf677b5ad095a9e957c0743d1176fad"
    static let iDenfyDocRecognitionChecksum = "a6648615a5974d85ef2ba43f02b346ade7053acec762d5ef19911757099795bb"
    static let idengineChecksum = "85da29d740e0099ee60bbde9dac0a850ebb40aaa72bf6626b026f24dd6cd7c92"
    static let FaceTecSDKChecksum = "beccef2c5d0661e5bf445799bf933479b0ab4d61fc0d78595015c1d342c95951"
    static let iDenfyLivenessChecksum = "75b490e3477ce1216a6956f57b2718a7b045fbc6b0036f1c71f3efafee4dcf21"
    static let idenfyviewsChecksum = "8c49af2fbe2c97fc47eef92ad6f9c68aa478230b89c138301d2dbc38a67675f0"
    static let iDenfySDKChecksum = "a8fff9039ee32453fa09d76e0292d15783cfb33a7654c55e0f07c8519e651cca"
    static let idenfycoreChecksum = "f765d585a221412feb6eb591a5ab18a7a9b7cb58670b42ff6f8609b9469167e2"
    static let idenfyNFCReadingChecksum = "91c074e7eec29974e387690818b0c265644293e7530be579eea03d057c5b4599"
    static let openSSLChecksum = "ca815d35869ee37b25bbad644a95086d7997fde4896753f25c01a1fa4c33fd3e"
    static let iDenfyBlurGlareDetectionChecksum = "c2219bc004c82ef93f8cc371dc2b52f6d7d954c28d7f4527eedcabc11f13f5ca"
}

let package = Package(
    name: "iDenfyRecognition",
    platforms: [.iOS(.v13)],
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
        .package(url: "https://github.com/airbnb/lottie-spm.git", "4.5.0"..<"4.5.1"),
    ],
    targets: [
        //iDenfyBlurGlareDetection
        .target(
            name: "iDenfyBlurGlareDetectionTarget",
            dependencies: [.target(name: "iDenfyBlurGlareDetectionWrapper",
                                   condition: .when(platforms: [.iOS]))],
            path: "SwiftPM-PlatformExclude/iDenfyBlurGlareDetectionWrap"
        ),
        .target(
            name: "iDenfyBlurGlareDetectionWrapper",
            dependencies: [
                .target(
                    name: "iDenfyBlurGlareDetection",
                    condition: .when(platforms: [.iOS])
                ),
            ],
            path: "iDenfyBlurGlareDetectionWrapper"
        ),
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
                .target(name: "iDenfyBlurGlareDetectionTarget",
                        condition: .when(platforms: [.iOS])),
            ],
            path: "iDenfySDKWrapper"
        ),
        // Binaries
        .binaryTarget(name: "iDenfyInternalLogger",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/iDenfyInternalLogger.zip", checksum: Checksums.iDenfyInternalLoggerChecksum),
        .binaryTarget(name: "iDenfyDocRecognition",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/iDenfyDocRecognition.zip", checksum: Checksums.iDenfyDocRecognitionChecksum),
        .binaryTarget(name: "idengine",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/idengine.zip", checksum: Checksums.idengineChecksum),
        .binaryTarget(name: "FaceTecSDK",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/FaceTecSDK.zip", checksum: Checksums.FaceTecSDKChecksum),
        .binaryTarget(name: "IdenfyLiveness",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/IdenfyLiveness.zip", checksum: Checksums.iDenfyLivenessChecksum),
        .binaryTarget(name: "idenfyviews",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/idenfyviews.zip", checksum: Checksums.idenfyviewsChecksum),
        .binaryTarget(name: "iDenfySDK",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/iDenfySDK.zip", checksum: Checksums.iDenfySDKChecksum),
        .binaryTarget(name: "idenfycore",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/idenfycore.zip", checksum: Checksums.idenfycoreChecksum),
        .binaryTarget(name: "idenfyNFCReading",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/idenfyNFCReading.zip", checksum: Checksums.idenfyNFCReadingChecksum),
        .binaryTarget(name: "OpenSSL",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/OpenSSL.zip", checksum: Checksums.openSSLChecksum),
        .binaryTarget(name: "iDenfyBlurGlareDetection",
                      url: "https://s3.eu-west-1.amazonaws.com/prod-ivs-sdk.builds/ios-sdk/\(version)/spm/IdenfyRecognition/iDenfyBlurGlareDetection.zip", checksum: Checksums.iDenfyBlurGlareDetectionChecksum),
    ]
)
