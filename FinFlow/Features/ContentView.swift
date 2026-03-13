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
                Text("To-Do")
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
        let container = try ModelContainer(for: Subscription.self, configurations: config)
        
        let mockData = Subscription(name: "Spotify", price: 2190, paymentDate: Date())
        container.mainContext.insert(mockData)
        
        return container
    } catch {
        fatalError("Fail to create container preview: \(error)")
    }
}()
