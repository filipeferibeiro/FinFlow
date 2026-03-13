//
//  View+GlassEffect.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 12/03/26.
//

import SwiftUI
import Foundation

extension View {
    @ViewBuilder
    func glassEffectWithFallback(in shape: some Shape = .rect, interactive: Bool = false) -> some View {
        if #available(iOS 26, *) {
            self.glassEffect(.regular.interactive(interactive), in: shape)
        } else {
            self.background(.ultraThinMaterial, in: shape)
        }
    }
}
