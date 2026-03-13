//
//  MonthPillView.swift
//  FinFlow
//
//  Created by Gemini CLI on 06/03/26.
//

import SwiftUI

struct MonthPillView: View {
    let date: Date
    let isSelected: Bool
    let formattedText: String
    
    var body: some View {
        Text(formattedText)
            .font(isSelected ? .headline : .subheadline)
            .textCase(.uppercase)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .foregroundStyle(isSelected ? .white : .secondary)
            .padding(.vertical, 8)
            .padding(.horizontal, isSelected ? 24 : 16)
            .background(
                Group {
                    if isSelected {
                        Capsule()
                            .fill(.orange.gradient)
                            .shadow(color: .orange.opacity(0.3), radius: 5, x: 0, y: 3)
                    } else {
                        Color.clear
                    }
                }
            )
            // Removi o frame fixo para maior flexibilidade no carrossel
            .animation(.snappy, value: isSelected)
    }
}

#Preview {
    HStack {
        MonthPillView(date: Date(), isSelected: true, formattedText: "MARÇO")
        MonthPillView(date: Date(), isSelected: false, formattedText: "FEV")
    }
    .padding()
    .background(Color.black.opacity(0.1))
}
