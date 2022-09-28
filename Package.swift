// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Amplify",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "Amplify",
            targets: ["Amplify"]),
        
        .library(name: "AWSPluginsCore",
                 targets: ["AWSPluginsCore"]),
        
        .library(name: "AWSAPIPlugin",
                 targets: ["AWSAPIPlugin"]),
        
        .library(name: "AWSCognitoAuthPlugin",
                 targets: ["AWSCognitoAuthPlugin"]),
        
    ],
    dependencies: [
        .package(name: "AWSiOSSDKV2", url: "https://github.com/samkudr/aws-sdk-ios-spm.git", .upToNextMinor(from: "2.28.1")),
        .package(name: "AppSyncRealTimeClient", url: "https://github.com/aws-amplify/aws-appsync-realtime-client-ios.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "Amplify",
            path: "Amplify",
            exclude: [
                "Info.plist",
                "Categories/DataStore/Model/Temporal/README.md"
            ]
        ),
        .target(
            name: "AWSPluginsCore",
            dependencies: [.target(name: "Amplify"),
                           .product(name: "AWSCore", package: "AWSiOSSDKV2")],
            path: "AmplifyPlugins/Core/AWSPluginsCore",
            exclude: [
                "Info.plist"
            ]
        ),
        .target(
            name: "AWSAPIPlugin",
            dependencies: [
                .target(name: "Amplify"),
                .target(name: "AWSPluginsCore"),
                .product(name: "AWSCore", package: "AWSiOSSDKV2"),
                .product(name: "AppSyncRealTimeClient", package: "AppSyncRealTimeClient")
            ],
            path: "AmplifyPlugins/API/AWSAPICategoryPlugin",
            exclude: [
                "Info.plist",
                "AWSAPIPlugin.md"
            ]
        ),
        .target(
            name: "AWSCognitoAuthPlugin",
            dependencies: [
                .target(name: "Amplify"),
                .target(name: "AWSPluginsCore"),
                .product(name: "AWSCore", package: "AWSiOSSDKV2"),
                .product(name: "AWSAuthCore", package: "AWSiOSSDKV2"),
                .product(name: "AWSMobileClientXCF", package: "AWSiOSSDKV2"),
                .product(name: "AWSCognitoIdentityProvider", package: "AWSiOSSDKV2"),
                .product(name: "AWSCognitoIdentityProviderASF", package: "AWSiOSSDKV2")],
            path: "AmplifyPlugins/Auth/AWSCognitoAuthPlugin",
            exclude: [
                "Resources/Info.plist"
            ]
        ),
    ]
)
