//
//  CharactersViewController.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 16/01/23.
//

import UIKit
import Combine

class CharactersViewController: UIViewController {
    
    var characterView: CharactersView?
    var characterViewmodel = CharacterViewModel()
    var anyCancellable: [AnyCancellable] = []
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        anyCancellable.removeAll()
        characterViewmodel.clearCache()
    }
    
    private func setupViewConfiguration(){
        
        self.navigationItem.title = "Characters"
        
        if let navigationController = navigationController{
            characterView?.setupNavigationbarConfig(navigationController: navigationController)
        }
        
        characterView?.setupFlowLayaotConfig(width: UIScreen.main.bounds.width)
        
        characterView?.setupCollectionviewProtocols(dataSource: self, delegate: self)
        
    }
    
    private func subscriptions(){
        
        characterViewmodel.$results.sink{ [weak self] _ in self?.characterView?.reloadData()}.store(in: &anyCancellable)
        
        characterViewmodel.$allCount.sink{ [weak self] allCount in self?.characterView?.setupCharacterCount(characterCount: self?.characterViewmodel.results.count ?? 826, allCount: allCount)}.store(in: &anyCancellable)
        
    }
    
}

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


extension CharactersViewController: UICollectionViewDelegate{
    
}


