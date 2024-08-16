//
//  Pie.swift
//  RouletteKit
//
//  Created by shun uematsu on 2024/07/31.
//

import SwiftUI

struct Pie: Shape {
  let startAngle: Angle
  let endAngle: Angle

  nonisolated func path(in rect: CGRect) -> Path {
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radius = min(rect.width, rect.height) / 2
    let start = CGPoint(
      x: center.x + radius * CGFloat(cos(startAngle.radians)),
      y: center.y + radius * CGFloat(sin(startAngle.radians))
    )
    return Path { path in
      path.move(to: center)
      path.addLine(to: start)
      path.addArc(
        center: center,
        radius: radius,
        startAngle: startAngle,
        endAngle: endAngle,
        clockwise: false
      )
    }
  }
}
