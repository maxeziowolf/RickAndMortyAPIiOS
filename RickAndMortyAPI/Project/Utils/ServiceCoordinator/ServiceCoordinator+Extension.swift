//
//  ServiceCoordinator+Extension.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 16/01/23.
//

import UIKit

extension Data {
    func toString() -> String {
        if let dataInfo = String(data: self, encoding: .utf8){
            return dataInfo
        }
        
        return "Sin informacion"
    }
}
