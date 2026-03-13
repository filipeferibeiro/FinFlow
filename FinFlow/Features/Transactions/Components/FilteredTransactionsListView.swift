//
//  Transactions2View.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 01/03/26.
//

import SwiftUI
import SwiftData

struct FilteredTransactionsListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var transactions: [Subscription]
    
    @State private var showMoreDetails: Bool = false
    @State private var headerContainerHeight: CGFloat = 134
    
    init(for month: Date) {
        if let interval = Calendar.current.dateInterval(of: .month, for: month) {
            let filter = #Predicate<Subscription> { transaction in
                transaction.paymentDate >= interval.start && transaction.paymentDate < interval.end
            }
            
            _transactions = Query(filter: filter, sort: \.paymentDate, order: .reverse)
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            if transactions.isEmpty {
                ContentUnavailableView("Nenhuma transação", systemImage: "tray.fill", description: Text("Você não tem gastos neste mês."))
            } else {
                List {
                    BalanceSummaryView()
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    Section {
                        ForEach(transactions) { transaction in
                            TransactionsListItemView(subscription: transaction)
                        }
                        .onDelete(perform: deleteTransaction)
                    } header: {
                        Text("Transações recentes")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding(.leading, 4)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    
    private func deleteTransaction(at offsets: IndexSet) {
        for index in offsets {
            let transactionToDelete = transactions[index]
            modelContext.delete(transactionToDelete)
        }
    }
}

#Preview {
    FilteredTransactionsListView(for: Date())
        .modelContainer(previewContainer)
}
