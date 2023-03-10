//
//  UIImage+extensions.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 09/03/23.
//

import UIKit

extension UIImage {
    
    func toBlackColorImage() -> UIImage? {
        
        let ciImage = CIImage(image: self)
        let filter = CIFilter(name: "CIColorControls")
        
        guard let filter = filter else { return nil }
        
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(0.0, forKey: kCIInputSaturationKey)
        
        let context = CIContext(options: nil)
        
        guard let outputImage = filter.outputImage,
              let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        
        return UIImage(cgImage: cgImage)
        
    }
    
}
