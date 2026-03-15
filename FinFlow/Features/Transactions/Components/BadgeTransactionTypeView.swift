//
//  BadgeTransactionTypeView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 14/03/26.
//

import SwiftUI

struct BadgeTransactionTypeView: View {
    var type: TransactionType
    
    private var badgeIconName: String {
        switch type {
        case .income:
            return "plus"
        case .expense:
            return "minus"
        case .transfer:
            return "arrow.trianglehead.2.counterclockwise.rotate.90"
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
                .fill(Color(uiColor: .systemGroupedBackground))
                .frame(width: 20, height: 20)
            
            Circle()
                .fill(badgeColor.opacity(0.6))
                .frame(width: 16, height: 16)
            
            Image(systemName: badgeIconName)
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(.white)
        }
        .offset(x: 2, y: 2)
    }
}

#Preview {
    BadgeTransactionTypeView(for: .expense)
}
