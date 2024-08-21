//
//   RouletteView.swift
//  RouletteKit
//
//  Created by shun uematsu on 2024/07/31.
//

import SwiftUI

public struct RouletteView<Content, Center>: View where Content: View, Center: View {
  @ObservedObject private var model: RouletteController
  private let content: ((Roulette.Sector) -> Content)?
  private let center: (() -> Center)?

  public init(
    rouletteController: RouletteController
  ) where Content == EmptyView, Center == EmptyView {
    self.model = rouletteController
    self.content = nil
    self.center = nil
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

  @ViewBuilder
  /// 🔘 Center circle
  func centerCircle(diameter: Double) -> some View {
    Circle()
      .fill(Color.white)
      .frame(width: diameter)
      .overlay {
        if let center {
          center()
        } else {
          Image(systemName: "star.fill")
            .resizable()
            .scaledToFit()
            .frame(width: diameter / 2)
            .foregroundStyle(Color.orange)
        }
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
    Group {
      if let content {
        content(sector)
      } else {
        Text(sector.text ?? "")
          .lineLimit(1)
          .font(.body)
          .bold()
          .rotationEffect(.degrees(sector.start.degrees + model.roulette.degreePerSector / 2))
      }
    }
    .frame(width: rouletteRadius - centerCircleRadius)
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

// MARK: - Initializer

public extension RouletteView {
  init(
    rouletteController: RouletteController,
    @ViewBuilder content: @escaping ((Roulette.Sector) -> Content)
  ) where Center == EmptyView {
    self.model = rouletteController
    self.content = content
    self.center = nil
  }

  init(
    rouletteController: RouletteController,
    @ViewBuilder center: @escaping (() -> Center)
  ) where Content == EmptyView {
    self.model = rouletteController
    self.content = nil
    self.center = center
  }

  init(
    rouletteController: RouletteController,
    @ViewBuilder content: @escaping ((Roulette.Sector) -> Content),
    @ViewBuilder center: @escaping (() -> Center)
  ) {
    self.model = rouletteController
    self.content = content
    self.center = center
  }
}

@available(iOS 18.0, *)
#Preview {
  @Previewable @StateObject var rouletteController: RouletteController = .init(sectors: [
    .init(index: 0, count: 9, text: "RED", color: .red),
    .init(index: 1, count: 9, text: "BLUE", color: .blue),
    .init(index: 2, count: 9, text: "GREEN", color: .green),
    .init(index: 3, count: 9, text: "YELLOW", color: .yellow),
    .init(index: 4, count: 9, text: "BROWN", color: .brown),
    .init(index: 5, count: 9, text: "PURPLEPURPLEPURPLE", color: .purple),
    .init(index: 6, count: 9, text: "GRAY", color: .gray),
    .init(index: 7, count: 9, text: "PINK", color: .pink),
    .init(index: 8, count: 9, text: "CYAN", color: .cyan),
  ])
  RouletteView(rouletteController: rouletteController, center: {
    switch rouletteController.status {
    case .idle, .complete:
      Button("START") {
        rouletteController.start()
      }
    case .rotating, .stopping:
      Button("STOP") {
        rouletteController.stop()
      }
      .disabled(rouletteController.status == .stopping)
    }
  })
  .padding()
}

@available(iOS 18.0, *)
#Preview {
  @Previewable @StateObject var rouletteController: RouletteController = .init(sectors: [
    .init(index: 0, count: 5, color: .red),
    .init(index: 1, count: 5, color: .blue),
    .init(index: 2, count: 5, color: .green),
    .init(index: 3, count: 5, color: .yellow),
    .init(index: 4, count: 5, color: .gray),
  ])
  RouletteView(rouletteController: rouletteController) { sector in
    Image(systemName: "\(sector.id + 1).square.fill")
      .resizable()
      .scaledToFit()
      .frame(width: 40)
      .rotationEffect(.degrees((sector.start.degrees + rouletteController.roulette.degreePerSector) / 2 + 90 + (rouletteController.roulette.degreePerSector / 2 * Double(sector.id))))
  } center: {
    switch rouletteController.status {
    case .idle, .complete:
      Button("START") {
        rouletteController.start()
      }
    case .rotating, .stopping:
      Button("STOP") {
        rouletteController.stop()
      }
      .disabled(rouletteController.status == .stopping)
    }
  }
  .padding()
}
