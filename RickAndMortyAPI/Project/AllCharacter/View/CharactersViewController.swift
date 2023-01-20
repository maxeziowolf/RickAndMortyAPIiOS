//
//  CharactersViewController.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 16/01/23.
//

import UIKit

class CharactersViewController: UIViewController {
    
    var characterView: CharactersView?
    var characterViewmodel = CharacterViewModel()
    
    override func loadView() {
        characterView = CharactersView()
        view = characterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Characters"
        
        if let navigationController = navigationController{
            characterView?.setupNavigationbarConfig(navigationController: navigationController)
        }
        
        characterView?.setupFlowLayaotConfig(width: UIScreen.main.bounds.width)
        
        characterView?.setupCollectionviewProtocols(dataSource: self, delegate: self)
        
        characterViewmodel.refreshResults = { [weak self] () in
            self?.characterView?.reloadData()
        }
        
        characterViewmodel.refreshCounts = { [weak self] (characterCount,allCount) in
            self?.characterView?.setupCharacterCount(characterCount: characterCount, allCount: allCount)
        }
        
        characterViewmodel.getCharacters()
        
    }
}

extension CharactersViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characterViewmodel.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as! CharacterCollectionViewCell
        
        cell.setupInfo(info: characterViewmodel.results[indexPath.row])
        
        if indexPath.row == (characterViewmodel.results.count - 1){
            characterViewmodel.getCharacters()
        }
        
        return cell
    }
    
    
}


extension CharactersViewController: UICollectionViewDelegate{
    
}


