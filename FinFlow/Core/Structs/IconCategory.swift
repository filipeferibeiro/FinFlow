//
//  Structs.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 13/03/26.
//

import Foundation

struct IconCategory: Identifiable {
    let id = UUID()
    let name: String
    let icons: [String]
}

let groupedAccountIcons: [IconCategory] = [
    IconCategory(name: "Instituições e Bancos", icons: [
        "building.columns.fill",
        "building.2.fill",
        "lock.shield.fill",
        "briefcase.fill"
    ]),
    
    IconCategory(name: "Carteiras e Dia a Dia", icons: [
        "wallet.pass.fill",
        "creditcard.fill",
        "banknote.fill",
        "dollarsign.circle.fill"
    ]),
    
    IconCategory(name: "Investimentos", icons: [
        "chart.pie.fill",
        "chart.bar.fill",
        "bitcoinsign.circle.fill",
        "leaf.fill"
    ]),
    
    IconCategory(name: "Consumo e Despesas", icons: [
        "cart.fill",
        "bag.fill",
        "basket.fill"
    ]),
    
    IconCategory(name: "Objetivos (Sinking Funds)", icons: [
        "house.fill",
        "car.fill",
        "airplane",
        "graduationcap.fill",
        "heart.fill"
    ])
]
