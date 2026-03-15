//
//  AccountModel.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 13/03/26.
//

import SwiftData
import SwiftUI
import Foundation

@Model
final class Account {
    var id: UUID
    var name: String
    var initialBalance: Int
    var iconName: String
    var colorHex: String
    
    @Relationship(deleteRule: .cascade, inverse: \Transaction.account)
    var transactions: [Transaction]? = []
    
    @Relationship(inverse: \Transaction.destinationAccount)
    var incomingTransfers: [Transaction]? = []
    
    init(id: UUID = UUID(), name: String, initialBalance: Int, iconName: String, colorHex: String) {
        self.id = id
        self.name = name
        self.initialBalance = initialBalance
        self.iconName = iconName
        self.colorHex = colorHex
    }
    
    @Transient
    var color: Color {
        Color(hex: colorHex) ?? .blue
    }
    
    @Transient
    var currentBalance: Int {
        let completedPrimaryTransactions = transactions?.filter { $0.isPaid }
        let completedIncomingTransfers = incomingTransfers?.filter { $0.isPaid }
        
        // 1. Sum of total income and expense
        let primaryTransactionsTotal = completedPrimaryTransactions?.reduce(0) { total, tx in
            switch tx.type {
            case .income:
                return total + tx.amount
            case .expense, .transfer:
                return total - tx.amount // Transfers = expense in a bank account
            }
        } ?? 0
        
        // 2. Sum of incoming transfers
        let incomingTransfersTotal = completedIncomingTransfers?.reduce(0) { $0 + $1.amount } ?? 0
        
        return initialBalance + primaryTransactionsTotal + incomingTransfersTotal
    }
}
