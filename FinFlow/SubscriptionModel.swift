//
//  SubscriptionModel.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 21/02/26.
//

import Foundation
import SwiftData

@Model
class Subscription {
    var id: UUID
    var name: String
    var price: Int
    var paymentDate: Date
    
    init(id: UUID = UUID(), name: String, price: Int, paymentDate: Date) {
        self.id = id
        self.name = name
        self.price = price
        self.paymentDate = paymentDate
    }
}
