//
//  MonthSelectionView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 12/03/26.
//

import SwiftUI

struct MonthSelectionView: View {
    @Binding var selectedMonth: Date
    
    @State private var offset = CGSize.zero
    
    var body: some View {
        HStack {
            Button(action: { changeMonth(by: -1) }) {
                Image(systemName: "chevron.left")
                    .frame(width: 44, height: 44)
            }
            
            Spacer()
            
            Text(formattedDate(selectedMonth, monthFormatter: .wide))
                .fontWeight(.bold)
                .contentTransition(.numericText())
                .id(selectedMonth)
                .offset(offset)
            
            Spacer()
            
            Button(action: { changeMonth(by: 1) }) {
                Image(systemName: "chevron.right")
                    .frame(width: 44, height: 44)
            }
        }
        .font(.title2)
        .foregroundStyle(.primary)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .glassEffectWithFallback(in: .capsule)
        .contentShape(Rectangle())
        .gesture(
            DragGesture()
                .onChanged { value in
                    offset = CGSize(width: value.translation.width * 0.4, height: 0)
                }
                .onEnded { value in
                    let threshold: CGFloat = 40
                    
                    if value.translation.width < -threshold {
                        changeMonth(by: 1)
                    } else if value.translation.width > threshold {
                        changeMonth(by: -1)
                    }
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        offset = .zero
                    }
                }
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Mês selecionado")
        .accessibilityValue(formattedDate(selectedMonth, monthFormatter: .wide))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                changeMonth(by: 1)
            case .decrement:
                changeMonth(by: -1)
            @unknown default:
                break
            }
        }
    }
    
    private func formattedDate(_ date: Date, monthFormatter: Date.FormatStyle.Symbol.Month) -> String {
        let currentYear = Calendar.current.component(.year, from: Date())
        let isCurrentYear = currentYear == Calendar.current.component(.year, from: date)
        
        return date.formatted(.dateTime.month(isCurrentYear ? monthFormatter : .abbreviated).year(isCurrentYear ? .omitted : .defaultDigits))
    }
    
    private func changeMonth(by value: Int) {
        guard let newDate = Calendar.current.date(byAdding: .month, value: value, to: selectedMonth) else {
            return
        }
        
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            selectedMonth = newDate
        }
    }
}

#Preview {
    MonthSelectionView(selectedMonth: .constant(Date()))
}
