<a href="https://github.com/ueshun109/RouletteKit/blob/main/LICENSE"><img alt="MIT License" src="https://img.shields.io/badge/license-MIT-green.svg"></a>
<a href="https://developer.apple.com/jp/xcode/swiftui/"><img src="https://img.shields.io/badge/SwiftUI-blue.svg" /></a>
<a href="https://github.com/apple/swift-package-manager"><img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" /></a>

# RouletteKit

RouletteKit is implemented in SwiftUI and provides the following functionality

- The necessary logic to realize roulette
- A simple roulette UI component

# Support Version

- iOS 16.0+
- MacOS 14.0+

# Installation

Only the Swift Package Manager is supported.

```swift
dependencies: [
    .package(url: "https://github.com/ueshun109/RouletteKit", from: "1.0.0")
]
```

# Usage

Roulette can be easily implemented using the UI components provided by this library. It is also possible to customize only the UI.

## Use UI components provided by the library

If you want to set text as a roulette item, you can use the provided UI component (`RouletteView`).

```swift
@StateObject var rouletteController: RouletteController = .init(sectors: [
    .init(id: 0, text: "RED", color: .red, dataCount: 5),
    .init(id: 1, text: "BLUE", color: .blue, dataCount: 5),
    .init(id: 2, text: "GREEN", color: .green, dataCount: 5),
    .init(id: 3, text: "YELLOW", color: .yellow, dataCount: 5),
    .init(id: 4, text: "BROWN", color: .brown, dataCount: 5),
]

RouletteView(rouletteController: rouletteController) {
    switch rouletteController.status {
    case .idle, .complete:
        Button("START") {
            rouletteController.start()
        }
    case .rotating, .stopping:
        Button("STOP") {
            rouletteController.stop()
        }
        .disabled(rouletteController.status == .stopping)
    }
}
```

https://github.com/user-attachments/assets/724c130d-30d7-4e5c-b89f-f4bb56e0de0d

You can also customize only the roulette items.

```swift
@StateObject var rouletteController: RouletteController = .init(sectors: [
    .init(index: 0, count: 5, color: .red),
    .init(index: 1, count: 5, color: .blue),
    .init(index: 2, count: 5, color: .green),
    .init(index: 3, count: 5, color: .yellow),
    .init(index: 4, count: 5, color: .gray),
])
RouletteView(rouletteController: rouletteController) { sector in
    Image(systemName: "\(sector.id + 1).square.fill")
      .resizable()
      .scaledToFit()
      .frame(width: 40)
      .rotationEffect(.degrees((sector.start.degrees + rouletteController.roulette.degreePerSector) / 2 + 90 + (rouletteController.roulette.degreePerSector / 2 * Double(sector.id))))
} center: {
    switch rouletteController.status {
    case .idle, .complete:
        Button("START") {
            rouletteController.start()
        }
    case .rotating, .stopping:
        Button("STOP") {
            rouletteController.stop()
        }
        .disabled(rouletteController.status == .stopping)
    }
}
```

https://github.com/user-attachments/assets/bfff332e-6b19-4620-a72a-d4df91698741

## Implement only UI components on your own

If you want the design to fit the concept of your app, you can implement your own UI.
For example, you can use an image as a roulette.

> [!NOTE]
> Note that the data begins with the sector directly above and to the left. For example, the image used in the demo movie has “No. 2” in the upper left sector, so the data set should start with the No. 2 data accordingly.

```swift
@StateObject private var rouletteController: RouletteController = .init(sectors: [
    .init(index: 0, count: 4, text: "NO.2", color: .red),
    .init(index: 1, count: 4, text: "NO.3", color: .blue),
    .init(index: 2, count: 4, text: "NO.4", color: .green),
    .init(index: 3, count: 4, text: "NO.1", color: .yellow),
])

var body: some View {
    VStack {
        Spacer()
        roulette
        HStack {
            Button("START") {
                rouletteController.start()
            }
            Button("STOP") {
                rouletteController.stop()
            }
        }
        Text("結果: \(rouletteController.roulette.hitSector.text ?? "")")
            .opacity(rouletteController.status == .complete ? 1 : 0)
        Spacer()
    }
  }

var roulette: some View {
    ZStack(alignment: .top) {
        Image("custom_image")
            .resizable()
            .scaledToFit()
            .frame(width: 360)
            .rotationEffect(.degrees(rouletteController.rotateAngle.degrees))
        Image(systemName: "arrowtriangle.down.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .shadow(radius: 8)
    }
}
```

https://github.com/user-attachments/assets/373b22e8-6d83-4371-86b9-cabc03beea74

# Development Environment

- Xcode 16.0.0 Beta.6
