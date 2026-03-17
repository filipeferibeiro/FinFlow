//
//  SettingsView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 13/03/26.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    BankAccountsView()
                } label: {
                    Label("Bank Accounts", systemImage: "building.columns.fill")
                }
                .listItemBackground()
                .clearListItemDecoration()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .clearListDecoration()
            .withBackground()
        }
    }
}

#Preview {
    SettingsView()
}
