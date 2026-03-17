//
//  View+ClearListDecoration.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 16/03/26.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func clearListDecoration() -> some View {
        self
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
    }
}
