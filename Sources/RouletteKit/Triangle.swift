//
//  Triangle.swift
//  RouletteKit
//
//  Created by shun uematsu on 2024/08/01.
//

import SwiftUI

struct Triangle: Shape {
  nonisolated func path(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: .init(x: rect.midX, y: rect.maxY))
      path.addLine(to: .init(x: rect.maxX, y: rect.minY))
      path.addLine(to: .init(x: rect.minX, y: rect.minY))
      path.closeSubpath()
    }
  }
}
