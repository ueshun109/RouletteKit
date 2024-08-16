import AsyncAlgorithms
import SwiftUI

@MainActor
public final class RouletteController: ObservableObject {
  @Published private(set) var rotateAngle: Angle = .degrees(0)
  /// 回転させるために使用するタイマー
  private let rouletteTimer = AsyncTimerSequence(interval: Roulette.interval, clock: .continuous)
  /// 停止開始から回転速度を減速させるために使用するタイマー
  ///
  /// forwardAngle分を一定期間かけて減らしていけばよいのか？そうすれば微妙にずれることはなくなる？
  private let stopTimer = AsyncTimerSequence(
    interval: Roulette.interval,
    clock: .continuous
  )
  /// ルーレット
  public let roulette: Roulette
  /// 止めるアニメーションを開始したいポイント
  private let stopPoint: [Range<Double>]
  /// 回転速度
  private var velocity = Roulette.velocity
  private var pause = false
  private var rouletteTask: Task<(), Never>? = nil
  private var stopTask: Task<(), Never>? = nil

  public init(sectors: [Roulette.Sector]) {
    self.roulette = .init(sectors: sectors)
    self.stopPoint = roulette.stopRotatingDegrees()
  }

  public func start() {
    rouletteTask = Task {
      for await _ in rouletteTimer {
        rotateAngle += .degrees(velocity)
      }
    }
  }

  public func stop() {
    stopTask = Task {
      for await _ in stopTimer {
        if !pause, (stopPoint.first!.contains(rotateAngle.degreesInCircle) || stopPoint.last?.contains(rotateAngle.degreesInCircle) == true) {
          velocity -= Roulette.deceleration
          pause = true
          continue
        } else if pause {
          velocity -= Roulette.deceleration
          if velocity <= 0 {
            stopTask?.cancel()
          }
        }
      }
      rouletteTask?.cancel()
    }
  }
}
