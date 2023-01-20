//
//  CharacterViewModel.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 19/01/23.
//

import Combine

class CharacterViewModel {
    
    var nextPage: String?
    @Published var results: [Character] = []
    @Published var allCount: Int = 826
    @Published var isLoading: Bool = false
    
    
    func getCharacters(){
        
        ResponseAPI.getCharacters(nextPage: nextPage){ [weak self] data, error in
            guard let data = data else {
                guard let error = error else {
                    print("Error desconocido")
                    return
                }
                print(error)
                return
            }
            
            if let info = data.results{
                self?.results.append(contentsOf: info)
                self?.nextPage = data.info?.next
                self?.allCount = data.info?.count ?? 826
            }
        }
        
    }
    
    
}
