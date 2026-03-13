//
//  CurrencyInputView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 21/02/26.
//

import SwiftUI

struct CurrencyInputView: View {
    @State private var displayValue: String = ""
    @Binding var numericAmount: Int
    
    private let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.locale = Locale(identifier: "pt_BR")
        
        return f
    }()
    
    var body: some View {
        TextField("R$ 0,00", text: $displayValue)
            .keyboardType(.numberPad)
            .font(.system(size: 60, weight: .bold))
            .multilineTextAlignment(.center)
            .textFieldStyle(.plain)
            .onChange(of: displayValue) { oldValue, newValue in
                formatCurrency(input: newValue)
            }
            .onAppear {
                formatCurrency(input: "0")
            }
    }
    
    private func formatCurrency(input: String) {
        let numbersOnly = input.filter { $0.isNumber }
        let cents = Double(numbersOnly) ?? 0.0
        
        numericAmount = Int(numbersOnly) ?? 0
        
        if let formatted = formatter.string(from: NSNumber(value: cents / 100)) {
            if displayValue != formatted {
                displayValue = formatted
            }
        }
    }
}

#Preview {
    CurrencyInputView(numericAmount: .constant(0))
}
