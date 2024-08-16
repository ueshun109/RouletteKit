//
//  Math+.swift
//  RouletteKit
//
//  Created by shun uematsu on 2024/08/09.
//

import Foundation

func round(for decimal: Double, digit: Double = 2) -> Double {
  (decimal * pow(10, digit - 1)).rounded() / pow(10, digit - 1)
}
