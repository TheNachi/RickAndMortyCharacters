//
//  CharacterModel.swift
//  RickAndMortyCharacters
//
//  Created by Munachimso Ugorji on 9/21/24.
//

import Foundation

struct Character: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let species: String
    let status: String
    let gender: String
    let image: String
    let location: Location
}

struct Location: Codable, Hashable {
    let name: String
    let url: String
}
