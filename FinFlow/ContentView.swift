//
//  ContentView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 19/02/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var addNewSubscriptionSheetIsPresented: Bool = false
    @Query(sort: \Subscription.paymentDate) private var subscriptions: [Subscription]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(subscriptions) { subscription in
                    SubscriptionsListItemView(subscription: subscription)
                }
                .onDelete(perform: deleteSubscription)
            }
            .navigationTitle("FinFlow")
            .toolbar {
                ToolbarSpacer(.flexible, placement: .bottomBar)
                ToolbarItem(placement: .bottomBar) {
                    Button(role: .confirm) {
                        addNewSubscriptionSheetIsPresented.toggle()
                    } label: {
                        Label("Add subscription", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $addNewSubscriptionSheetIsPresented) {
                AddSubscriptionSheetView()
            }
        }
    }
    
    private func deleteSubscription(at offsets: IndexSet) {
        for index in offsets {
            let subscriptionToDelete = subscriptions[index]
            modelContext.delete(subscriptionToDelete)
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
