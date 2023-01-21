//
//  Image+Extensions.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 20/01/23.
//

import UIKit

extension UIImageView{
    
    func downloadAnimation(){
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {
                
                self.transform = .identity
                
            }, completion: nil)
        }
    }
    
}

