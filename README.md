# DGFlipView

## Installation

### Swift Package Manager

The [Swift Package Manager](https://www.swift.org/documentation/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding `DGFlipView` as a dependency is as easy as adding it to the dependencies value of your Package.swift or the Package list in Xcode.

```
dependencies: [
   .package(url: "https://github.com/donggyushin/DGFlipView.git", .upToNextMajor(from: "1.0.0"))
]
```

Normally you'll want to depend on the DGFlipView target:

```
.product(name: "DGFlipView", package: "DGFlipView")
```

## Usage
```swift
        FlipView {
            ZStack {
                Color.blue
                Text("Front")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        } back: {
            ZStack {
                Color.red
                Text("Back")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }.onFlipChange { flip in ... }
```

