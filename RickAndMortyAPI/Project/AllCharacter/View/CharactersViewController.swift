//
//  CharactersViewController.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 16/01/23.
//

import UIKit
import Combine
import SwiftUI

class CharactersViewController: UIViewController {
    
    //MARK: Variables
    
    var characterView: CharactersView?
    var characterViewmodel = CharacterViewModel()
    var anyCancellable: [AnyCancellable] = []
    
    //MARK: Lifecycle
    
    override func loadView() {
        characterView = CharactersView()
        view = characterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewConfiguration()
        
        subscriptions()
        
        characterViewmodel.getCharacters()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscriptions()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        anyCancellable.removeAll()
        characterViewmodel.clearCache()
    }
    
    //MARK: Functions
    
    private func setupViewConfiguration(){
        
        characterView?.setupFlowLayaotConfig(width: UIScreen.main.bounds.width)
        
        characterView?.setupCollectionviewProtocols(dataSource: self, delegate: self)
        
    }
    
    private func subscriptions(){
        
        characterViewmodel.$results.sink{ [weak self] _ in self?.characterView?.reloadData()}.store(in: &anyCancellable)
        
        characterViewmodel.$allCount.sink{ [weak self] allCount in self?.characterView?.setupCharacterCount(characterCount: self?.characterViewmodel.results.count ?? 826, allCount: allCount)}.store(in: &anyCancellable)
        
    }
    
}

//MARK: UICollectionViewDataSource

extension CharactersViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characterViewmodel.allCount > characterViewmodel.results.count ? characterViewmodel.results.count + 8 : characterViewmodel.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as! CharacterCollectionViewCell
        
        if indexPath.row < characterViewmodel.results.count {
            
            let character = characterViewmodel.results[indexPath.row]
            
            cell.setupInfo(info: character, itemNumber: indexPath.item)
            
            if let url = character.image{
             
                characterViewmodel.getImageCharacter(itemNumber:  NSNumber(value: indexPath.item), url:  url ) { image,itemNumber in
                    cell.setupImage(image: image, itemNumber: itemNumber)
                }
                
            }
            
        }else{
            cell.setupLoadingCard()
        }
        

        
        if indexPath.row == (characterViewmodel.results.count - 1){
            characterViewmodel.getCharacters()
        }
        
        return cell
    }
    
    
}

//MARK: UICollectionViewDelegate

extension CharactersViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = HomeViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: Previews

struct CharactersViewController_Previews: PreviewProvider {
    static var previews: some View{
        ViewControllerPreview{
            CharactersViewController()
        }
    }
}

