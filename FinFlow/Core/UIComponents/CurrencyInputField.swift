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
    
    @State private var bounceScale: CGFloat = 1.0
    
    var body: some View {
        ZStack(alignment: .center) {
            TextField("", text: rawStringBinding)
                .keyboardType(.numberPad)
                .focused($isFocused)
                .opacity(0.01)
            
            CurrencyDecorationView(for: value)
                .scaleEffect(bounceScale)
                .onChange(of: value) { _, _ in
                    withAnimation(.easeOut(duration: 0.05)) {
                        bounceScale = 1.08
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                            bounceScale = 1.0
                        }
                    }
                    
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                }
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
