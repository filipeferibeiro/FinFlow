//
//  HomeHeaderView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 14/03/26.
//

import SwiftUI

struct HomeHeaderView: View {
    var balance: Int
    var isValueVisible: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Bom dia, Filipe")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("TOTAL BALANCE")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(.tertiary)
                        .padding(.top, 8)
                    
                    CurrencyDecorationView(
                        for: balance,
                        isVisible: isValueVisible,
                        fontSize: 36,
                        fontWeight: .black
                    )
                    .foregroundStyle(.primary)
                    
//                    Text(isValueVisible ? balance.asCurrencyString() : "••••••••")
//                        .font(.system(size: 36, weight: .black, design: .rounded))
//                        .lineLimit(1)
//                        .minimumScaleFactor(0.4)
//                        .foregroundStyle(.primary)
//                        .contentTransition(.numericText())
//                        .animation(.snappy, value: isValueVisible)
                }
            }
        }
    }
}

#Preview {
    HomeHeaderView(balance: 23456, isValueVisible: true)
}
