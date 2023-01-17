//
//  ServiceCoordinator.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 16/01/23.
//

import UIKit

enum ServiceStatus {
    case Success
    case Failed
    case unowned
}

public class ServiceCoordinator {
    
    
    
    public static func sendRequest(url urlString: String, parameters params: [String]? = nil){
        
        
    }
    
    public static func getURL(url urlString: String, parameters params: [String: Any]? = nil) -> URL? {
        
        var urlComponets = URLComponents(string: urlString)
        
        if let params = params {
            
            var queryItems: [URLQueryItem] = []
            
            params.forEach { (key: String, value: Any) in
                let valueString = String(describing: value)
                queryItems.append(URLQueryItem(name: key, value: valueString))
            }
            
            urlComponets?.queryItems = queryItems
            
            return urlComponets?.url
            
        }else{
            
            return urlComponets?.url
        }
        
    }
    
}
