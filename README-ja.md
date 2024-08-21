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

## UI コンポーネントのみ独自で実装する

デザインをアプリのコンセプトに合わせたい場合、UI を独自に実装することもできます。
例えば画像をそのままルーレットに設定することもできます。



0, 72, 144, 216, 288, 360

# 開発環境

- Xcode 16.0.0+
