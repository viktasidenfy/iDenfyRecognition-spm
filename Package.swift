// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "1.8.4"

enum Checksums {
    static let iDenfyInternalLoggerChecksum = "b7a1bdc80c23bbb915c2f951a376f329059b624caae670a2a778c65591caa4e0"
    static let iDenfyDocRecognitionChecksum = "622f7cd4a7c9ed8dceb60ec212766aaecc1910db66250bddf990a59fe1f7efef"
    static let idengineChecksum = "2350ab52e51a5fb608674809e09fe2e7d03220c1dcd24e778da50d28f5a25d7e"
    static let FaceTecSDKChecksum = "957bd4f010386ee563469eee86e8df8f556699c873d7cb7ef2873eb4d34d9e13"
    static let iDenfyLivenessChecksum = "e081b34e7e7dc5ed5b9d5b0a13beae4dfa15118897eef94fce8ff820487a05c8"
    static let idenfyviewsChecksum = "ddff9a3da61f2b628c0f81dbb762d8985a72a85fb041f76ccdd56d2a812e8690"
    static let iDenfySDKChecksum = "815a7c662c2cf00c655b6e1bd3747ca547fd20c92a52d7693bbed22157224e05"
    static let idenfycoreChecksum = "c404eeddfd5cb08765e259dede40c4c90b4edf8e85a8f1efd0f12622a341fbfd"
    static let idenfyNFCReadingChecksum = "aece70fa7ddbe2bd8d9af551e4149b645251e01afaf73ddd0a2a9d81b5bc9c63"
    static let openSSLChecksum = "47de4261531e7c09ba925e22d10603d697bdac1e248d960695188fda30896df0"
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
        .package(url: "https://github.com/airbnb/lottie-spm.git", "4.4.3"..<"4.4.4"),
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
