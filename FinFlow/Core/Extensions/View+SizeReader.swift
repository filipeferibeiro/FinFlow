//
//  View+SizeReader.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 04/03/26.
//

import Foundation
import SwiftUI

// PreferenceKey to read dynamic height of the header
private struct HeaderHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

extension View {
    func readHeight(into binding: Binding<CGFloat>) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: HeaderHeightKey.self, value: proxy.size.height)
            }
        )
        .onPreferenceChange(HeaderHeightKey.self) { newValue in
            // Animate updates to keep list contentMargins in sync
            withAnimation(.easeInOut(duration: 0.25)) {
                binding.wrappedValue = newValue
            }
        }
    }
}
