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


