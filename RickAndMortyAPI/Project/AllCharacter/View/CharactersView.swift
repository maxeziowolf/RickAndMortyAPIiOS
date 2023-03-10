//
//  CharactersView.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 18/01/23.
//

import UIKit
import SwiftUI

final class CharactersView: UIView {
    
    //MARK: UIComponets
    
    private let flowLayoutCollectionView: UICollectionViewFlowLayout = {
        let layaout = UICollectionViewFlowLayout()
        layaout.scrollDirection = .vertical
        layaout.sectionInset = .init(top: 5, left: 5, bottom: 5, right: 5)
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
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem .title = ""
        return barButtonItem
    }()
    
    private let titleCharactersContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageCharacters: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "image.characters")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 60/2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let labelCharacter: UILabel = {
        let label = UILabel()
        label.text = "Characters"
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Inicializadores
    
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
        [titleCharactersContainer,characterCollectionview].forEach(addSubview)
        [imageCharacters, labelCharacter, labelCharacterCount].forEach(titleCharactersContainer.addSubview)
    }
    
    private func configureConstraints(){
        
        NSLayoutConstraint.activate([
            
            titleCharactersContainer.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 0),
            titleCharactersContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleCharactersContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            imageCharacters.topAnchor.constraint(equalTo: titleCharactersContainer.topAnchor, constant: 10),
            imageCharacters.bottomAnchor.constraint(equalTo: titleCharactersContainer.bottomAnchor, constant: -10),
            imageCharacters.leadingAnchor.constraint(equalTo: titleCharactersContainer.leadingAnchor, constant: 10),
            imageCharacters.widthAnchor.constraint(equalToConstant: 60),
            imageCharacters.heightAnchor.constraint(equalToConstant: 60),
            
            labelCharacter.topAnchor.constraint(greaterThanOrEqualTo: titleCharactersContainer.topAnchor),
            labelCharacter.leadingAnchor.constraint(equalTo: imageCharacters.trailingAnchor, constant: 10),
            labelCharacter.bottomAnchor.constraint(equalTo: imageCharacters.bottomAnchor),
            
            labelCharacterCount.topAnchor.constraint(greaterThanOrEqualTo: titleCharactersContainer.topAnchor),
            labelCharacterCount.leadingAnchor.constraint(equalTo: labelCharacter.trailingAnchor, constant: 10),
            labelCharacterCount.bottomAnchor.constraint(equalTo: labelCharacter.bottomAnchor),
            labelCharacterCount.trailingAnchor.constraint(greaterThanOrEqualTo: titleCharactersContainer.trailingAnchor, constant: -10),
            
            
            characterCollectionview.topAnchor.constraint(equalTo: titleCharactersContainer.bottomAnchor, constant: 10),
            characterCollectionview.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            characterCollectionview.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterCollectionview.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        labelCharacter.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
    }
    
    //MARK: Functions
    
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
        
        let widthSize = (width - 20)/2
        let heightSize = (width)*(25/40)
        
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

//MAKR: Previews
struct CharactersView_Previews: PreviewProvider {
    static var previews: some View{
        ViewControllerPreview{
            CharactersViewController()
        }
    }
}
