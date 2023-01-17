//
//  ServiceCoordinatorTests.swift
//  RickAndMortyAPITests
//
//  Created by Maximiliano Ovando Ramírez on 16/01/23.
//

import XCTest
@testable import RickAndMortyAPI

final class ServiceCoordinatorTests: XCTestCase {
    
    func testBuildCorrectURLWithoutParams() throws {
        
        let urlCorrect = URL(string: "www.example.com/help")
        
        let urlTest = "www.example.com/help"
        
        let urlGet = ServiceCoordinator.getURL(url: urlTest, parameters: nil)
        
        print("url correcta: \(String(describing: urlCorrect))")
        print("url obtenida: \(String(describing: urlGet))")
        
        XCTAssertEqual(urlCorrect, urlGet, "No se obtuvo correctamente la URL sin parametros")
        
    }


    func testBuildCorrectURLWithParams() throws{
        
        let urlCorrect = URL(string: "www.example.com/help?id=1&count=2")
        
        let urlTest = "www.example.com/help"
        
        let parameters: [String : Any] = ["id":1, "count":"2"]
        
        let urlGet = ServiceCoordinator.getURL(url: urlTest, parameters: parameters)
        
        print("url correcta: \(String(describing: urlCorrect))")
        print("url obtenida: \(String(describing: urlGet))")
        
        XCTAssertEqual(urlCorrect, urlGet, "No se obtuvo correctamente la URL con parametros")
        
    }
    

    

}
