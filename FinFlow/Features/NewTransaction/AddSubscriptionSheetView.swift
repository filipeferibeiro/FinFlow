//
//  AddSubscriptionSheetView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 20/02/26.
//

import SwiftUI
import SwiftData

struct AddSubscriptionSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @FocusState private var isValueFocused: Bool
    
    @State private var name: String = ""
    @State private var value: Int = 0
    @State private var date: Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    CurrencyInputView(numericAmount: $value)
                        .focused($isValueFocused)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                    
                Section {
                    TextField("Ex: Netflix, Spotify, iCloud", text: $name)
                } header: {
                    Text("Name")
                }
                
                Section {
                    DatePicker("Payment day", selection: $date, displayedComponents: .date)
                }
            }
            .navigationTitle("New Subscription")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss", systemImage: "xmark") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    let isFormValid = !name.trimmingCharacters(in: .whitespaces).isEmpty && value > 0
                    
                    Button("Add", systemImage: "checkmark") {
                        let subscriptionToAdd = Subscription(id: UUID(), name: name, price: value, paymentDate: date)
                        
                        modelContext.insert(subscriptionToAdd)
                        dismiss()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
        .onAppear {
            isValueFocused = true
        }
    }
}

#Preview {
    AddSubscriptionSheetView()
}
