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
    
    var loadingAnimated = false
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "image.rick.default.image")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let loadingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "image.loader.portal")
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
        label.textColor = .black
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
        label.textColor = .black
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
    
    private let infoStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let statusStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(characterImageView)
        contentView.addSubview(loadingImageView)
        contentView.addSubview(cardCharacterView)
        cardCharacterView.addSubview(infoStackView)
        infoStackView.addArrangedSubview(characterNameLabel)
        infoStackView.addArrangedSubview(statusStackView)
        statusStackView .addArrangedSubview(view)
        statusStackView .addArrangedSubview(characterStateLabel)

        
        
        NSLayoutConstraint.activate([
            
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            characterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width * 5/6),
            characterImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width * 5/6),
            
            loadingImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            loadingImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width * 5/6),
            loadingImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width * 5/6),
            
            cardCharacterView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: -30),
            cardCharacterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardCharacterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardCharacterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            infoStackView.topAnchor.constraint(equalTo: cardCharacterView.topAnchor, constant: 5),
            infoStackView.leadingAnchor.constraint(equalTo: cardCharacterView.leadingAnchor, constant: 5),
            infoStackView.trailingAnchor.constraint(equalTo: cardCharacterView.trailingAnchor, constant: -5),
            infoStackView.bottomAnchor.constraint(equalTo: cardCharacterView.bottomAnchor, constant: -5),
            view.heightAnchor.constraint(equalToConstant: 10),
            view.widthAnchor.constraint(equalToConstant: 10)
            
        ])
        
        
        characterImageView.layer.masksToBounds = false
        characterImageView.layer.cornerRadius = (contentView.frame.width * 5/6)/2
        characterImageView.clipsToBounds = true
        
        loadingImageView.layer.masksToBounds = false
        loadingImageView.layer.cornerRadius = (contentView.frame.width * 5/6)/2
        loadingImageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func setupInfo(info: Character, itemNumber: Int){
        
        characterNameLabel.text = info.name ?? ""
        characterStateLabel.text = info.status ?? ""
        characterImageView.image = UIImage(named: "image.rick.default.image")
        self.itemNumber = itemNumber
        characterImageView.isHidden = false
        loadingImageView.isHidden = true
        loadingAnimated = false
        
        switch info.status {
        case "Alive":
            view.backgroundColor = .green
        case "Dead":
            view.backgroundColor = .red
        default:
            view.backgroundColor = .gray
        }
        
    }
    
    func setupLoadingCard(){
        
        characterNameLabel.text = "Loading..."
        characterStateLabel.text = ""
        characterImageView.isHidden = true
        loadingImageView.isHidden = false
        loadingAnimated = true
        loadingAnimation()
        view.backgroundColor = .white
        
    }
    
    func setupImage(image: UIImage?, itemNumber: Int){

        if self.itemNumber == itemNumber{
            characterImageView.contentMode = .scaleAspectFill
            if let image = image{
                characterImageView.image = image
            }
        }
        
    }
    
    func loadingAnimation(){
        
        if loadingAnimated {
            UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear], animations: {[weak self] in
                self?.loadingImageView.transform = self?.loadingImageView.transform.rotated(by: .pi) ?? .identity
            }) { _ in
                UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear], animations: { [weak self] in
                    self?.loadingImageView.transform = self?.loadingImageView.transform.rotated(by: .pi) ?? .identity
                }) { [weak self] _ in
                    self?.loadingAnimation()
                }
            }
        }
    }
    
    
}


