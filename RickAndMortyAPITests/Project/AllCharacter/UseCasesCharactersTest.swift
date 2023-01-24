//
//  UseCasesCharacters.swift
//  RickAndMortyAPITests
//
//  Created by Maximiliano Ovando Ramírez on 24/01/23.
//

import XCTest
@testable import RickAndMortyAPI

final class UseCasesCharacterTest: XCTestCase {
    
    private var useCasesCharacters: UseCasesCharacters? = nil
    private let exampleURLImage = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"

    override func setUp() {
        useCasesCharacters = UseCasesCharacters()
    }
    
    override func tearDown(){
        useCasesCharacters?.clearCache()
        useCasesCharacters = nil
    }
    
    func testGetCharacters(){
        useCasesCharacters?.getCharacters(completion: { reponse, error in
            XCTAssertNotNil(reponse)
        })
    }
    
    func testGetCharactersPerformance(){
        self.measure {
            useCasesCharacters?.getCharacters(completion: { reponse, error in
                XCTAssertNotNil(reponse)
            })
        }
    }
    
    func testGetCharacterInfo() {
        useCasesCharacters?.getCharacters(completion: { reponse, error in
            XCTAssertGreaterThan(reponse?.info?.count ?? 0, 0)
        })
    }
    
    func testGetCharacterPerformance() {
        self.measure {
            useCasesCharacters?.getCharacters(completion: { reponse, error in
                XCTAssertGreaterThan(reponse?.info?.count ?? 0, 0)
            })
        }
    }
    
    func testGetImageCharacter(){
        useCasesCharacters?.getImageCharacter(itemNumber: 0, url: exampleURLImage, completion: { image, itemNumber in
            XCTAssertNotNil(image)
        })
    }
    
    func testGetImageCharacterPerformance(){
        self.measure {
            useCasesCharacters?.getImageCharacter(itemNumber: 0, url: exampleURLImage, completion: { image, itemNumber in
                XCTAssertNotNil(image)
            })
        }
    }
    
    func testGetImageFromCache(){
        useCasesCharacters?.getImageCharacter(itemNumber: 0, url: exampleURLImage, completion: {[weak self] image, itemNumber in
            
            self?.useCasesCharacters?.getImageCharacter(itemNumber: 0, url: self?.exampleURLImage ?? "", completion: { image, itemNumber in
                XCTAssertNotNil(image)
            })
            
        })
    }
    
    func testGetImageFromCachePerformance(){

        self.measure {
            useCasesCharacters?.getImageCharacter(itemNumber: 0, url: exampleURLImage, completion: {[weak self] image, itemNumber in
                
                self?.useCasesCharacters?.getImageCharacter(itemNumber: 0, url: self?.exampleURLImage ?? "", completion: { image, itemNumber in
                    XCTAssertNotNil(image)
                })
                
            })
        }
        
    }


}
