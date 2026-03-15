//
//  NewBankAccountView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 13/03/26.
//

import SwiftData
import SwiftUI

struct NewBankAccountView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var isValueFocused: Bool
    
    @State private var name: String = ""
    @State private var initialBalance: Int = 0
    @State private var selectedIcon: String = "building.columns.fill"
    @State private var selectedColor: Color = .accent
    
    private var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section() {
                    CurrencyInputField(value: $initialBalance)
                        .focused($isValueFocused)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                
                Section("Account name") {
                    TextField("ex: NuBank, Inter", text: $name)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                }
                
                Section("Appearance") {
                    ColorPicker("Account Color", selection: $selectedColor, supportsOpacity: false)
                    
                    NavigationLink {
                        AccountIconsListView(selectedIcon: $selectedIcon, themeColor: selectedColor)
                    } label: {
                        HStack {
                            Text("Icon")
                            Spacer()
                            Image(systemName: selectedIcon)
                                .font(.title3)
                                .foregroundStyle(selectedColor)
                                .frame(width: 32, height: 32)
                                .background(selectedColor.opacity(0.15), in: .circle)
                        }
                    }
                }
            }
            .navigationTitle("New Account")
            .navigationBarTitleDisplayMode(.inline)
            .scrollDismissesKeyboard(.interactively)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", systemImage: "checkmark") {
                        saveAccount()
                    }
                    .disabled(!isFormValid)
                }
            }
            .onAppear {
                isValueFocused = true
            }
        }
    }
    
    private func saveAccount() {
        let hexColor = selectedColor.toHex()
        
        let newAccount = Account(
            name: name,
            initialBalance: initialBalance,
            iconName: selectedIcon,
            colorHex: hexColor
        )
        
        withAnimation {
            modelContext.insert(newAccount)
        }
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        dismiss()
    }
}

#Preview {
    NavigationStack {
        NewBankAccountView()
    }
}
