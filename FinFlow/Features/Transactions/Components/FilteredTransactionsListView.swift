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
    @Environment(\.locale) private var locale
    
    @Query private var transactions: [Transaction]
    @Query private var bankAccounts: [Account]
    
    private var totalBalance: Int {
        return bankAccounts.reduce(0, { $0 + $1.currentBalance })
    }
    
    private var groupedTransactionsByDate: [(Date, [Transaction])] {
        let grouped = Dictionary(grouping: transactions) { transaction in
            Calendar.current.startOfDay(for: transaction.date)
        }
        
        return grouped.sorted { $0.key < $1.key }
    }
    
    init(for month: Date) {
        if let interval = Calendar.current.dateInterval(of: .month, for: month) {
            let filter = #Predicate<Transaction> { transaction in
                transaction.date >= interval.start && transaction.date < interval.end
            }
            
            _transactions = Query(filter: filter, sort: \.date, order: .forward)
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            if transactions.isEmpty {
                ContentUnavailableView("Nenhuma transação", systemImage: "tray.fill", description: Text("Você não tem gastos neste mês."))
            } else {
                List {
                    BalanceSummaryView(totalBalance: totalBalance)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    ForEach(groupedTransactionsByDate, id: \.0) { date, dateTransactions in
                        Section {
                            ForEach(dateTransactions) { transaction in
                                TransactionsListItemView(transaction: transaction)
                            }
                            .onDelete { offsets in
                                deleteTransactions(at: offsets, in: dateTransactions)
                            }
                        } header: {
                            Text(headerTitle(for: date))
                                .font(.headline)
                                .foregroundStyle(.primary)
                                .textCase(nil)
                                .padding(.leading, 4)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    
    private func headerTitle(for date: Date) -> String {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) { return "Today" }
        if calendar.isDateInYesterday(date) { return "Yesterday" }
        if calendar.isDateInTomorrow(date) { return "Tomorrow" }
        
        return date.formatted(
            .dateTime
            .day()
            .month(.wide)
            .locale(locale)
        )
    }
    
    private func deleteTransactions(at offsets: IndexSet, in dateTransactions: [Transaction]) {
        for index in offsets {
            let transactionToDelete = dateTransactions[index]
            
            withAnimation {
                modelContext.delete(transactionToDelete)
            }
        }
    }
}

#Preview {
    FilteredTransactionsListView(for: Date())
        .modelContainer(previewContainer)
}
