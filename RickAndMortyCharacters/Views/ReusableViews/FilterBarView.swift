//
//  FilterBarView.swift
//  RickAndMortyCharacters
//
//  Created by Munachimso Ugorji on 9/21/24.
//

import SwiftUI

struct FilterBarView: View {
    @Binding var selectedFilter: FilterOption?
    
    enum FilterOption: String, CaseIterable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "Unknown"
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                filterButton
                Divider()
                    .frame(height: 15)
                    .background(Color.gray300)
                ForEach(FilterOption.allCases, id: \.self) { option in
                    filterOption(option)
                }
            }
        }
    }
    
    private var filterButton: some View {
        createButton(title: "Filter", icon: "mage_filter", action: { selectedFilter = nil })
    }
    
    private func filterOption(_ option: FilterOption) -> some View {
        createButton(title: option.rawValue, isSelected: selectedFilter == option, action: { selectedFilter = option })
    }
    
    private func createButton(title: String, icon: String? = nil, isSelected: Bool = false, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                if let icon = icon {
                    Image(icon)
                }
                Text(title).font(.system(size: 16))
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(isSelected ? Color.lightGreen : Color.gray200)
            .foregroundColor(isSelected ? Color.gray800 : Color.gray500)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? Color.mediumGreen : Color.gray200, lineWidth: 1)
            )
        }
    }
}
