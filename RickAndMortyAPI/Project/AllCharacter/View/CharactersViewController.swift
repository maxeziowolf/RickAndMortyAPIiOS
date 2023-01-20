//
//  CharactersViewController.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 16/01/23.
//

import UIKit

class CharactersViewController: UIViewController {
    

    
    var results: [Character] = []
    var nextPage: String?
    var characterView: CharactersView?
    
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

        ServiceCoordinator.sendRequest(url: "https://rickandmortyapi.com/api/character") { (response: ServiceStatus<ResponseAPI>) in
            switch response {
            case .success(let data):
                if let info = data.results{
                    self.results = info
                    self.nextPage = data.info?.next
                    self.characterView?.setupCharacterCount(characterCount: self.results.count, allCount: data.info?.count ?? 825)
                    self.characterView?.reloadData()
                }
            case .failed(let error):
                print(error.rawValue)
            case .unowned(let error):
                print(error)
            }
        }
        
        
    }
}

extension CharactersViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as! CharacterCollectionViewCell
        
        cell.setupInfo(info: results[indexPath.row])
        
        if indexPath.row == (results.count - 1){
            if let nextPage = nextPage{
                ServiceCoordinator.sendRequest(url: nextPage) { (response: ServiceStatus<ResponseAPI>) in
                    switch response {
                    case .success(let data):
                        if let info = data.results{
                            self.results.append(contentsOf: info)
                            self.nextPage = data.info?.next
                            self.characterView?.setupCharacterCount(characterCount: self.results.count, allCount: data.info?.count ?? 825)
                            self.characterView?.reloadData()
                        }
                    case .failed(let error):
                        print(error.rawValue)
                    case .unowned(let error):
                        print(error)
                    }
                }
            }
        }
        
        return cell
    }
    
    
}


extension CharactersViewController: UICollectionViewDelegate{
    
}


