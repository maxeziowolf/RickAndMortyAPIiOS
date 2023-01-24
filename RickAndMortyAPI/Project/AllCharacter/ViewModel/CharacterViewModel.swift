//
//  CharacterViewModel.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 19/01/23.
//

import Combine
import UIKit

class CharacterViewModel {
    
    private var useCasesCharacters = UseCasesCharacters()
    @Published var results: [Character] = []
    @Published var allCount: Int = 826
    @Published var isLoading: Bool = false
    
    
    func getCharacters(){

            useCasesCharacters.getCharacters{ [weak self] data, error in

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
                    self?.allCount = data.info?.count ?? 826
                }
            }

        
    }
    
    func getImageCharacter(itemNumber: NSNumber ,url: String, completion: @escaping (UIImage?,Int) -> Void){
        
        useCasesCharacters.getImageCharacter(itemNumber: itemNumber, url: url, completion: completion)
        
    }
    
    func clearCache(){
        useCasesCharacters.clearCache()
    }
    

    
}
