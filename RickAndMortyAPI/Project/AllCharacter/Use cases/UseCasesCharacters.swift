//
//  UseCasesCharacters.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 20/01/23.
//


import UIKit

final class UseCasesCharacters {
    
    private var nextPage: String?
    private let cache = NSCache<NSNumber, UIImage>()
    private var isSendRequest: Bool = false
    private var firstRequest = true
    
    init() {
        cache.totalCostLimit = 500 * 1024 * 1024 //500MB
    }
    
    public func getCharacters(completion: @escaping (ResponseAPI?, String?) -> Void){
        
        if !isSendRequest{
            
            isSendRequest = true
            
            guard let url = firstRequest ? RickAndMortyAPIConstans.getCharacterUrl() : nextPage else {
                return
            }
            
            ServiceCoordinator.sendRequest(url: url) { [weak self] (response: ServiceStatus<ResponseAPI>) in
                
                self?.firstRequest = false
                
                switch response {
                case .success(let data):
                    self?.nextPage = data.info?.next
                    completion(data, nil)
                case .failed(let error):
                    completion(nil, error.rawValue)
                case .unowned(let error):
                    completion(nil, error)
                }
                
                self?.isSendRequest = false
                
            }
            
        }
        
    }
    
    public func getImageCharacter(itemNumber: NSNumber ,url: String, completion: @escaping (UIImage?,Int) -> Void){
        
        if let chachedImage = self.cache.object(forKey: itemNumber){
            completion(chachedImage,itemNumber.intValue)
        }else{
            ServiceCoordinator.sendRequest(url: url) {[weak self] (response: ServiceStatus<Data>) in
                switch response {
                case .success(let data):
                    guard let image = UIImage(data: data) else{
                        completion(nil,itemNumber.intValue)
                        return
                    }
                    self?.cache.setObject(image, forKey: itemNumber)
                    completion(image,itemNumber.intValue)
                case .failed(_):
                    completion(nil,itemNumber.intValue)
                case .unowned(_):
                    completion(nil,itemNumber.intValue)
                }
            }

        }
        
    }
    
    func clearCache(){
        cache.removeAllObjects()
    }
    
}
