//
//  CharacterCollectionViewCell.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 16/01/23.
//

import UIKit
import SwiftUI

class CharacterCollectionViewCell: UICollectionViewCell {
    
    //MARK: Static variables
    static let identifier = "CharacterCollectionViewCell"
    
    //MARK: Internal variables
    var itemNumber: Int = 0
    var info: Character?
    var loadingAnimated = false
    
    //MARK: UIComponets
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "image.rick.default.image")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
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
        let color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.backgroundColor = color
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view .translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nombre del personaje"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .bold)
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
        label.textColor = .white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewStatus: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10/2
        view.backgroundColor = .gray
        return view
    }()
    
    private let infoStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
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
    
    //MARK: Inicializacion de la celda
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Se agregan las vistas
        [characterImageView,loadingImageView ,cardCharacterView].forEach(contentView.addSubview)
        cardCharacterView.addSubview(infoStackView)
        [characterNameLabel, statusStackView].forEach(infoStackView.addArrangedSubview)
        [viewStatus,characterStateLabel].forEach(statusStackView.addArrangedSubview)

        
        //Se agregan los respectivos constrains
        NSLayoutConstraint.activate([
            
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            loadingImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            loadingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            loadingImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            loadingImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            
            cardCharacterView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: -70),
            cardCharacterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardCharacterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardCharacterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            infoStackView.topAnchor.constraint(equalTo: cardCharacterView.topAnchor, constant: 10),
            infoStackView.leadingAnchor.constraint(equalTo: cardCharacterView.leadingAnchor, constant: 10),
            infoStackView.trailingAnchor.constraint(equalTo: cardCharacterView.trailingAnchor, constant: -5),
            infoStackView.bottomAnchor.constraint(equalTo: cardCharacterView.bottomAnchor, constant: -10),
            viewStatus.heightAnchor.constraint(equalToConstant: 10),
            viewStatus.widthAnchor.constraint(equalToConstant: 10)
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func setupInfo(info: Character, itemNumber: Int){
        
        self.info = info
        characterNameLabel.text = info.name ?? ""
        characterStateLabel.text = info.status ?? ""
        characterImageView.image = UIImage(named: "image.rick.default.image")
        self.itemNumber = itemNumber
        characterImageView.isHidden = false
        loadingImageView.isHidden = true
        viewStatus.isHidden = false
        loadingAnimated = false
        
        switch info.status {
        case "Alive":
            viewStatus.backgroundColor = .green
        case "Dead":
            viewStatus.backgroundColor = .red
        default:
            viewStatus.backgroundColor = .gray
        }
        
    }
    
    func setupLoadingCard(){
        
        characterNameLabel.text = "Loading..."
        characterStateLabel.text = ""
        characterImageView.isHidden = true
        loadingImageView.isHidden = false
        viewStatus.isHidden = true
        loadingAnimated = true
        loadingAnimation()
        
    }
    
    func setupImage(image: UIImage?, itemNumber: Int){

        if self.itemNumber == itemNumber{
            
            characterImageView.contentMode = .scaleAspectFill
            
            if let image = image{
                
                switch info?.status ?? ""{
                case "Alive":
                    characterImageView.image = image
                case "Dead":
                    characterImageView.image = image.toBlackColorImage()
                default:
                    characterImageView.image = image
                }
                
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

//MARK: Previews

struct CharacterCollectionViewCell_Previews: PreviewProvider {
    
    static let character = Character(id: 0, name: "Rick Sanchez", status: "Alive", species: "", type: "", gender: "", origin: nil, location: nil, image: "", episode: [], url: "", created: "")
    
    static let widthSize = 200
    static let heightSize = 300
    
    static var previews: some View{
        ViewPreview{
            let view = CharacterCollectionViewCell(frame: CGRect(x: 0, y: 0, width: widthSize, height: heightSize))
            let characterViewmodel = CharacterViewModel()
//            characterViewmodel.getImageCharacter(itemNumber:  0, url:  "https://rickandmortyapi.com/api/character/avatar/1.jpeg" ) { image,itemNumber in
//                view.setupImage(image: image, itemNumber: itemNumber)
//            }
            //view.setupInfo(info: character, itemNumber: 0)
            view.setupLoadingCard()
            return view
        }
        .previewLayout(PreviewLayout.fixed(width: CGFloat(widthSize + 40), height: CGFloat(heightSize + 10)))
        .padding(5)
        .edgesIgnoringSafeArea(.all)
    }
    
}
