//
//  CharacterDetailsViewModel.swift
//  RickAndMortyCharacters
//
//  Created by Munachimso Ugorji on 9/22/24.
//

import SwiftUI

class CharacterDetailsViewModel: ObservableObject {
    @Published var character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    func statusColor(for status: String) -> Color {
        switch status.lowercased() {
        case "alive":
            return .green
        case "dead":
            return .red
        default:
            return .gray
        }
    }
}
