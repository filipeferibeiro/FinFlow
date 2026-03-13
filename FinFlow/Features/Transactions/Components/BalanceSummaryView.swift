//
//  balanceSummaryView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 12/03/26.
//

import SwiftUI

struct BalanceSummaryView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Total Balance
            VStack(spacing: 4) {
                Text("Saldo Total Atual")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("R$ 5.420,50")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
            }
            
            Divider()
            
            // Incoming and Expenses
            HStack(spacing: 0) {
                SummaryValueView(title: "Entradas", value: "R$ 8.500,00", color: .green, systemImage: "arrow.up.circle.fill")
                
                Divider()
                    .padding(.horizontal, 16)
                
                SummaryValueView(title: "Saídas", value: "R$ 3.079,50", color: .red, systemImage: "arrow.down.circle.fill")
            }
            
            Divider()
            
            // Expected balance
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Saldo Previsto (Fim do Mês)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("R$ 4.120,00")
                        .font(.headline)
                }
                Spacer()
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .foregroundStyle(.accent)
            }
            .padding(.top, 4)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
        )
    }
}

struct SummaryValueView: View {
    let title: String
    let value: String
    let color: Color
    let systemImage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: systemImage)
                    .foregroundStyle(color)
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Text(value)
                .font(.headline)
                .contentTransition(.numericText())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    BalanceSummaryView()
}
