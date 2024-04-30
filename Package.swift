// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "WebimKeyboard",
    defaultLocalization: "en",
    products: [
        .library(
            name: "WebimKeyboard",
            targets: ["WebimKeyboard"]),
    ],
    targets: [
        .target(
            name: "WebimKeyboard",
            path: "WebimKeyboard",
            resources: [.copy("PrivacyInfo.xcprivacy")]
        )
    ]
)
