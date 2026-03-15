//
//  TransactionType.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 13/03/26.
//

import Foundation

enum TransactionType: Int, Codable {
    case income = 0
    case expense = 1
    case transfer = 2
}

extension TransactionType: CaseIterable, Identifiable {
    public var id: Self { self }
    
    var title: String {
        switch self {
        case .income: return "Income"
        case .expense: return "Expense"
        case .transfer: return "Transfer"
        }
    }
}
