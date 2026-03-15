//
//  TransactionsListItemView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 20/02/26.
//

import SwiftUI

struct TransactionsListItemView: View {
    let transaction: Transaction
    
    private let color: Color = .orange
    private let icon = "dollarsign"
    private let isIncoming: Bool = false
    
    var transactionTypeIcon: String {
        switch transaction.type {
        case .income:
            return "plus"
        case .expense:
            return "minus"
        case .transfer:
            return "arrow.trianglehead.2.counterclockwise.rotate.90"
        }
    }
    
    var body: some View {
        HStack {
            IconIndicatorView(color: color, icon: icon)
                .overlay(alignment: .bottomTrailing) {
                    BadgeTransactionTypeView(for: transaction.type)
                }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.name)
                    .font(.body)
                    .fontWeight(.medium)
                Text(transaction.account?.name ?? "Unknown Account")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(transaction.amount.asCurrencyString())
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundStyle(isIncoming ? .green : .primary)
                
                Text("Paid")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }
}


#Preview {
    let transaction1: Transaction = Transaction(name: "Netflix", amount: 2190, date: Date(), type: .expense)
    let transaction2: Transaction = Transaction(name: "Netflix", amount: 2190, date: Date(), type: .income)
    let transaction3: Transaction = Transaction(name: "Netflix", amount: 2190, date: Date(), type: .transfer)
    
    VStack {
        TransactionsListItemView(transaction: transaction1)
        TransactionsListItemView(transaction: transaction2)
        TransactionsListItemView(transaction: transaction3)
    }
}
