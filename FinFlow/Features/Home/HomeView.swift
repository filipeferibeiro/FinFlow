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
                            .clearListItemDecoration()
                        
                        Section("Bank Accounts") {
                            ForEach(bankAccounts) { account in
                                BankAccountItemListView(account: account, isValueVisible: isValuesVisible)
                            }
                            .clearListItemDecoration()
                        }
                        .textCase(nil)
                    }
                    .clearListDecoration()
                }
            }
            .navigationTitle("FinFlow")
            .navigationBarTitleDisplayMode(.inline)
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
                    .presentationBackground {
                        BackgroundView()
                            .overlay(.regularMaterial)
                    }
            }
            .withBackground()
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(previewContainer)
}
