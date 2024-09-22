//
//  PaginationInfo.swift
//  RickAndMortyCharacters
//
//  Created by Munachimso Ugorji on 9/21/24.
//

import Foundation

struct PaginationInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
