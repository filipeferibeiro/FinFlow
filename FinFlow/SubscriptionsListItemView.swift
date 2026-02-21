//
//  SubscriptionsListItemView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 20/02/26.
//

import SwiftUI

struct SubscriptionsListItemView: View {
    let subscription: Subscription
    
    var body: some View {
        HStack {
            Image(systemName: "dollarsign")
                .padding()
                .background(Color.blue.gradient)
                .foregroundStyle(Color.white)
                .clipShape(
                    Circle()
                )
            VStack(alignment: .leading) {
                Text(subscription.name)
                    .font(.headline)
                Text(subscription.paymentDate.formatted(date: .numeric, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(Double(subscription.price) / 100, format: .currency(code: "BRL"))
        }
    }
}

#Preview {
    let subscription: Subscription = Subscription(id: UUID(), name: "Netflix", price: 2190, paymentDate: Date())
    
    SubscriptionsListItemView(subscription: subscription)
}
