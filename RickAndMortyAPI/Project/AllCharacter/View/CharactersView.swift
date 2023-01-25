//
//  CharactersView.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 18/01/23.
//

import UIKit

final class CharactersView: UIView {
    
    private let flowLayoutCollectionView: UICollectionViewFlowLayout = {
        let layaout = UICollectionViewFlowLayout()
        layaout.scrollDirection = .vertical
        layaout.sectionInset = .init(top: 10, left: 20, bottom: 20, right: 20)
        layaout.minimumInteritemSpacing = 10
        layaout.minimumLineSpacing = 10
        return layaout
    }()
    
    private let characterCollectionview: UICollectionView = {
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionview.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    private let labelCharacterCount: UILabel = {
        let label = UILabel()
        label.text = "0/000"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .green
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem .title = ""
        return barButtonItem
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .black
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews(){
        [characterCollectionview, labelCharacterCount].forEach(addSubview)
    }
    
    private func configureConstraints(){
        
        NSLayoutConstraint.activate([
            labelCharacterCount.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 10),
            labelCharacterCount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            labelCharacterCount.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            characterCollectionview.topAnchor.constraint(equalTo: labelCharacterCount.bottomAnchor, constant: 10),
            characterCollectionview.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            characterCollectionview.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterCollectionview.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
    }
    
    public func setupNavigationbarConfig(navigationController: UINavigationController){
        
        navigationController.navigationBar.isHidden = false
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
        navigationController.navigationBar.tintColor = UIColor.green
        navigationController.navigationBar.topItem?.backBarButtonItem = backButton
        
    }
    
    public func setupFlowLayaotConfig(width: CGFloat){
        
        let widthSize = (width - 50)/2
        let heightSize = (width)*(19/40)
        
        flowLayoutCollectionView.itemSize = .init(width: widthSize, height: heightSize)
        
        characterCollectionview.collectionViewLayout = flowLayoutCollectionView
    }
    
    public func setupCollectionviewProtocols(dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate){
        
        characterCollectionview.dataSource = dataSource
        characterCollectionview.delegate = delegate
        
    }
    
    public func setupCharacterCount(characterCount: Int, allCount: Int){
        labelCharacterCount.text = "\(characterCount)/\(allCount)"
    }
    
    public func reloadData(){
        characterCollectionview.reloadData()
    }
    
}
