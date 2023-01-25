//
//  RickAndMortyAPIConstans.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 19/01/23.
//

struct RickAndMortyAPIConstans {
    
    static let baseURL = "https://rickandmortyapi.com/api/"
    
    static let characterEndPoint = "character"
    
    static func getCharacterUrl() -> String{ baseURL+characterEndPoint }
    
}
