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
        // 1. Soma das saídas e entradas normais
        let primaryTransactionsTotal = transactions?.reduce(0) { total, tx in
            switch tx.type {
            case .income:
                return total + tx.amount
            case .expense, .transfer:
                return total - tx.amount // Transferência sai dessa conta
            }
        } ?? 0
        
        // 2. Soma das transferências recebidas
        let incomingTransfersTotal = incomingTransfers?.reduce(0) { total, tx in
            return total + tx.amount
        } ?? 0
        
        return initialBalance + primaryTransactionsTotal + incomingTransfersTotal
    }
}
