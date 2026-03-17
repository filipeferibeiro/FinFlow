//
//  BankAccountsView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 13/03/26.
//

import SwiftData
import SwiftUI

struct BankAccountsView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \Account.name) private var accounts: [Account]
    @State private var isNewAccountSheetPresent: Bool = false
    
    var body: some View {
        List {
            ForEach(accounts) { account in
                BankAccountItemListView(account: account)
                    .clearListItemDecoration()
            }
            .onDelete(perform: deleteBankAccount)
        }
        .clearListDecoration()
        .navigationTitle("Bank Accounts")
        .toolbar {
            ToolbarItem {
                Button("New bank account", systemImage: "plus") {
                    isNewAccountSheetPresent = true
                }
            }
        }
        .sheet(isPresented: $isNewAccountSheetPresent) {
            NewBankAccountView()
                .presentationBackground {
                    BackgroundView()
                        .overlay(.regularMaterial)
                }
        }
        .withBackground()
    }
    
    private func deleteBankAccount(at offsets: IndexSet) {
        for index in offsets {
            let transactionToDelete = accounts[index]
            modelContext.delete(transactionToDelete)
        }
    }
}

#Preview {
    NavigationStack {
        BankAccountsView()
    }
}
