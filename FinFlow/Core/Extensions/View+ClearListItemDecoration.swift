//
//  View+ClearListItemDecoration.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 16/03/26.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func clearListItemDecoration() -> some View {
        self
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
    }
}
