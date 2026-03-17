//
//  View+BackgroundModifier.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 16/03/26.
//

import Foundation
import SwiftUI

struct BackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            BackgroundView()
            
            content
        }
    }
}

extension View {
    func withBackground() -> some View {
        self.modifier(BackgroundModifier())
    }
}
