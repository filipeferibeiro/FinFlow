//
//  Int+Currency.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 14/03/26.
//

import Foundation

extension Int {
    func asCurrencyString(locale: Locale = .autoupdatingCurrent) -> String {
        let doubledValue = Double(self) / 100.0
        
        let currencyCode = locale.currency?.identifier ?? "USD"
        
        return doubledValue.formatted(
            .currency(code: currencyCode)
            .locale(locale)
        )
    }
}
