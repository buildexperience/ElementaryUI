# ElementaryUI

ElementaryUI is a SwiftUI package designed to streamline the development of user interfaces in Swift. 

- [Platforms](Tested)
- [Installation](ElementaryUI)
- [License](https://github.com/buildexperience/ElementaryUI/new/main?filename=README.md#license)

## Platforms

| Platforms | Minimum Version  |  Notes  |
| :---      |       :---:      |  :---:  |
| iOS       | 15.0             | Tested  |
| macOS     | 12.0             | Tested  |
| watchOS   | 8.0              | WIP     |
| tvOS      | 15.0             | WIP     |
| visionOS  | 1.0              | WIP     |

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

ElementaryUI is available under the Apache-2.0 license. See the LICENSE file for more info.
