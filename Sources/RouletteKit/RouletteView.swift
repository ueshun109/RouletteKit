//
//   RouletteView.swift
//  RouletteKit
//
//  Created by shun uematsu on 2024/07/31.
//

import SwiftUI

public struct RouletteView: View {
  @ObservedObject private var model: RouletteController

  public init(rouletteController: RouletteController) {
    self.model = rouletteController
  }

  public var body: some View {
    GeometryReader { proxy in
      let center = min(proxy.frame(in: .local).midX, proxy.frame(in: .local).midY)
      let rouletteRadius = Roulette.raidus(
        width: proxy.frame(in: .local).width,
        height: proxy.frame(in: .local).height
      )
      let centerCircleDiameter = Roulette.centerCircleDiameter(width: proxy.frame(in: .local).width)
      ZStack(alignment: .top) {
        ZStack {
          outline(rouletteRadius)
          roulette(center, rouletteRadius: rouletteRadius, centerCircleRadius: centerCircleDiameter / 2)
          centerCircle(diameter: centerCircleDiameter)
        }
        hitPoint(size: proxy.size.width * 0.1)
      }
    }
  }

  /// 🔘 Center circle
  func centerCircle(diameter: Double) -> some View {
    Circle()
      .fill(Color.white)
      .frame(width: diameter)
      .overlay {
        Image(systemName: "star.fill")
          .resizable()
          .scaledToFit()
          .frame(width: diameter / 2)
          .foregroundStyle(Color.orange)
      }
  }

  /// ⭕ Outline circle
  func outline(_ rouletteRadius: Double) -> some View {
    Circle()
      .fill(Color.white)
      .frame(
        width: rouletteRadius * 2 + Roulette.outlineWidth,
        height: rouletteRadius * 2 + Roulette.outlineWidth)
      .shadow(radius: 8)
  }

  /// 🎯 Roulette circle
  func roulette(_ center: Double, rouletteRadius: Double, centerCircleRadius: Double) -> some View {
    ZStack {
      ForEach(model.roulette.sectors) { sector in
        Pie(startAngle: sector.start, endAngle: sector.end)
          .fill(sector.color)
      }
      ForEach(model.roulette.sectors) { sector in
        sectorContent(
          sector: sector,
          center: center,
          rouletteRadius: rouletteRadius,
          centerCircleRadius: centerCircleRadius
        )
      }
    }
    .rotationEffect(.degrees(model.rotateAngle.degrees))
    .animation(.linear, value: model.rotateAngle)
    .frame(width: rouletteRadius * 2, height: rouletteRadius * 2)
  }

  /// 🏹 Hit point
  func hitPoint(size: CGFloat) -> some View {
    Image(systemName: "arrowtriangle.down.fill")
      .resizable()
      .scaledToFit()
      .frame(width: size, height: size)
      .shadow(radius: 8)
  }

  /// 🥧 Sector content
  func sectorContent(
    sector: Roulette.Sector,
    center: Double,
    rouletteRadius: Double,
    centerCircleRadius: Double
  ) -> some View {
    Text(sector.text)
      .lineLimit(1)
      .font(.body)
      .bold()
      .frame(width: rouletteRadius - centerCircleRadius)
      .rotationEffect(.degrees(sector.start.degrees + model.roulette.degreePerSector / 2))
      .offset(
        CGSize(
          width: { () -> Double in
            let mean = (sector.start + sector.end) / 2
            return (center + centerCircleRadius) * 0.5 * cos(mean.radians)
          }(),
          height: { () -> Double in
            let mean = (sector.start + sector.end) / 2
            return (center + centerCircleRadius) * 0.5 * sin(mean.radians)
          }()
        )
      )
  }
}

@available(iOS 18.0, *)
#Preview {
  @Previewable @StateObject var rouletteController: RouletteController = .init(sectors: [
    .init(id: 0, text: "RED", color: .red, dataCount: 9),
    .init(id: 1, text: "BLUE", color: .blue, dataCount: 9),
    .init(id: 2, text: "GREEN", color: .green, dataCount: 9),
    .init(id: 3, text: "YELLOW", color: .yellow, dataCount: 9),
    .init(id: 4, text: "BROWN", color: .brown, dataCount: 9),
    .init(id: 5, text: "purplepurplepurple", color: .purple, dataCount: 9),
    .init(id: 6, text: "gray", color: .gray, dataCount: 9),
    .init(id: 7, text: "pink", color: .pink, dataCount: 9),
    .init(id: 8, text: "cyan", color: .cyan, dataCount: 9),
  ])
  let two: [Roulette.Sector] = [
    .init(id: 0, text: "RED", color: .red, dataCount: 2),
    .init(id: 1, text: "BLUE", color: .blue, dataCount: 2),
  ]

  let sectors: [Roulette.Sector] = [
    .init(id: 0, text: "RED", color: .red, dataCount: 9),
    .init(id: 1, text: "BLUE", color: .blue, dataCount: 9),
    .init(id: 2, text: "GREEN", color: .green, dataCount: 9),
    .init(id: 3, text: "YELLOW", color: .yellow, dataCount: 9),
    .init(id: 4, text: "BROWN", color: .brown, dataCount: 9),
    .init(id: 5, text: "purple", color: .purple, dataCount: 9),
    .init(id: 6, text: "gray", color: .gray, dataCount: 9),
    .init(id: 7, text: "pink", color: .pink, dataCount: 9),
    .init(id: 8, text: "cyan", color: .cyan, dataCount: 9),
  ]
  return VStack {
    Text("Hit: \(rouletteController.roulette.hitSector.text)")
    RouletteView(rouletteController: rouletteController)
      .frame(width: 300, height: 300)
    Button("START") {
      rouletteController.start()
    }
    Button("STOP") {
      rouletteController.stop()
    }
    Button("RESET") {
      rouletteController.reset()
    }
  }
  .padding()
}
