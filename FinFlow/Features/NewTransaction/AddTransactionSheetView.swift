//
//  AddTransactionSheetView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 20/02/26.
//

import SwiftUI
import SwiftData

struct AddTransactionSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Account.name) private var accounts: [Account]
    
    @FocusState private var isValueFocused: Bool
    
    let transactionToEdit: Transaction?
    
    @State private var type: TransactionType
    @State private var name: String
    @State private var value: Int
    @State private var date: Date
    @State private var isPaid: Bool
    @State private var selectedAccount: Account?
    @State private var destinationAccount: Account?
    
    init(transactionToEdit: Transaction? = nil) {
        self.transactionToEdit = transactionToEdit
        
        if let transaction = transactionToEdit {
            _type = State(initialValue: transaction.type)
            _name = State(initialValue: transaction.name)
            _value = State(initialValue: transaction.amount)
            _date = State(initialValue: transaction.date)
            _isPaid = State(initialValue: transaction.isPaid)
            _selectedAccount = State(initialValue: transaction.account)
            _destinationAccount = State(initialValue: transaction.destinationAccount)
        } else {
            _type = State(initialValue: .expense)
            _name = State(initialValue: "")
            _value = State(initialValue: 0)
            _date = State(initialValue: Date())
            _isPaid = State(initialValue: true)
            _selectedAccount = State(initialValue: nil)
            _destinationAccount = State(initialValue: nil)
        }
    }
    
    private var isFormValid: Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return false }
        guard value > 0 else { return false }
        guard selectedAccount != nil else { return false }
        
        if type == .transfer {
            guard destinationAccount != nil else { return false }
            guard selectedAccount != destinationAccount else { return false }
        }
        
        return true
    }
    
    private var valueColor: Color {
        if value == 0 { return .secondary }
        switch type {
        case .income: return .green
        case .expense: return .red
        case .transfer: return .blue
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    CurrencyInputField(value: $value)
                        .focused($isValueFocused)
                        .foregroundStyle(valueColor)
                    
                    Picker("Transaction Type", selection: $type) {
                        ForEach(TransactionType.allCases) { type in
                            Text(type.title).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                    
                Section("Details") {
                    TextField("Ex: Netflix, Spotify, iCloud", text: $name)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                    
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .onChange(of: date) { _, newDate in
                            if Calendar.current.startOfDay(for: newDate) > Calendar.current.startOfDay(for: Date()) {
                                withAnimation { isPaid = false }
                            } else {
                                withAnimation { isPaid = true }
                            }
                        }
                    
                    Toggle("Is paid?", isOn: $isPaid)
                        .tint(.accent)
                }
                .listRowBackground(Color.primary.opacity(0.05))
                
                Section("Accounts") {
                    if accounts.isEmpty {
                        Text("First create an account to add transactions.")
                            .foregroundStyle(.red)
                            .font(.caption)
                    } else {
                        Picker(type == .income ? "Money Destination" : "Origin Account", selection: $selectedAccount) {
                            Text("Select...").tag(Account?.none)
                            ForEach(accounts) { account in
                                Text(account.name).tag(Account?.some(account))
                            }
                        }
                        
                        if type == .transfer {
                            Picker("Destination Account", selection: $destinationAccount) {
                                Text("Select...").tag(Account?.none)
                                ForEach(accounts) { account in
                                    Text(account.name).tag(Account?.some(account))
                                }
                            }
                            .foregroundStyle(selectedAccount == destinationAccount && destinationAccount != nil ? .red : .primary)
                        }
                    }
                }
                .listRowBackground(Color.primary.opacity(0.05))
            }
            .navigationTitle(transactionToEdit == nil ? "New Transaction" : "Edit Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .scrollDismissesKeyboard(.interactively)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss", systemImage: "xmark") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", systemImage: "checkmark") {
                        saveTransaction()
                    }
                    .disabled(!isFormValid || accounts.isEmpty)
                }
            }
        }
        .onAppear {
            isValueFocused = true
            
            if selectedAccount == nil, let firstAccount = accounts.first {
                selectedAccount = firstAccount
            }
        }
        .onChange(of: type) { _, newValue in
            if newValue != .transfer {
                destinationAccount = nil
            }
        }
    }
    
    private func saveTransaction() {
        if let transaction = transactionToEdit {
            transaction.name = name
            transaction.amount = value
            transaction.date = date
            transaction.type = type
            transaction.isPaid = isPaid
            transaction.account = selectedAccount
            transaction.destinationAccount = type == .transfer ? destinationAccount : nil
        } else {
            let newTransaction = Transaction(
                id: UUID(),
                name: name,
                amount: value,
                date: date,
                type: type,
                isPaid: isPaid
            )
            
            newTransaction.account = selectedAccount
            if type == .transfer {
                newTransaction.destinationAccount = destinationAccount
            }
            
            withAnimation {
                modelContext.insert(newTransaction)
            }
        }
        
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        dismiss()
    }
}

#Preview {
    AddTransactionSheetView()
        .modelContainer(previewContainer)
}
