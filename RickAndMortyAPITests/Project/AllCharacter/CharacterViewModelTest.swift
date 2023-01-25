//
//  CharacyerViewModelTest.swift
//  RickAndMortyAPITests
//
//  Created by Maximiliano Ovando Ramírez on 24/01/23.
//

import XCTest
import Combine
@testable import RickAndMortyAPI

final class CharacterViewModelTest: XCTestCase {
    
    private var characterViewModel: CharacterViewModel? = nil
    private let exampleURLImage = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
    
    override func setUp() {
        characterViewModel = CharacterViewModel()
    }
    
    override func tearDown(){
        characterViewModel = nil
    }
    
    func testInitViewModel(){
        XCTAssertNotNil(characterViewModel)
    }
    
    
    func testGetImageCharacter(){
        characterViewModel?.getImageCharacter(itemNumber: 0, url: exampleURLImage, completion: { image, itemNumber in
            XCTAssertNotNil(image)
        })
    }
    
    func testGetImageCharacterPerformance(){
        self.measure {
            characterViewModel?.getImageCharacter(itemNumber: 0, url: exampleURLImage, completion: { image, itemNumber in
                XCTAssertNotNil(image)
            })
        }
    }
    
    func testGetItemCorrect(){
        let itemNumberInitial = 0
        
        characterViewModel?.getImageCharacter(itemNumber: NSNumber(value: itemNumberInitial), url: exampleURLImage, completion: { image, itemNumber in
            XCTAssertEqual(itemNumberInitial, itemNumber)
        })
    }
    
    func testGetItemCorrectPerformance(){
        let itemNumberInitial = 0
        
        self.measure {
            characterViewModel?.getImageCharacter(itemNumber: NSNumber(value: itemNumberInitial), url: exampleURLImage, completion: { image, itemNumber in
                XCTAssertEqual(itemNumberInitial, itemNumber)
            })
        }
    }
    
}
