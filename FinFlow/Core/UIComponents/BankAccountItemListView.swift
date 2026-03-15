//
//  BankAccountItemListView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 14/03/26.
//

import SwiftUI

struct BankAccountItemListView: View {
    let account: Account
    var isValueVisible: Bool = true
    
    var body: some View {
        HStack (spacing: 8) {
            IconIndicatorView(color: Color(hex: account.colorHex) ?? .accent, icon: account.iconName)
            
            Text(account.name)
                .font(.body)
                .fontWeight(.medium)
            
            Spacer()
            
            Text(isValueVisible ? account.currentBalance.asCurrencyString() : "••••••••")
                .font(.body)
                .fontWeight(.bold)
                .contentTransition(.numericText())
                .animation(.snappy, value: isValueVisible)
        }
    }
}

#Preview {
    BankAccountItemListView(account: Account(name: "NuConta", initialBalance: 2345500, iconName: "creditcard", colorHex: "#FFAA00"))
}
