//
//  fadeOnEdges.swift
//  winston
//
//  Created by Igor Marcossi on 19/12/23.
//

import SwiftUI
import SmoothGradient

fileprivate struct NiceGradient: View {
  let axis: Axis
  let length: Double
  let last: Bool
  var body: some View {
    SmoothLinearGradient(from: .black, to: .black.opacity(0), startPoint: axis == .vertical ? last ? .top : .bottom : last ? .leading : .trailing, endPoint: axis == .vertical ? last ? .bottom : .top : last ? .trailing : .leading, curve: .easeInOut)
      .frame(width: axis == .vertical ? nil : length, height: axis == .vertical ? length : nil)
  }
}

extension View {
  func fadeOnEdges(_ axis: Axis, disableSide: Edge? = nil, fadeLength: Double = 20) -> some View {
    self
      .mask(
        HStack(spacing: 0) {
          if disableSide != .leading {
            NiceGradient(axis: axis, length: fadeLength, last: false)
          }
          Color.black.frame(maxWidth: .infinity, maxHeight: .infinity)
          if disableSide != .trailing {
            NiceGradient(axis: axis, length: fadeLength, last: true)
          }
        }
      )
  }
}
