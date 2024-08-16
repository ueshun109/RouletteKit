//
//  Angle+Tests.swift
//  RouletteKit
//
//  Created by shun uematsu on 2024/08/04.
//

@testable import RouletteKit
import Testing
import SwiftUICore

struct AngleExtensionTests {
  struct DegreesInCircleTests {
    @Test func angleIs0() {
      let angle = Angle(degrees: 0)
      #expect(angle.degreesInCircle == 0)
    }

    @Test func angleIs72() async throws {
      let angle = Angle(degrees: 72)
      #expect(angle.degreesInCircle == 72)
    }

    @Test func angleIsMinus2() {
      let angle = Angle(degrees: -2)
      #expect(angle.degreesInCircle == 358)
    }

    @Test func angleIsMinus240() async throws {
      let angle = Angle(degrees: -240)
      #expect(angle.degreesInCircle == 120)
    }

    @Test func angleIsMinus1004() async throws {
      let angle = Angle(degrees: -1004)
      #expect(angle.degreesInCircle == 76)
    }

    @Test func angleIs360() {
      let angle = Angle(degrees: 360)
      #expect(angle.degreesInCircle == 360)
    }

    @Test func angleIs720() {
      let angle = Angle(degrees: 720)
      #expect(angle.degreesInCircle == 360)
    }
  }
}
