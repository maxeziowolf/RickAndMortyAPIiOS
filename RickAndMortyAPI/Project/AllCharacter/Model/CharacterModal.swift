//
//  CharacterModal.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 16/01/23.
//

import UIKit

// MARK: - ResponseAPI
struct ResponseAPI: Codable {
    let info: Info?
    let results: [Character]?
    

    
    public static func getCharacters(nextPage: String?, firstRequest: Bool, completion: @escaping (ResponseAPI?, String?) -> Void){
        
        guard let url = firstRequest ? RickAndMortyAPIConstans.getCharacterUrl() : nextPage else {
            return
        }
        
        ServiceCoordinator.sendRequest(url: url) { (response: ServiceStatus<ResponseAPI>) in
            switch response {
            case .success(let data):
                completion(data, nil)
            case .failed(let error):
                completion(nil, error.rawValue)
            case .unowned(let error):
                completion(nil, error)
            }
        }
        
    }
    
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Character
struct Character: Codable {
    let id: Int?
    let name, status, species, type: String?
    let gender: String?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    
    public static func getImageCharacter(url: String, completion: @escaping (UIImage?) -> Void){
        ServiceCoordinator.downloadedFrom(link: url, completion: completion)
    }
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}



