//
//  BadgeTransactionTypeView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 14/03/26.
//

import SwiftUI

struct BadgeTransactionTypeView: View {
    var type: TransactionType
    var cutoutColor: Color = Color(uiColor: .systemGroupedBackground)
    
    private var badgeIconName: String {
        switch type {
        case .income:
            return "plus"
        case .expense:
            return "minus"
        case .transfer:
            return "arrow.left.arrow.right"
        }
    }
    
    private var badgeColor: Color {
        switch type {
        case .income:
            return .green
        case .expense:
            return .red
        case .transfer:
            return .blue
        }
    }
    
    init(for type: TransactionType) {
        self.type = type
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(cutoutColor)
                .frame(width: 20, height: 20)
            
            Circle()
                .fill(badgeColor)
                .frame(width: 16, height: 16)
            
            Image(systemName: badgeIconName)
                .font(.system(size: 9, weight: .black))
                .foregroundStyle(.white)
        }
        .offset(x: 2, y: 2)
    }
}

#Preview {
    BadgeTransactionTypeView(for: .expense)
}
