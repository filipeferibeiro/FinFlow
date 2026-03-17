//
//  BackgroundView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 16/03/26.
//

import SwiftUI

struct BackgroundView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            (colorScheme == .dark ? Color.black : Color(uiColor: .systemGroupedBackground))
                .ignoresSafeArea()
            
            Circle()
                .fill(Color.green.opacity(colorScheme == .dark ? 0.25 : 0.65))
                .blur(radius: 120)
                .offset(x: -150, y: -250)
            
            Circle()
                .fill(Color.mint.opacity(colorScheme == .dark ? 0.2 : 0.55))
                .blur(radius: 140)
                .offset(x: 150, y: 300)
            
            Ellipse()
                .fill(Color.teal.opacity(colorScheme == .dark ? 0.15 : 0.45))
                .frame(width: 300, height: 200)
                .blur(radius: 100)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
