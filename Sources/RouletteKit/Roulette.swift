//
//  Roulette.swift
//  RouletteKit
//
//  Created by shun uematsu on 2024/08/03.
//

import SwiftUI

// MARK: - Roulette

/// Model representing a roulette board
public struct Roulette {
  /// Set of roulette segments
  public let sectors: [Sector]
  /// Angle per sector
  public let degreePerSector: Double
  /// Winning Sector
  public let hitSector: Sector
  /// Angle advanced from start of stop to end of stop
  let forwardAngle: Angle = {
    var sum: Double = 0
    for i in 1...Int(Double(decelerationTime.components.seconds) / deceleration) {
      sum += (velocity - Double(i) * deceleration)
    }
    return Angle(degrees: round(for: sum))
  }()

  init(sectors: [Sector], hitDegrees: Double = .random(in: 0..<360)) {
    if sectors.count >= 72 {
      fatalError("Unsupported that number of data is 72 or more.")
    }
    self.sectors = sectors
    self.degreePerSector = round(for: 360 / Double(sectors.count))
    self.hitSector = sectors.first(where: {
      return ($0.start.degreesInCircle..<$0.end.degreesInCircle).contains(round(for: hitDegrees))
    }) ?? sectors.first!
    print("Hit sector: \(hitSector.text ?? "\(hitSector.id)")")
  }

  /// Calculate the angle of rotation to stop at a specific sector
  func stopRotatingDegrees() -> [Range<Double>] {
    let point = Angle(degrees: 270 - forwardAngle.degreesInCircle).degreesInCircle
    let lhs: Double = {
      let degrees = round(for: hitSector.start.degrees)
      return Angle(degrees: point - degrees).degreesInCircle
    }()
    let rhs: Double = {
      let degrees = round(for: hitSector.end.degrees)
      return Angle(degrees: point - degrees).degreesInCircle
    }()
    let splitDegrees = degreePerSector / Self.velocity <= Self.velocity ? Self.velocity : degreePerSector / Self.velocity
    let isCrossedBorder = rhs + degreePerSector > 360
    if isCrossedBorder {
      let startSequence = stride(from: 0, to: lhs, by: splitDegrees).shuffled()
      let endSequence = stride(from: rhs, to: 360, by: splitDegrees).shuffled()
      let startFirst = startSequence.first!
      let startLast = startFirst + splitDegrees > lhs ? lhs : startFirst + splitDegrees
      let endFirst = endSequence.first!
      let endLast = endFirst + splitDegrees > 360 ? 360 : endFirst + splitDegrees
      return [startFirst..<startLast, endFirst..<endLast]
    } else {
      let start = min(lhs, rhs)
      let end = max(lhs, rhs)
      let sequence = stride(from: start, to: end, by: splitDegrees).shuffled()
      let first = sequence.first!
      let last = first + splitDegrees > end ? end : first + splitDegrees
      return [first..<last]
    }
  }
}

// MARK: - Const

extension Roulette {
  /// Roulette time per velocity
  static let interval: Duration = .seconds(0.01)
  /// Clockwise rotation speed (rotation speed / interval)
  static let velocity: Double = 5
  /// Deceleration
  static let deceleration: Double = 0.01
  /// How many seconds to set the rotational speed to 0
  static let decelerationTime: Duration = .seconds(5)
  /// Width of the outer frame of the roule
  static let outlineWidth: Double = 20
  /// Ratio of center circle to roulette section
  static let centerCircleRatio: Double = 0.25
}

// MARK: - Helper

extension Roulette {
  /// Radius of roulette section (excluding outer frame)
  static func raidus(width: Double, height: Double) -> Double {
    min(width - outlineWidth, height - outlineWidth) / 2
  }

  /// Diameter of center circle
  static func centerCircleDiameter(width: Double) -> Double {
    (width - outlineWidth) * centerCircleRatio
  }
}

// MARK: - Sector

extension Roulette {
  public struct Sector: Identifiable {
    public var id: Int
    public var text: String?
    public var color: Color
    public var start: Angle
    public var end: Angle

    public init(index: Int, count: Int, text: String? = nil, color: Color) {
      let degreePerSector = 360.0 / Double(count)
      self.id = index
      self.text = text
      self.color = color
      self.start = .degrees(degreePerSector * Double(index))
      self.end = .degrees(degreePerSector * Double(index + 1))
    }
  }
}
