//
//  HomeView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 22/02/26.
//

import SwiftUI

struct HomeView: View {
    let banks: [String] = ["Nubank", "Inter", "Bradesco", "Caixa", "Santander"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // Header
                VStack(spacing: 32) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bom dia, Filipe")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Text("R$ 14.000,00")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 16)
                
                // Banking Accounts
                VStack(alignment: .leading, spacing: 0) {
                    Text("My Accounts")
                        .font(.headline)
                        .textCase(.uppercase)
                        .padding(.bottom, 16)
                    
                    VStack(spacing: 0) {
                        ForEach(banks, id: \.self) { bank in
                            HStack(spacing: 12) {
                                Image(systemName: "building.columns.fill")
                                    .font(.title3)
                                    .foregroundStyle(.purple)
                                    .padding(8)
                                    .background(.purple.opacity(0.2).gradient, in: Circle())
                                
                                Text(bank)
                                    .font(.body)
                                    .fontWeight(.medium)
                                
                                Spacer()
                                
                                Text("R$ 12.000,00")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.blue)
                            }
                            .padding()
                            
                            Divider()
                                .padding(.leading, 60)
                        }
                    }
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 1)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Recent Transactions")
                        .font(.headline)
                        .textCase(.uppercase)
                        .padding(.top, 16)
                    
                    VStack(spacing: 0) {
                        TransactionRowView(title: "Supermercado", date: "Hoje", amount: "- R$ 240,50", icon: "cart.fill", color: .red)
                        Divider().padding(.leading, 60)
                        TransactionRowView(title: "Salário", date: "Ontem", amount: "+ R$ 8.500,00", icon: "arrow.down.circle.fill", color: .green)
                        Divider().padding(.leading, 60)
                        TransactionRowView(title: "Netflix", date: "20 Fev", amount: "- R$ 39,90", icon: "play.tv.fill", color: .red)
                    }
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                
            }
            .padding(.horizontal)
            .navigationTitle("FinFlow")
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("User Account", systemImage: "person.fill") {
                        
                    }
                }
                
                ToolbarItem {
                    Button("Values Visibility", systemImage: "eye.fill") {
                        
                    }
                }
                ToolbarSpacer()
                ToolbarItem {
                    Button("New Transaction", systemImage: "plus") {
                        
                    }
                }
                
            }
        }
    }
}

// MARK: - Componentes de UI (Clean Code)

struct QuickActionButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        Button {
            // Ação futura
        } label: {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(color)
                    // Um pequeno fundo para dar contraste no ícone
                    .frame(width: 44, height: 44)
                    .background(color.opacity(0.15), in: Circle())
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            // A MÁGICA DO LIQUID GLASS AQUI:
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            // Uma borda translúcida sutil para dar o reflexo do vidro
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
        }
    }
}

struct AccountCardView: View {
    let name: String
    let icon: String
    let balance: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(color)
                    .padding(8)
                    .background(color.opacity(0.2), in: Circle())
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Text(balance)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
            }
        }
        .padding()
        .frame(width: 160, height: 140)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

struct TransactionRowView: View {
    let title: String
    let date: String
    let amount: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.white)
                .frame(width: 44, height: 44)
                .background(color.gradient, in: Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                Text(date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(amount)
                .font(.callout)
                .fontWeight(.semibold)
//                .foregroundStyle(color == .red ? .primary : .green)
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
