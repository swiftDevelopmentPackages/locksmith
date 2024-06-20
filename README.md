![CI](https://github.com/swiftDevelopmentPackages/locksmith/actions/workflows/swift.yml/badge.svg?branch=main)
![iOS](https://img.shields.io/badge/iOS-16.0-blue)
![macOS](https://img.shields.io/badge/macOS-11.0-blue)

# locksmith
Keychain access wrapper for macOS/iOS written in Swift. locksmith provides a simple and secure way to store and retrieve sensitive data using the iOS Keychain.

## Features

- Save data securely in the Keychain using Codable protocol.
- Retrieve and decode data from the Keychain.
- Delete stored data from the Keychain.

## Installation

### Swift Package Manager

You can install Wheel using the [Swift Package Manager](https://swift.org/package-manager/) by adding the following line to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/swiftDevelopmentPackages/locksmith.git", from: "1.0.0")
]
```
Then, add wheel to your target's dependencies:
```
targets: [
    .target(name: "YourTarget", dependencies: ["locksmith"]),
]
```

Or, simply add using XCode's package dependencies tab.


## Usage

### Initialization
locksmith supports `accessGroup` identifier for an optional keychain sharing accross different apps and extensions.

```swift
let locksmith = Locksmith(service: "com.example.keychain", accessGroup: "your.access.group")
```

### Saving
```swift
let dataToSave = "Secret Data"
locksmith.save(key: "secretKey", value: dataToSave)
```

### Reading
```swift
if let retrievedData: String = locksmith.read(key: "secretKey") {
    print("Retrieved Data: \(retrievedData)")
}
```

### Deleting
```swift
locksmith.delete(key: "secretKey")
```






