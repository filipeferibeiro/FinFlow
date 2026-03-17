//
//  CurrencyDecorationView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 16/03/26.
//

import SwiftUI

struct CurrencyDecorationView: View {
    var value: Int
    
    var isVisible: Bool
    var fontSize: CGFloat
    var fontWeight: Font.Weight
    
    init(for value: Int, isVisible: Bool = true, fontSize: CGFloat = 60, fontWeight: Font.Weight = .bold) {
        self.value = value
        self.isVisible = isVisible
        self.fontSize = fontSize
        self.fontWeight = fontWeight
    }
    
    private var splitCurrency: (main: String, cents: String) {
        let fullString = value.asCurrencyString()
        
        if let commaRange = fullString.lastIndex(of: ",") {
            let main = String(fullString[..<commaRange])
            let cents = String(fullString[fullString.index(after: commaRange)...])
            return (main, cents)
        } else if let dotRange = fullString.lastIndex(of: ".") {
            let main = String(fullString[..<dotRange])
            let cents = String(fullString[fullString.index(after: dotRange)...])
            return (main, cents)
        }
        
        return (fullString, "00")
    }
    
    var body: some View {
        let mainPart = Text(isVisible ? splitCurrency.main : "••••••••")
            .font(.system(size: fontSize, weight: fontWeight, design: .rounded))
        
        let centsPart = Text(isVisible ? splitCurrency.cents : "")
            .font(.system(size: fontSize * 0.55, weight: fontWeight, design: .rounded))
        
        Text("\(mainPart)\(centsPart)")
            .lineLimit(1)
            .minimumScaleFactor(0.4)
            .contentTransition(.numericText())
            .animation(.snappy, value: isVisible)
            .animation(.snappy, value: value)
    }
    
}

#Preview {
    CurrencyDecorationView(for: 3456)
}
