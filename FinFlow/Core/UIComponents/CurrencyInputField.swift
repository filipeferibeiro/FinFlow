//
//  CurrencyInputField.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 13/03/26.
//

import SwiftUI

struct CurrencyInputField: View {
    @Binding var value: Int
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            TextField("", text: rawStringBinding)
                .keyboardType(.numberPad)
                .focused($isFocused)
                .opacity(0.01)
            
            Text(value.asCurrencyString())
                .font(.system(size: 60, weight: .bold))
                .foregroundStyle(value > 0 ? .primary : .secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.4)
                .contentShape(Rectangle())
                .onTapGesture {
                    isFocused = true
                }
        }
    }

    private var rawStringBinding: Binding<String> {
        Binding<String>(
            get: {
                value == 0 ? "" : String(value)
            },
            set: { newValue in
                let maxDigits = String(newValue.prefix(12))
                let numbersOnly = maxDigits.filter(\.isWholeNumber)
                value = Int(numbersOnly) ?? 0
            }
        )
    }
}

#Preview {
    @Previewable @State var value = 0
    
    CurrencyInputField(value: $value)
}
