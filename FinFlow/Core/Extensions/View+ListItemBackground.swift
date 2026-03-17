//
//  View+ListItemBackground.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 16/03/26.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func listItemBackground() -> some View {
        self
            .contentShape(Rectangle())
            .padding()
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(Color.primary.opacity(0.15), lineWidth: 0.5)
            }
    }
}
