# RouletteKit

RouletteKit は、SwiftUI で実装されており以下の機能を提供します。

- ルーレットを実現するための必要なロジック
- シンプルなルーレットの UI コンポーネント

# サポートバージョン

- iOS 16.0+

# インストール方法

Swift Package Manager のみ対応しています。

```swift
dependencies: [
    .package(url: "https://github.com/ueshun109/RouletteKit", from: "1.0.0")
]
```

# 使い方

本ライブラリが提供している UI コンポーネントを使用することができ、また UI コンポーネント部分のみカスタマイズすることも可能です。

## 本ライブラリが提供している UI コンポーネントを使用する

ルーレットの項目としてテキストを設定する場合、、以下のように提供している UI コンポーネント（`RouletteView`）を使用することができます。

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

またルーレットの項目のみカスタマイズすることもできます。

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
.padding()
```

https://github.com/user-attachments/assets/bfff332e-6b19-4620-a72a-d4df91698741

## UI コンポーネントのみ独自で実装する

デザインをアプリのコンセプトに合わせたい場合、UI を独自に実装することもできます。
例えば画像をそのままルーレットに設定することもできます。

# 開発環境

- Xcode 16.0.0+
