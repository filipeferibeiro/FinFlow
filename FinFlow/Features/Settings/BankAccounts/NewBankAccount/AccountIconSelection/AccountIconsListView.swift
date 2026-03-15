//
//  AccountIconsListView.swift
//  FinFlow
//
//  Created by Filipe Fernandes on 13/03/26.
//

import SwiftUI

struct AccountIconsListView: View {
    @Environment(\.dismiss) private var dismiss;
    @Binding var selectedIcon: String
    
    var themeColor: Color = .accent
    
    private let columns = [
        GridItem(.adaptive(minimum: 64, maximum: 80), spacing: 16)
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(groupedAccountIcons) { category in
                    Section {
                        ForEach(category.icons, id: \.self) { iconName in
                            IconCellView(
                                iconName: iconName,
                                isSelected: selectedIcon == iconName,
                                themeColor: themeColor
                            )
                            .onTapGesture {
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.impactOccurred()
                                
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    selectedIcon = iconName
                                }
                                
                                dismiss()
                            }
                        }
                    } header: {
                        Text(category.name)
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 8)
                            .padding(.bottom, 4)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
        }
        .navigationTitle("Escolher Ícone")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable @State var selectedIcon: String = "building.columns.fill"
    
    AccountIconsListView(selectedIcon: $selectedIcon)
}
