# TipBox

`TipBox` is a SwiftUI component for displaying tips or notifications with optional animation. It can be used to show contextual information to users in a visually appealing way.

<img src="images/sample.gif" alt="sample" width="300">

## Features

- Display tips with an icon, title, and message.
- Optional animation for showing and hiding the tip.
- Customizable appearance with SwiftUI.

## Installation

To install `TipBox` using Swift Package Manager, add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/sakes9/TipBox.git", from: "1.0.0")
]
```

Then, add `TipBox` as a dependency to your target:

```swift
.target(
    name: "YourTargetName",
    dependencies: ["TipBox"]
)
```

## Usage

Here's a basic example of how to use `TipBox` in your SwiftUI view:

```swift
import SwiftUI
import TipBox

struct ContentView: View {
    var body: some View {
        VStack {
            TipBox(SampleTip(), isShowAnimationEnabled: true)
        }
        .padding(.horizontal)
    }
}

struct SampleTip: TipInfo {
    var title: String = "Sample Title"
    var message: String = "This is a sample message."
    var image: String = "lightbulb"
}
```

### Parameters

- `tip`: An instance conforming to the `TipInfo` protocol containing the tip's information (title, message, and image).
- `isShowAnimationEnabled`: A Boolean flag to enable or disable the show animation. Default is `true`.
