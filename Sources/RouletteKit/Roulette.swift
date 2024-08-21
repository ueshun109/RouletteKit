//
//  Roulette.swift
//  RouletteKit
//
//  Created by shun uematsu on 2024/08/03.
//

import SwiftUI

// MARK: - Roulette

/// ルーレットの盤面を表すモデル
public struct Roulette {
  /// ルーレットの区分の集合
  let sectors: [Sector]
  /// １つのセクター当たりの角度
  let degreePerSector: Double
  /// 当たりのセクター
  public let hitSector: Sector
  /// 停止開始から停止終了するまでの進んだ角度
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
    self.degreePerSector = round(for: 360.0 / Double(sectors.count))
    self.hitSector = sectors.first(where: {
      return ($0.start.degreesInCircle..<$0.end.degreesInCircle).contains(round(for: hitDegrees))
    }) ?? sectors.first!
  }

  /// 特定のセクターに停止させるための回転角度を算出する
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
    print("lhs: \(lhs), rhs: \(rhs), \(hitSector.text ?? "")")
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
  /// ルーレットのベロシティ当たりの時間
  static let interval: Duration = .seconds(0.01)
  /// 時計回り方向の回転速度（回転速度 / interval）
  static let velocity: Double = 5
  /// 減速度
  static let deceleration: Double = 0.01
  /// 何秒かけて回転速度を0にするか
  static let decelerationTime: Duration = .seconds(5)
  /// ルーレットの外枠の幅
  static let outlineWidth: Double = 20
  /// ルーレット部分に対する中心円の比率
  static let centerCircleRatio: Double = 0.25
}

// MARK: - Helper

extension Roulette {
  /// ルーレット部分の半径（外枠を除く）
  static func raidus(width: Double, height: Double) -> Double {
    min(width - outlineWidth, height - outlineWidth) / 2
  }

  /// 中心円の直径
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
