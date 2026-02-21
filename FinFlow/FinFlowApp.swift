//
//  FinFlowApp.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 19/02/26.
//

import SwiftUI
import SwiftData

@main
struct FinFlowApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Subscription.self)
    }
}
