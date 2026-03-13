//
//  TransactionsListItemView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 20/02/26.
//

import SwiftUI

struct TransactionsListItemView: View {
    let subscription: Subscription
    
    private let color: Color = .orange
    private let icon = "dollarsign"
    private let isIncoming: Bool = false
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 44, height: 44)
                Image(systemName: icon)
                    .foregroundStyle(color)
                    .font(.system(size: 18, weight: .semibold))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(subscription.name)
                    .font(.body)
                    .fontWeight(.medium)
                Text("Bank")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(Double(subscription.price) / 100, format: .currency(code: "BRL"))
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundStyle(isIncoming ? .green : .primary)
                Text(subscription.paymentDate.formatted(date: .numeric, time: .omitted))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }
}


#Preview {
    let subscription: Subscription = Subscription(id: UUID(), name: "Netflix", price: 2190, paymentDate: Date())
    
    TransactionsListItemView(subscription: subscription)
}
