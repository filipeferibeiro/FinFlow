//
//  HomeView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 22/02/26.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Query(sort: \Account.name) var bankAccounts: [Account]
    @AppStorage("isValuesVisible") private var isValuesVisible: Bool = true
    
    @State private var addNewTransactionSheetIsPresented: Bool = false
    
    var currentBalance: Int {
        let balance: Int = bankAccounts.reduce(0) { $0 + $1.currentBalance }
        
        return balance
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if bankAccounts.isEmpty {
                    ContentUnavailableView(
                        "Nenhuma Conta",
                        systemImage: "building.columns",
                        description: Text("Adicione sua primeira conta para começar a gerenciar seu fluxo financeiro.")
                    )
                } else {
                    List {
                        HomeHeaderView(balance: currentBalance, isValueVisible: isValuesVisible)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        
                        Section("Bank Accounts") {
                            ForEach(bankAccounts) { account in
                                BankAccountItemListView(account: account, isValueVisible: isValuesVisible)
                            }
                        }
                        .textCase(nil)
                    }
                    .navigationTitle("FinFlow")
                    .navigationBarTitleDisplayMode(.inline)
                    .listStyle(.insetGrouped)
                    .scrollIndicators(.hidden)
                    .toolbar {
                        ToolbarItemGroup(placement: .topBarTrailing) {
                            Button("Values Visibility", systemImage: isValuesVisible ? "eye.slash.fill" : "eye.fill") {
                                withAnimation {
                                    isValuesVisible.toggle()
                                }
                            }
                            
                            Button("New Transaction", systemImage: "plus") {
                                addNewTransactionSheetIsPresented.toggle()
                            }
                        }
                    }
                    .sheet(isPresented: $addNewTransactionSheetIsPresented) {
                        AddTransactionSheetView()
                    }
                }
            }
        }
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
        }
        .padding()
    }
}

#Preview {
    HomeView()
        .modelContainer(previewContainer)
}
