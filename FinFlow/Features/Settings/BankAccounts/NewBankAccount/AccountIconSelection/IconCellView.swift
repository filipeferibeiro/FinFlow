//
//  IconCellView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 13/03/26.
//

import SwiftUI

struct IconCellView: View {
    let iconName: String
    let isSelected: Bool
    let themeColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .fill(isSelected ? themeColor : Color(.tertiarySystemFill))
                .frame(width: 64, height: 64)
            
            Image(systemName: iconName)
                .font(.system(size: 24, weight: isSelected ? .bold : .medium))
                .foregroundStyle(isSelected ? .white : .primary)
        }
        .scaleEffect(isSelected ? 1.1 : 1.0)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Ícone \(iconName.replacingOccurrences(of: ".fill", with: ""))")
        .accessibilityAddTraits(isSelected ? [.isSelected, .isButton] : [.isButton])
    }
}

#Preview {
    HStack(spacing: 16) {
        IconCellView(iconName: "house.fill", isSelected: true, themeColor: .blue)
        IconCellView(iconName: "building.columns.fill", isSelected: false, themeColor: .blue)
    }
}
