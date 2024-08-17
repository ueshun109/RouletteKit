import AsyncAlgorithms
import SwiftUI

@MainActor
public final class RouletteController: ObservableObject {
  @Published private(set) var rotateAngle: Angle = .degrees(0)
  /// 回転させるために使用するタイマー
  private let rouletteTimer = AsyncTimerSequence(
    interval: Roulette.interval,
    clock: .continuous
  )
  /// 停止開始から回転速度を減速させるために使用するタイマー
  ///
  /// forwardAngle分を一定期間かけて減らしていけばよいのか？そうすれば微妙にずれることはなくなる？
  private let stopTimer = AsyncTimerSequence(
    interval: Roulette.interval,
    clock: .continuous
  )
  /// ルーレット
  @Published public var roulette: Roulette
  @Published public var status: Status = .idle
  /// 止めるアニメーションを開始したいポイント
  private var stopPoint: [Range<Double>]
  /// 回転速度
  private var velocity = Roulette.velocity
  private var pause = false
  private var rouletteTask: Task<(), Never>? = nil
  private var stopTask: Task<(), Never>? = nil

  public init(sectors: [Roulette.Sector]) {
    let roulette = Roulette(sectors: sectors)
    self.roulette = roulette
    self.stopPoint = roulette.stopRotatingDegrees()
  }

  public func start() {
    guard status == .idle || status == .complete else { return }
    if status == .complete { reset() }
    status = .rotating
    rouletteTask = Task {
      for await _ in rouletteTimer {
        rotateAngle += .degrees(velocity)
      }
    }
  }

  public func stop() {
    guard status == .rotating else { return }
    status = .stopping
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
            status = .complete
          }
        }
      }
      rouletteTask?.cancel()
    }
  }

  public func reset() {
    roulette = .init(sectors: roulette.sectors)
    stopPoint = roulette.stopRotatingDegrees()
    pause = false
    velocity = Roulette.velocity
  }
}

// MARK: Status

public extension RouletteController {
  enum Status {
    case idle
    case rotating
    case stopping
    case complete
  }
}
