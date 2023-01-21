//
//  CharacterCollectionViewCell.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 16/01/23.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CharacterCollectionViewCell"
    
    var itemNumber: Int = 0
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "image.rick.default.image")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cardCharacterView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "GreenRick")?.cgColor
        view.layer.masksToBounds = false
        view .translatesAutoresizingMaskIntoConstraints = false
        
        
        
        return view
    } ()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nombre del personaje"
        label.textColor = .red
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let characterStateLabel: UILabel = {
       let label = UILabel()
        label.text = "Estado del personaje"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .red
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let view: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10/2
        view.backgroundColor = .gray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(characterImageView)
        contentView.addSubview(cardCharacterView)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView2 = UIStackView()
        stackView2.axis = .horizontal
        stackView2.distribution = .fillProportionally
        stackView2.alignment = .center
        stackView2.spacing = 5
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        

        
        cardCharacterView.addSubview(stackView)
        cardCharacterView.addSubview(stackView2)
        
        stackView.addArrangedSubview(characterNameLabel)
        stackView.addArrangedSubview(stackView2)
        
        
        stackView2.addArrangedSubview(view)
        stackView2.addArrangedSubview(characterStateLabel)

        
        
        NSLayoutConstraint.activate([
            
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            characterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width * 5/6),
            characterImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width * 5/6),
            
            cardCharacterView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: -30),
            cardCharacterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardCharacterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardCharacterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: cardCharacterView.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: cardCharacterView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: cardCharacterView.trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: cardCharacterView.bottomAnchor, constant: -5),
            view.heightAnchor.constraint(equalToConstant: 10),
            view.widthAnchor.constraint(equalToConstant: 10)
            
        ])
        
        
        characterImageView.layer.masksToBounds = false
        characterImageView.layer.cornerRadius = (contentView.frame.width * 5/6)/2
        characterImageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func setupInfo(info: Character, itemNumber: Int){
        
        characterNameLabel.text = info.name ?? ""
        characterStateLabel.text = info.status ?? ""
        characterImageView.image = UIImage(named: "image.rick.default.image")
        self.itemNumber = itemNumber
        
        switch info.status {
        case "Alive":
            view.backgroundColor = .green
        case "Dead":
            view.backgroundColor = .red
        default:
            view.backgroundColor = .gray
        }
        
    }
    
    func setupImage(image: UIImage?, itemNumber: Int, animated: Bool){

        if self.itemNumber == itemNumber{
            characterImageView.contentMode = .scaleAspectFill
            if let image = image{
                characterImageView.image = image
            }
            if animated{
                characterImageView.downloadAnimation()
            }
        }
    }
    
    
}


