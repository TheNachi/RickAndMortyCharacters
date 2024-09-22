//
//  ApiResponse.swift
//  RickAndMortyCharacters
//
//  Created by Munachimso Ugorji on 9/21/24.
//

import Foundation

struct APIResponse: Codable {
    let info: PaginationInfo
    let results: [Character]
}
