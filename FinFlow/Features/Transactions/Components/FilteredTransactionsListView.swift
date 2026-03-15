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
    
    private let selectedMonth: Date
    @State private var monthSummary: MonthSummary = MonthSummary(realizedBalance: 0, projectedBalance: 0, realizedIncome: 0, projectedIncome: 0, realizedExpense: 0, projectedExpense: 0)
    
    @State private var transactionToEdit: Transaction?
    
    private var groupedTransactionsByDate: [(Date, [Transaction])] {
        let grouped = Dictionary(grouping: transactions) { transaction in
            Calendar.current.startOfDay(for: transaction.date)
        }
        
        return grouped.sorted { $0.key < $1.key }
    }
    
    init(for month: Date) {
        self.selectedMonth = month
        
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
                    BalanceSummaryCardView(summary: monthSummary)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    ForEach(groupedTransactionsByDate, id: \.0) { date, dateTransactions in
                        Section {
                            ForEach(dateTransactions) { transaction in
                                Button {
                                    transactionToEdit = transaction
                                } label : {
                                    TransactionsListItemView(transaction: transaction)
                                }
                                .buttonStyle(.plain)
                                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                    Button {
                                        withAnimation(.spring) {
                                            transaction.isPaid.toggle()
                                        }
                                        
                                        let generator = UIImpactFeedbackGenerator(style: .medium)
                                        generator.impactOccurred()
                                        
                                        updateSummary()
                                    } label: {
                                        Label(
                                            transaction.isPaid ? "Unpay" : "Pay",
                                            systemImage: transaction.isPaid ? "xmark" : "checkmark"
                                        )
                                        .tint(transaction.isPaid ? .orange : .green)
                                    }
                                }
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
        .onChange(of: transactions) { _, _ in
            updateSummary()
        }
        .sheet(item: $transactionToEdit, onDismiss: updateSummary) { transaction in
            AddTransactionSheetView(transactionToEdit: transaction)
        }
        .task(id: selectedMonth) {
            updateSummary()
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
    
    private func updateSummary() {
        let container = modelContext.container
        let targetMonth = selectedMonth
        
        Task {
            try? await Task.sleep(for: .milliseconds(50))
            
            await MainActor.run {
                do {
                    try modelContext.save()
                } catch {
                    print("Error on force saving: \(error)")
                }
            }
        
            let calculator = SummaryCalculator(modelContainer: container)
            
            do {
                let summary = try await calculator.generateSummary(for: targetMonth)
                
                await MainActor.run {
                    withAnimation(.spring) {
                        self.monthSummary = summary
                    }
                }
            } catch {
                print("Error calculating summary: \(error)")
            }
        }
    }
}

#Preview {
    FilteredTransactionsListView(for: Date())
        .modelContainer(previewContainer)
}
