//
//  TransactionsDashboardView.swift
//  FinFlow
//
//  Created by Gemini CLI on 06/03/26.
//

import SwiftData
import SwiftUI

struct TransactionsView: View {
    @State private var selectedMonth = Date()
    @State private var addNewSubscriptionSheetIsPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            FilteredTransactionsListView(for: selectedMonth)
            .safeAreaInset(edge: .bottom) {
                MonthSelectionView(selectedMonth: $selectedMonth)
                    .padding([.bottom, .horizontal])
            }
            .navigationTitle("Transactions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Filtrar", systemImage: "line.3.horizontal.decrease.circle") {
                        // TO-DO
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button("Adicionar assinatura", systemImage: "plus") {
                        addNewSubscriptionSheetIsPresented.toggle()
                    }
                }
            }
            .sheet(isPresented: $addNewSubscriptionSheetIsPresented) {
                AddSubscriptionSheetView()
            }
        }
    }
}

#Preview {
    TransactionsView()
        .modelContainer(previewContainer)
}
