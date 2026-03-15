//
//  BalanceSummaryCardView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 15/03/26.
//

import SwiftUI

struct BalanceSummaryCardView: View {
    let summary: MonthSummary
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 8) {
                Text("Actual Balance")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                
                // Actual Balance
                Text(summary.realizedBalance.asCurrencyString())
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                
                // Projected Balance
                HStack(spacing: 4) {
                    Image(systemName: "arrow.forward.circle.fill")
                    Text("Projection: \(summary.projectedBalance.asCurrencyString())")
                }
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(summary.projectedBalance >= 0 ? .blue : .red)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color(.tertiarySystemFill), in: Capsule())
            }
            
            Divider()
            
            HStack(spacing: 0) {
                // Incoming
                FlowMetricView(
                    title: "Incomes",
                    icon: "arrow.down.left.circle.fill",
                    color: .green,
                    realized: summary.realizedIncome,
                    projected: summary.projectedIncome
                )
                
                Divider()
                    .frame(height: 40)
                    .padding(.horizontal, 16)
                
                // Expenses
                FlowMetricView(
                    title: "Expenses",
                    icon: "arrow.up.right.circle.fill",
                    color: .red,
                    realized: summary.realizedExpense,
                    projected: summary.projectedExpense
                )
            }
        }
        .padding(20)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

struct FlowMetricView: View {
    let title: String
    let icon: String
    let color: Color
    let realized: Int
    let projected: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .foregroundStyle(color)
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            // Actual value
            Text(realized.asCurrencyString())
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            
            // Projected value
            Text("of \(projected.asCurrencyString())")
                .font(.caption2)
                .foregroundStyle(.tertiary)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    BalanceSummaryCardView(summary: MonthSummary(realizedBalance: 8000, projectedBalance: 8000, realizedIncome: 80000, projectedIncome: 8000, realizedExpense: 8000, projectedExpense: 8000))
}
