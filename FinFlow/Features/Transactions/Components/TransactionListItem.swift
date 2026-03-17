//
//  TransactionListItem.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 16/03/26.
//

import SwiftUI

struct TransactionsListItem: View {
    let transaction: Transaction
    
    private let color: Color = .orange
    private let icon = "dollarsign"
    private let isIncoming: Bool = false
    
    private var transactionTypeIcon: String {
        switch transaction.type {
        case .income:
            return "plus"
        case .expense:
            return "minus"
        case .transfer:
            return "arrow.trianglehead.2.counterclockwise.rotate.90"
        }
    }
    
    private var formattedAmount: String {
        let prefix = transaction.type == .expense ? "- " : (transaction.type == .income ? "+ " : "")
        return prefix + transaction.amount.asCurrencyString()
    }
    
    private var amountColor: Color {
        switch transaction.type {
        case .income: return .green
        case .expense: return .primary
        case .transfer: return .blue
        }
    }
    
    private var iconColor: Color {
        switch transaction.type {
        case .income: return .green
        case .expense: return .red
        case .transfer: return .blue
        }
    }
    
    private var iconName: String {
        switch transaction.type {
        case .income: return "arrow.down.left.circle.fill"
        case .expense: return "dollarsign"
        case .transfer: return "arrow.left.arrow.right"
        }
    }
    
    var body: some View {
        HStack {
            IconIndicatorView(color: iconColor, icon: iconName)
                .overlay(alignment: .bottomTrailing) {
                    BadgeTransactionTypeView(for: transaction.type)
                }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.name)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(transaction.isPaid ? .primary : .secondary)
                    .lineLimit(1)
                
                HStack(spacing: 4) {
                    Text(transaction.account?.name ?? "Unknown Account")
                    
                    if transaction.type == .transfer, let destination = transaction.destinationAccount {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 10, weight: .bold))
                        Text(destination.name)
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
            }
            
            Spacer(minLength: 12)
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(formattedAmount)
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundStyle(transaction.isPaid ? amountColor : .secondary)
                    .contentTransition(.numericText())
                
                if !transaction.isPaid {
                    Text("Pending")
                        .font(.caption2)
                        .fontWeight(.medium)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(.orange.opacity(0.15), in: Capsule())
                        .foregroundStyle(.orange)
                }
            }
        }
        .opacity(transaction.isPaid ? 1.0 : 0.6)
        .listItemBackground()
    }
}


#Preview {
    let transaction1: Transaction = Transaction(name: "Netflix", amount: 2190, date: Date(), type: .expense)
    let transaction2: Transaction = Transaction(name: "Netflix", amount: 2190, date: Date(), type: .income, isPaid: false)
    let transaction3: Transaction = Transaction(name: "Netflix", amount: 2190, date: Date(), type: .transfer)
    
    VStack {
        TransactionsListItem(transaction: transaction1)
        TransactionsListItem(transaction: transaction2)
        TransactionsListItem(transaction: transaction3)
    }
}
