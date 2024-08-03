# ElementaryUI
> [!CAUTION]
> ElementaryUI is currently in its alpha phase. This means it is still under active development and may undergo significant changes. Users should expect potential breaking changes and are encouraged to provide feedback to help improve the package. Contributions are welcome, and developers are invited to participate in the development process by submitting issues and pull requests.

ElementaryUI is a SwiftUI package designed to streamline the development of user interfaces in Swift. 

- [Platforms](https://github.com/buildexperience/ElementaryUI?tab=readme-ov-file#platforms)
- [Installation](https://github.com/buildexperience/ElementaryUI?tab=readme-ov-file#installation)
- [License](https://github.com/buildexperience/ElementaryUI?tab=readme-ov-file#license)

## Platforms

| Platforms | Minimum Version  |         Status       |
| :---      |       :---:      |         :---:        |
| iOS       | 15.0             | :white_check_mark:   |
| macOS     | 12.0             | :white_check_mark:   |
| watchOS   | 8.0              | WIP :warning:        |
| tvOS      | 15.0             | WIP :warning:        |
| visionOS  | 1.0              | WIP :warning:        |

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
