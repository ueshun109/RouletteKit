//
//  Angle+.swift
//  RouletteKit
//
//  Created by shun uematsu on 2024/08/03.
//

import SwiftUI

extension Angle {
  /// 円における角度（0度〜360度）を返す
  var degreesInCircle: Double {
    if self.degrees == 0 {
      0
    } else if self.degrees.truncatingRemainder(dividingBy: 360) == 0 {
      360
    } else if self.degrees < 0 {
      360 + round(for: self.degrees.truncatingRemainder(dividingBy: 360))
    } else {
      round(for: self.degrees.truncatingRemainder(dividingBy: 360))
    }
  }
}
