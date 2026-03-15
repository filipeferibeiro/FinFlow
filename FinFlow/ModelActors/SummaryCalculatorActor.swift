//
//  SummaryCalculatorActor.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 15/03/26.
//

import Foundation
import SwiftData

@ModelActor
actor SummaryCalculator {
    func generateSummary(for targetMonth: Date) throws -> MonthSummary {
        let calendar = Calendar.current
        
        // Get all Bank Accounts
        let accounts = try modelContext.fetch(FetchDescriptor<Account>())
        let initialBalances: Int = accounts.reduce(0) { $0 + $1.initialBalance }
        
        // Get end of the month reference
        guard let endOfMonth = calendar.dateInterval(of: .month, for: targetMonth)?.end else {
            return MonthSummary(realizedBalance: 0, projectedBalance: 0, realizedIncome: 0, projectedIncome: 0, realizedExpense: 0, projectedExpense: 0)
        }
        
        // Get all transactions until the end of the target month
        let descriptor = FetchDescriptor<Transaction>(
            predicate: #Predicate { $0.date < endOfMonth }
        )
        let transactions = try modelContext.fetch(descriptor)
        
        // Initialize variables
        var realizedBalance: Int = initialBalances
        var projectedBalance: Int = initialBalances
        
        var realizedIncome: Int = 0
        var realizedExpense: Int = 0
        var projectedIncome: Int = 0
        var projectedExpense: Int = 0
        
        for transaction in transactions {
            let isBeforeEndOfMonth = transaction.date < endOfMonth
            let isSameMonth = calendar.isDate(transaction.date, equalTo: targetMonth, toGranularity: .month)
            
            if transaction.type == .transfer { continue }
            
            // Logic for balance
            if isBeforeEndOfMonth {
                let amount = transaction.type == .income ? transaction.amount : -transaction.amount
                
                projectedBalance += amount
                
                if transaction.isPaid {
                    realizedBalance += amount
                }
            }
            
            // Logic for Income and Expense
            if isSameMonth {
                if transaction.type == .income {
                    projectedIncome += transaction.amount
                    if transaction.isPaid { realizedIncome += transaction.amount }
                }
                
                if transaction.type == .expense {
                    projectedExpense += transaction.amount
                    if transaction.isPaid { realizedExpense += transaction.amount }
                }
            }
        }
        
        return MonthSummary(
            realizedBalance: realizedBalance, projectedBalance: projectedBalance,
            realizedIncome: realizedIncome, projectedIncome: projectedIncome,
            realizedExpense: realizedExpense, projectedExpense: projectedExpense
        )
    }
}
