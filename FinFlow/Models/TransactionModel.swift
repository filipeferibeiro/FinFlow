//
//  TransactionModel.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 13/03/26.
//

import SwiftData
import Foundation

@Model
final class Transaction {
    var id: UUID
    var name: String
    var amount: Int
    var date: Date
    var type: TransactionType
    
    var account: Account?
    
    // If is a transfer transaction type
    var destinationAccount: Account?
    
    init(id: UUID = UUID(), name: String, amount: Int, date: Date, type: TransactionType) {
        self.id = id
        self.name = name
        self.amount = amount
        self.date = date
        self.type = type
    }
}
