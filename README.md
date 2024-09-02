# ElementaryUI

[![GitHub Release](https://img.shields.io/github/release/buildexperience/ElementaryUI.svg?include_prereleases)](https://github.com/buildexperience/ElementaryUI/releases)
[![Platforms](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbuildexperience%2FElementaryUI%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/buildexperience/ElementaryUI)
[![Swift Versions](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbuildexperience%2FElementaryUI%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/buildexperience/ElementaryUI)
[![License](https://img.shields.io/github/license/buildexperience/ElementaryUI)](https://github.com/buildexperience/ElementaryUI/blob/main/LICENSE)

> [!CAUTION]
> ElementaryUI is currently in its alpha phase. This means it is still under active development and may undergo significant changes. Users should expect potential breaking changes and are encouraged to provide feedback to help improve the package. Contributions are welcome, and developers are invited to participate in the development process by submitting issues and pull requests.

ElementaryUI is a SwiftUI package designed to streamline the development of user interfaces in Swift. 

- [Platforms](https://github.com/buildexperience/ElementaryUI?tab=readme-ov-file#platforms)
- [Installation](https://github.com/buildexperience/ElementaryUI?tab=readme-ov-file#installation)
- [License](https://github.com/buildexperience/ElementaryUI?tab=readme-ov-file#license)

## Platforms

| Platforms | Minimum Version  |         Status       |
| :---      |       :---:      |         :---:        |
| iOS       | 15.0             |  :white_check_mark:  |
| macOS     | 12.0             |  :white_check_mark:  |
| watchOS   | 8.0              |  :white_check_mark:  |
| tvOS      | 15.0             |  :white_check_mark:  |
| visionOS  | 1.0              |  :white_check_mark:  |

## Installation

### Swift Package Manager (SPM)

**ElementaryUI** is only available throught Swift Package Manager,  
Add the package as a dependency to your `Package.swift` or Packages list in **Xcode**.

```swift
dependencies: [
    .package(url: "https://github.com/buildexperience/ElementaryUI.git", from: "0.4.0")
]
```
Then add it to your target:

```swift
.product(name: "ElementaryUI", package: "ElementaryUI")
```

## License

ElementaryUI is available under the Apache-2.0 license. See the [LICENSE](LICENSE) file for more info.
