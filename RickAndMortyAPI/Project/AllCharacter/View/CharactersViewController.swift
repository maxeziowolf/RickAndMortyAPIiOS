//
//  CharactersViewController.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 16/01/23.
//

import UIKit

class CharactersViewController: UIViewController {
    
    private let flowLayoutCollectionView: UICollectionViewFlowLayout = {
        let layaout = UICollectionViewFlowLayout()
        layaout.scrollDirection = .vertical
        layaout.sectionInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        layaout.minimumInteritemSpacing = 10
        layaout.minimumLineSpacing = 10
        return layaout
    }()
    
    var results: [Result] = []
    var nextPage: String?

    private let characterCollectionview: UICollectionView = {
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionview.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.backgroundColor = .clear
        return collectionview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        [characterCollectionview].forEach(view.addSubview)
        
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.barTintColor = UIColor.green
//        self.navigationController?.navigationBar.backgroundColor = UIColor.green
//        self.tabBarController?.tabBar.barTintColor = UIColor.green
//        self.tabBarController?.tabBar.tintColor = UIColor.green
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
        self.navigationController?.navigationBar.tintColor = UIColor.green
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        
        self.navigationItem.title = "Characters"
        
        flowLayoutCollectionView.itemSize = .init(width: (view.frame.width - 50 )/2, height: view.frame.width * 19/40)
        
        characterCollectionview.collectionViewLayout = flowLayoutCollectionView
        
       
        

        NSLayoutConstraint.activate([
            characterCollectionview.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            characterCollectionview.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            characterCollectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            characterCollectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])

        characterCollectionview.dataSource = self
        characterCollectionview.delegate = self
        
        ServiceCoordinator.sendRequest(url: "https://rickandmortyapi.com/api/character") { (response: ServiceStatus<ResponseAPI>) in
            switch response {
            case .success(let data):
                if let info = data.results{
                    self.results = info
                    self.nextPage = data.info?.next
                }
                self.characterCollectionview.reloadData()
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
                        }
                        self.characterCollectionview.reloadData()
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


