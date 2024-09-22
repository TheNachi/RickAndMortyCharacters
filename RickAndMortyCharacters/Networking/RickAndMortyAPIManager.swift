//
//  RickAndMortyAPIManager.swift
//  RickAndMortyCharacters
//
//  Created by Munachimso Ugorji on 9/21/24.
//

import Foundation

import Foundation
import Combine

class RickAndMortyAPI {
    static let shared = RickAndMortyAPI()
    
    func fetchCharacters(page: Int) -> AnyPublisher<[Character], Error> {
        let urlString = "https://rickandmortyapi.com/api/character?page=\(page)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NSError(domain: "Invalid URL", code: -1, userInfo: nil)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .map(\.results)
            .eraseToAnyPublisher()
    }
}
