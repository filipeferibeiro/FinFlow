//
//  ContentView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 19/02/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            Tab("Transactions", systemImage: "arrow.left.arrow.right") {
                TransactionsView()
            }
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}

@MainActor
let previewContainer: ModelContainer = {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Subscription.self, Account.self, Transaction.self, configurations: config)
        
        let mockBankAccount = Account(name: "NuBank", initialBalance: 26754, iconName: "creditcard", colorHex: "#2196F3")
        let mockSubscription = Subscription(name: "Spotify", price: 2190, paymentDate: Date())
        let mockTransaction = Transaction(name: "Spotify", amount: 2190, date: Date(), type: .expense)
        
        mockTransaction.account = mockBankAccount
        
        container.mainContext.insert(mockBankAccount)
        container.mainContext.insert(mockSubscription)
        container.mainContext.insert(mockTransaction)
        
        return container
    } catch {
        fatalError("Fail to create container preview: \(error)")
    }
}()
