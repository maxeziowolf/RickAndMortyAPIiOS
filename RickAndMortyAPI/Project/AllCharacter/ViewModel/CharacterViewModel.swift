//
//  CharacterViewModel.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 19/01/23.
//

import Combine
import UIKit

class CharacterViewModel {
    
    private var nextPage: String?
    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    private var isSendRequest: Bool = false
    private var firstRequest = true
    @Published var results: [Character] = []
    @Published var allCount: Int = 826
    @Published var isLoading: Bool = false
    
    init() {
        cache.totalCostLimit = 300 * 1024 * 1024 //300MB
    }
    
    
    func getCharacters(){
        if !isSendRequest{
            isSendRequest = true
            ResponseAPI.getCharacters(nextPage: nextPage, firstRequest: firstRequest){ [weak self] data, error in
                self?.firstRequest = false
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
                
                self?.isSendRequest = false
            }
        }
        
    }
    
    func getImageCharacter(itemNumber: NSNumber ,url: String, completion: @escaping (UIImage?,Int,Bool) -> Void){
        
        if let chachedImage = self.cache.object(forKey: itemNumber){
            completion(chachedImage,itemNumber.intValue,false)
        }else{
            utilityQueue.async {
                Character.getImageCharacter(url: url) {[weak self]image in
                    if let image = image{
                        self?.cache.setObject(image, forKey: itemNumber)
                    }
                    completion(image,itemNumber.intValue,true)
                }
            }
        }

        
    }
    
    func clearCache(){
        cache.removeAllObjects()
    }
    
}
