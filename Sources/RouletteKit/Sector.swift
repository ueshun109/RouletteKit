//
//  Sector.swift
//  RouletteKit
//
//  Created by shun uematsu on 2024/08/02.
//

import SwiftUI

public struct Sector: Identifiable {
  public var id: Int
  public var text: String
  public var color: Color
  public var start: Angle
  public var end: Angle

  public init(id: Int, text: String, color: Color, dataCount: Int) {
    let degreePerSector = 360.0 / Double(dataCount)
    self.id = id
    self.text = text
    self.color = color
    self.start = .degrees(degreePerSector * Double(id))
    self.end = .degrees(degreePerSector * Double(id + 1))
  }
}
