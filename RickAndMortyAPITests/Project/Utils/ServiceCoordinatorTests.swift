//
//  ServiceCoordinatorTests.swift
//  RickAndMortyAPITests
//
//  Created by Maximiliano Ovando Ramírez on 16/01/23.
//

import XCTest
@testable import RickAndMortyAPI

final class ServiceCoordinatorTests: XCTestCase {
    
    override class func setUp() {
        // Se ejecuta antes de iniciar cada test
    }
    
    override class func tearDown() {
        // Se ejecuta al finalizar cada test
    }
    
    func testBuildCorrectURLWithoutParams(){
        // 1.-Given
        let urlCorrect = URL(string: "https://rickandmortyapi.com/api/character")
        let urlTest = "https://rickandmortyapi.com/api/character"
        
        // 2.-When
        let urlGet = ServiceCoordinator.getURL(url: urlTest, parameters: nil)
        
        // 3.-Then
        XCTAssertEqual(urlCorrect, urlGet, "No se obtuvo correctamente la URL sin parametros")
        
    }


    func testBuildCorrectURLWithParams(){
        // 1.-Given
        let urlCorrect = URL(string: "https://rickandmortyapi.com/api/character/?page=19")
        let urlTest = "https://rickandmortyapi.com/api/character/"
        let parameters: [String : Any] = ["page":19]
        
        // 2.-When
        let urlGet = ServiceCoordinator.getURL(url: urlTest, parameters: parameters)
        
        // 3.-Then
        XCTAssertEqual(urlCorrect, urlGet, "No se obtuvo correctamente la URL con parametros")
        
    }
    
    func testPerformanceBuildURLWithoutParams() {
        
        self.measure {
            // 1.-Given
            let urlCorrect = URL(string: "https://rickandmortyapi.com/api/character/character/character/longer")
            let urlTest = "https://rickandmortyapi.com/api/character/character/character/longer"
            
            // 2.-When
            let urlGet = ServiceCoordinator.getURL(url: urlTest, parameters: nil)
            
            // 3.-Then
            XCTAssertEqual(urlCorrect, urlGet, "No se obtuvo correctamente la URL sin parametros")
        }
        
    }
    
    func testPerformanceBuildURLWithParams() {
        
        self.measure {
            // 1.-Given
            let urlCorrect = URL(string: "https://rickandmortyapi.com/api/character/?page=19")
            let urlTest = "https://rickandmortyapi.com/api/character/"
            let parameters: [String : Any] = ["page":19]
            
            // 2.-When
            let urlGet = ServiceCoordinator.getURL(url: urlTest, parameters: parameters)
            
            // 3.-Then
            XCTAssertEqual(urlCorrect, urlGet, "No se obtuvo correctamente la URL con parametros")
        }
        
    }
    
    func testSendResquestCorrect(){
        
        // 1.-Given
        var correctCompletion = false
        let url = "https://rickandmortyapi.com/api/character"
        
        // 2.-When
        ServiceCoordinator.sendRequest(url: url) { (response: ServiceStatus<ResponseAPI>) in
            switch response{
            case .success(data: _):
                // 3.-Then
                correctCompletion = true
            case .failed(error: _):
                // 3.-Then
                correctCompletion = false
            case .unowned(error: _):
                // 3.-Then
                correctCompletion = false
            }
            XCTAssert(correctCompletion, "No se completo correctamente la peticion")
        }
        
    }
    
    func testSendResquestCorrectWithParams(){
        
        // 1.-Given
        var correctCompletion = false
        let url = "https://rickandmortyapi.com/api/character/"
        let parameters: [String : Any] = ["page":19]
        
        // 2.-When
        ServiceCoordinator.sendRequest(url: url, parameters: parameters) { (response: ServiceStatus<ResponseAPI>) in
            switch response{
            case .success(data: _):
                // 3.-Then
                correctCompletion = true
            case .failed(error: _):
                // 3.-Then
                correctCompletion = false
            case .unowned(error: _):
                // 3.-Then
                correctCompletion = false
            }
            XCTAssert(correctCompletion, "No se completo correctamente la peticion")
        }
        
    }
    
    func testPerformanceSendResquestCorrect(){
        
        self.measure {
            // 1.-Given
            var correctCompletion = false
            let url = "https://rickandmortyapi.com/api/character"
            
            // 2.-When
            ServiceCoordinator.sendRequest(url: url) { (response: ServiceStatus<ResponseAPI>) in
                switch response{
                case .success(data: _):
                    // 3.-Then
                    correctCompletion = true
                case .failed(error: _):
                    // 3.-Then
                    correctCompletion = false
                case .unowned(error: _):
                    // 3.-Then
                    correctCompletion = false
                }
                XCTAssert(correctCompletion, "No se completo correctamente la peticion")
            }
        }
        
    }
    
    func testPerformanceSendResquestCorrectWithParams(){
        
        self.measure {
            // 1.-Given
            var correctCompletion = false
            let url = "https://rickandmortyapi.com/api/character/"
            let parameters: [String : Any] = ["page":19]
            
            // 2.-When
            ServiceCoordinator.sendRequest(url: url, parameters: parameters) { (response: ServiceStatus<ResponseAPI>) in
                switch response{
                case .success(data: _):
                    // 3.-Then
                    correctCompletion = true
                case .failed(error: _):
                    // 3.-Then
                    correctCompletion = false
                case .unowned(error: _):
                    // 3.-Then
                    correctCompletion = false
                }
                XCTAssert(correctCompletion, "No se completo correctamente la peticion")
            }
        }
        
    }

    

}
