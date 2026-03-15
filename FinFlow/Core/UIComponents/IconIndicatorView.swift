//
//  IconIndicatorView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 14/03/26.
//

import SwiftUI

struct IconIndicatorView: View {
    let color: Color
    let icon: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color.opacity(0.15))
                .frame(width: 44, height: 44)
            Image(systemName: icon)
                .foregroundStyle(color)
                .font(.system(size: 18, weight: .semibold))
        }
    }
}

#Preview {
    IconIndicatorView(color: .blue, icon: "arrow.2.circlepath.circle")
}
