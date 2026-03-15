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
        
        // 1. Soma das saídas e entradas normais
        let primaryTransactionsTotal = completedPrimaryTransactions?.reduce(0) { total, tx in
            switch tx.type {
            case .income:
                return total + tx.amount
            case .expense, .transfer:
                return total - tx.amount // Transferência sai dessa conta
            }
        } ?? 0
        
        // 2. Soma das transferências recebidas
        let incomingTransfersTotal = completedIncomingTransfers?.reduce(0) { total, tx in
            return total + tx.amount
        } ?? 0
        
        return initialBalance + primaryTransactionsTotal + incomingTransfersTotal
    }
    
    func currentCompletedIncomesBalance(for targetMonth: Date) -> Int {
        guard let transactions = self.transactions else { return 0 }
        
        let calendar = Calendar.current
        
        let validIncomes = transactions.filter { transaction in
            let isIncome = transaction.type == .income
            
            let isPaid = transaction.isPaid
            
            let isSameMonthAndYear = calendar.isDate(transaction.date, equalTo: targetMonth, toGranularity: .month)
            
            return isIncome && isPaid && isSameMonthAndYear
        }
        
        return validIncomes.reduce(0) { $0 + $1.amount }
    }
    
    func currentCompletedExpensesBalance(for targetMonth: Date) -> Int {
        guard let transactions = self.transactions else { return 0 }
        
        let calendar = Calendar.current
        
        let validExpenses = transactions.filter { transaction in
            let isExpense = transaction.type == .expense
            
            let isPaid = transaction.isPaid
            
            let isSameMonthAndYear = calendar.isDate(transaction.date, equalTo: targetMonth, toGranularity: .month)
            
            return isExpense && isPaid && isSameMonthAndYear
        }
        
        return validExpenses.reduce(0) { $0 + $1.amount }
    }
    
    func expectedTransactionsBalance(for targetMonth: Date) -> Int {
        guard let transactions = self.transactions else { return 0 }
        
        let calendar = Calendar.current
        
        let validTransactions = transactions.filter { transaction in
            let isIncomeOrExpense = transaction.type == .income || transaction.type == .expense
            
            let isSameMonthAndYear = calendar.isDate(transaction.date, equalTo: targetMonth, toGranularity: .month)
            
            return isIncomeOrExpense && isSameMonthAndYear
        }
        
        return validTransactions.reduce(0) { $0 + $1.amount }
    }
}
