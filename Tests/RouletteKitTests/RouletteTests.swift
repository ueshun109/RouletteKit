//
//  RouletteTests.swift
//  RouletteKit
//
//  Created by shun uematsu on 2024/08/06.
//

import Testing
@testable import RouletteKit

struct RouletteTests {
  struct TwoSectors {
    @Test("RED", arguments: [0.0, 179.9, 360.0])
    func redIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .two, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((0..<103).overlaps(range.first!))
      #expect((283..<360).overlaps(range.last!))
    }

    @Test("BLUE", arguments: [180, 359.9])
    func blueIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .two, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((103..<283).overlaps(range.first!))
    }
  }

  struct ThreeSectors {
    @Test("RED", arguments: [0.0, 119.9, 360.0])
    func redIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .three, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((0.0..<103).overlaps(range.first!))
      #expect((343..<360).overlaps(range.last!))
    }

    @Test("BLUE", arguments: [120.0, 239.9])
    func blueIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .three, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((223..<343).overlaps(range.first!))
    }

    @Test("GREEN", arguments: [240.0, 359.9])
    func geeenIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .three, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((103..<223).overlaps(range.first!))
    }
  }

  struct FourSectors {
    @Test("RED", arguments: [0.0, 89.9, 360.0])
    func redIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .four, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((13..<103).overlaps(range.first!))
    }

    @Test("BLUE", arguments: [90, 179.9])
    func blueIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .four, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((0..<13).overlaps(range.first!))
      #expect((283..<360).overlaps(range.last!))
    }

    @Test("GREEN", arguments: [180, 269.9])
    func geeenIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .four, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((193..<283).overlaps(range.first!))
    }

    @Test("YELLOW", arguments: [270, 359.9])
    func yellowIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .four, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((103.0..<193).overlaps(range.first!))
    }

  }

  struct FiveSectors {
    @Test("RED", arguments: [0.0, 36.0, 69.9, 360.0])
    func redIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .five, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((31.0..<103.0).overlaps(range.first!))
    }

    @Test("BLUE", arguments: [72.0, 108.0, 143.9])
    func blueIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .five, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((0.0..<31.0).overlaps(range.first!))
      #expect((319.0..<360.0).overlaps(range.last!))
    }

    @Test("GREEN", arguments: [144.0, 180.0, 215.9])
    func geeenIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .five, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((247.0..<319.0).overlaps(range.first!))
    }

    @Test("YELLOW", arguments: [216.0, 278.0, 279.9])
    func yellowIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .five, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((175.0..<247.0).overlaps(range.first!))
    }

    @Test("BROWN", arguments: [288.0, 320.0, 359.9])
    func brownIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .five, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((103.0..<175.0).overlaps(range.first!))
    }
  }

  struct SixSectors {
    @Test("RED", arguments: [0.0, 59.9, 360.0])
    func redIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .six, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((43..<103.0).overlaps(range.first!))
    }

    @Test("BLUE", arguments: [60.0, 119.9])
    func blueIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .six, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((0.0..<43.0).overlaps(range.first!))
      #expect((343..<360.0).overlaps(range.last!))
    }

    @Test("GREEN", arguments: [120.0, 179.9])
    func geeenIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .six, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((283..<343.0).overlaps(range.first!))
    }

    @Test("YELLOW", arguments: [180.0, 239.9])
    func yellowIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .six, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((223.0..<283.0).overlaps(range.first!))
    }

    @Test("BROWN", arguments: [240, 299.9])
    func brownIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .six, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((163.0..<223.0).overlaps(range.first!))
    }

    @Test("PURPLE", arguments: [300, 359.9])
    func purpleIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .six, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((103.0..<163.0).overlaps(range.first!))
    }
  }

  struct SevenSectors {
    @Test("RED", arguments: [0.0, 51.3, 360.0])
    func redIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .seven, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((52..<103.0).overlaps(range.first!))
    }

    @Test("BLUE", arguments: [51.4, 102.7])
    func blueIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .seven, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((0.0..<52.0).overlaps(range.first!))
    }

    @Test("GREEN", arguments: [102.9, 154.2])
    func geeenIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .seven, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      print("whats?: \(range), hitDegrees: \(hitDegrees), roulette: \(roulette.hitSector.text)")
      #expect((309.0..<360).overlaps(range.first!))
    }

    @Test("YELLOW", arguments: [154.3, 205.6])
    func yellowIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .seven, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((257.0..<309.0).overlaps(range.first!))
    }

    @Test("BROWN", arguments: [205.7, 257.0])
    func brownIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .seven, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((206.0..<257.0).overlaps(range.first!))
    }

    @Test("PURPLE", arguments: [257.1, 308.5])
    func purpleIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .seven, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((154.0..<206.0).overlaps(range.first!))
    }

    @Test("GRAY", arguments: [308.6, 359.9])
    func grayIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .seven, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((103.0..<154.0).overlaps(range.first!))
    }
  }

  struct EightSectors {
    @Test("RED", arguments: [0.0, 44.9, 360.0])
    func redIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .eight, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((58..<103.0).overlaps(range.first!))
    }

    @Test("BLUE", arguments: [45.0, 89.9])
    func blueIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .eight, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((0.0..<52.0).overlaps(range.first!))
    }

    @Test("GREEN", arguments: [90, 134.9])
    func geeenIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .eight, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      print("whats?: \(range), hitDegrees: \(hitDegrees), roulette: \(roulette.hitSector.text)")
      #expect((0.0..<13.0).overlaps(range.first!))
      #expect((328..<360).overlaps(range.last!))
    }

    @Test("YELLOW", arguments: [135.0, 179.9])
    func yellowIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .eight, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((283.0..<328.0).overlaps(range.first!))
    }

    @Test("BROWN", arguments: [180.0, 224.9])
    func brownIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .eight, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((238.0..<283.0).overlaps(range.first!))
    }

    @Test("PURPLE", arguments: [225.0, 269.9])
    func purpleIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .eight, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((193.0..<238.0).overlaps(range.first!))
    }

    @Test("GRAY", arguments: [270.0, 314.9])
    func grayIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .eight, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((148.0..<193.0).overlaps(range.first!))
    }

    @Test("CYAN", arguments: [315.0, 359.9])
    func cyanIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .eight, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((103.0..<148).overlaps(range.first!))
    }
  }

  struct NineSectors {
    @Test("RED", arguments: [0.0, 39.9, 360.0])
    func redIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .nine, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((63..<103.0).overlaps(range.first!))
    }

    @Test("BLUE", arguments: [40.0, 79.9])
    func blueIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .nine, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((27..<63.0).overlaps(range.first!))
    }

    @Test("GREEN", arguments: [80, 119.9])
    func geeenIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .nine, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      print("whats?: \(range), hitDegrees: \(hitDegrees), roulette: \(roulette.hitSector.text)")
      #expect((0..<27).overlaps(range.first!))
      #expect((343..<360).overlaps(range.last!))
    }

    @Test("YELLOW", arguments: [120.0, 159.9])
    func yellowIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .nine, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((303..<343).overlaps(range.first!))
    }

    @Test("BROWN", arguments: [160.0, 199.9])
    func brownIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .nine, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((263..<303).overlaps(range.first!))
    }

    @Test("PURPLE", arguments: [200.0, 239.9])
    func purpleIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .nine, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((223..<263).overlaps(range.first!))
    }

    @Test("GRAY", arguments: [240.0, 279.9])
    func grayIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .nine, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((183..<223).overlaps(range.first!))
    }

    @Test("CYAN", arguments: [280.0, 319.9])
    func cyanIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .nine, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((143.0..<183).overlaps(range.first!))
    }

    @Test("PINK", arguments: [320.0, 359.9])
    func pinkIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .nine, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((103.0..<143.0).overlaps(range.first!))
    }
  }

  struct TenSectors {
    @Test("RED", arguments: [0.0, 35.9, 360.0])
    func redIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .ten, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((67..<103).overlaps(range.first!))
    }

    @Test("BLUE", arguments: [36.0, 71.9])
    func blueIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .ten, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((31..<67).overlaps(range.first!))
    }

    @Test("GREEN", arguments: [72, 107.9])
    func geeenIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .ten, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((0..<31).overlaps(range.first!))
      #expect((355..<360).overlaps(range.last!))
    }

    @Test("YELLOW", arguments: [108.0, 143.9])
    func yellowIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .ten, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((319..<355).overlaps(range.first!))
    }

    @Test("BROWN", arguments: [144, 179.9])
    func brownIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .ten, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((283..<319).overlaps(range.first!))
    }

    @Test("PURPLE", arguments: [180, 215.9])
    func purpleIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .ten, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((247..<283).overlaps(range.first!))
    }

    @Test("GRAY", arguments: [216, 251.9])
    func grayIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .ten, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((211..<247).overlaps(range.first!))
    }

    @Test("CYAN", arguments: [252, 287.9])
    func cyanIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .ten, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((175..<211).overlaps(range.first!))
    }

    @Test("PINK", arguments: [288, 323.9])
    func pinkIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .five, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((139..<175.0).overlaps(range.first!))
    }

    @Test("TEAL", arguments: [324, 359.9])
    func tealIsHit(_ hitDegrees: Double) {
      let roulette: Roulette = .init(sectors: .ten, hitDegrees: hitDegrees)
      let range = roulette.stopRotatingDegrees()
      #expect((103.0..<139).overlaps(range.first!))
    }
  }
}

private extension [Roulette.Sector] {
  static let two: Self = [
    .init(id: 0, text: "RED", color: .red, dataCount: 2),
    .init(id: 1, text: "BLUE", color: .blue, dataCount: 2),
  ]

  static let three: Self = [
    .init(id: 0, text: "RED", color: .red, dataCount: 3),
    .init(id: 1, text: "BLUE", color: .blue, dataCount: 3),
    .init(id: 2, text: "GREEN", color: .green, dataCount: 3),
  ]

  static let four: Self = [
    .init(id: 0, text: "RED", color: .red, dataCount: 4),
    .init(id: 1, text: "BLUE", color: .blue, dataCount: 4),
    .init(id: 2, text: "GREEN", color: .green, dataCount: 4),
    .init(id: 3, text: "YELLOW", color: .yellow, dataCount: 4),
  ]

  static let five: Self = [
    .init(id: 0, text: "RED", color: .red, dataCount: 5),
    .init(id: 1, text: "BLUE", color: .blue, dataCount: 5),
    .init(id: 2, text: "GREEN", color: .green, dataCount: 5),
    .init(id: 3, text: "YELLOW", color: .yellow, dataCount: 5),
    .init(id: 4, text: "BROWN", color: .brown, dataCount: 5),
  ]

  static let six: Self = [
    .init(id: 0, text: "RED", color: .red, dataCount: 6),
    .init(id: 1, text: "BLUE", color: .blue, dataCount: 6),
    .init(id: 2, text: "GREEN", color: .green, dataCount: 6),
    .init(id: 3, text: "YELLOW", color: .yellow, dataCount: 6),
    .init(id: 4, text: "BROWN", color: .brown, dataCount: 6),
    .init(id: 5, text: "PURPLE", color: .purple, dataCount: 6),
  ]

  static let seven: Self = [
    .init(id: 0, text: "RED", color: .red, dataCount: 7),
    .init(id: 1, text: "BLUE", color: .blue, dataCount: 7),
    .init(id: 2, text: "GREEN", color: .green, dataCount: 7),
    .init(id: 3, text: "YELLOW", color: .yellow, dataCount: 7),
    .init(id: 4, text: "BROWN", color: .brown, dataCount: 7),
    .init(id: 5, text: "PURPLE", color: .purple, dataCount: 7),
    .init(id: 6, text: "GRAY", color: .gray, dataCount: 7),
  ]

  static let eight: Self = [
    .init(id: 0, text: "RED", color: .red, dataCount: 8),
    .init(id: 1, text: "BLUE", color: .blue, dataCount: 8),
    .init(id: 2, text: "GREEN", color: .green, dataCount: 8),
    .init(id: 3, text: "YELLOW", color: .yellow, dataCount: 8),
    .init(id: 4, text: "BROWN", color: .brown, dataCount: 8),
    .init(id: 5, text: "PURPLE", color: .purple, dataCount: 8),
    .init(id: 6, text: "GRAY", color: .gray, dataCount: 8),
    .init(id: 7, text: "CYAN", color: .cyan, dataCount: 8),
  ]

  static let nine: Self = [
    .init(id: 0, text: "RED", color: .red, dataCount: 9),
    .init(id: 1, text: "BLUE", color: .blue, dataCount: 9),
    .init(id: 2, text: "GREEN", color: .green, dataCount: 9),
    .init(id: 3, text: "YELLOW", color: .yellow, dataCount: 9),
    .init(id: 4, text: "BROWN", color: .brown, dataCount: 9),
    .init(id: 5, text: "PURPLE", color: .purple, dataCount: 9),
    .init(id: 6, text: "GRAY", color: .gray, dataCount: 9),
    .init(id: 7, text: "CYAN", color: .cyan, dataCount: 9),
    .init(id: 8, text: "PINK", color: .pink, dataCount: 9),
  ]

  static let ten: Self = [
    .init(id: 0, text: "RED", color: .red, dataCount: 10),
    .init(id: 1, text: "BLUE", color: .blue, dataCount: 10),
    .init(id: 2, text: "GREEN", color: .green, dataCount: 10),
    .init(id: 3, text: "YELLOW", color: .yellow, dataCount: 10),
    .init(id: 4, text: "BROWN", color: .brown, dataCount: 10),
    .init(id: 5, text: "PURPLE", color: .purple, dataCount: 10),
    .init(id: 6, text: "GRAY", color: .gray, dataCount: 10),
    .init(id: 7, text: "CYAN", color: .cyan, dataCount: 10),
    .init(id: 8, text: "PINK", color: .pink, dataCount: 10),
    .init(id: 9, text: "TEAL", color: .teal, dataCount: 10),
  ]

  static let max: Self = (0..<71).map { i in
      .init(id: i, text: "\(i)", color: .red, dataCount: 71)
  }
}

extension RouletteTests {
  static let maxHitDegrees: [Double] = Array<Int>(0...360).map{ Double($0) }
}
