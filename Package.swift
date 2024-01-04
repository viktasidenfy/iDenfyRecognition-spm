// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "8.3.0.7"

enum Checksums {
    static let iDenfyInternalLoggerChecksum = "da9c9adecc0724eb2a1bef4299d7d7c9b53a8f7e17961f94b43d19cfa01f875a"
    static let iDenfyDocRecognitionChecksum = "754958e6ce23dcf2f3b49af414362176fa762e0e4a3b30c10883388358cd403b"
    static let idengineChecksum = "e50c4eb34f84f43f772715df57ecf49f87982f37b64a5938c37ef1314f76d90e"
    static let FaceTecSDKChecksum = "5b69f7cc1622d2cac32b88bb7688add81c712427f134c3f5dd08485d3d1cce70"
    static let iDenfyLivenessChecksum = "6f1ea12f9bcf74c463fb36516a4d6b56afb424d925e984b2f0a754fad3d9d661"
    static let idenfyviewsChecksum = "70f83cab148c6617f23661781385a4ee8d192cb709993349b6536deceed94cad"
    static let iDenfySDKChecksum = "df0f07d5826f3636cbeb1bee83c6db6f1fb8f07b3da424f28eedc03d22395d30"
    static let idenfycoreChecksum = "3b3e4570225e9914650dfe2821fa4314c7724e7bdbc405a529df5a57d10a8720"
    static let idenfyNFCReadingChecksum = "9c6a95a5c01f1aa1bd20e66c68b35f410f518230e9eb649d612e13b796d4103a"
    static let openSSLChecksum = "ec005002f2531987e4f0787a17d6807cb8884f7a0dc9a3e739dc7f1be5e4c338"
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
