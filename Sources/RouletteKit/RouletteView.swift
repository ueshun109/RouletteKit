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
      let midX = proxy.frame(in: .local).midX
      let midY = proxy.frame(in: .local).midY
      let center = min(midX, midY)
      VStack {
        ZStack(alignment: .top) {
          roulette(center)
          hitPoint(size: proxy.size.width * 0.1)
        }
      }
    }
  }

  func roulette(_ center: Double) -> some View {
    ZStack {
      ForEach(model.roulette.sectors) { sector in
        Pie(startAngle: sector.start, endAngle: sector.end)
          .fill(sector.color)
      }
      ForEach(model.roulette.sectors) { sector in
        ZStack {
          Text(sector.text)
            .font(.body)
            .bold()
            .rotationEffect(.degrees(sector.start.degrees + model.roulette.degreePerSector / 2))
            .offset(
              CGSize(
                width: { () -> Double in
                  let mean = (sector.start + sector.end) / 2
                  return center * 0.5 * cos(mean.radians)
                }(),
                height: { () -> Double in
                  let mean = (sector.start + sector.end) / 2
                  return center * 0.5 * sin(mean.radians)
                }()
              )
            )
        }
      }
    }
    .rotationEffect(.degrees(model.rotateAngle.degrees))
    .animation(.linear, value: model.rotateAngle)
  }

  func hitPoint(size: CGFloat) -> some View {
    Triangle()
      .fill(Color.black)
      .frame(width: size, height: size)
  }
}

@available(iOS 18.0, *)
#Preview {
  @Previewable @StateObject var rouletteController: RouletteController = .init(sectors: [
    .init(id: 0, text: "RED", color: .red, dataCount: 2),
    .init(id: 1, text: "BLUE", color: .blue, dataCount: 2),
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
  }
  .padding()
}
