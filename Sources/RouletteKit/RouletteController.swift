import AsyncAlgorithms
import SwiftUI

/// Logic to control roulette
@MainActor
public final class RouletteController: ObservableObject {
  @Published public private(set) var rotateAngle: Angle = .degrees(270)
  @Published public private(set) var roulette: Roulette
  @Published public private(set) var status: Status = .idle
  /// Timer used to rotate
  private let rouletteTimer = AsyncTimerSequence(
    interval: Roulette.interval,
    clock: .continuous
  )
  /// Timer used to decelerate the rotation speed from the start of stop
  private let stopTimer = AsyncTimerSequence(
    interval: Roulette.interval,
    clock: .continuous
  )
  /// The point at which you want to start decelerating
  private var stopPoint: [Range<Double>]
  private var velocity = Roulette.velocity
  private var pause = false
  private var rouletteTask: Task<(), Never>? = nil
  private var stopTask: Task<(), Never>? = nil

  public init(sectors: [Roulette.Sector] = []) {
    let roulette = Roulette(sectors: sectors)
    self.roulette = roulette
    self.stopPoint = roulette.stopRotatingDegrees()
  }

  public func configure(sectors: [Roulette.Sector]) {
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
