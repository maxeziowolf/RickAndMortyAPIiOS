//
//  CharacterCollectionViewCell.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 16/01/23.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CharacterCollectionViewCell"
    
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
    
    func setupInfo(info: Result){
        
        characterNameLabel.text = info.name ?? ""
        characterStateLabel.text = info.status ?? ""
        characterImageView.image = UIImage(named: "image.rick.default.image")
        characterImageView.downloadedFrom(link: info.image ?? "")
        
        switch info.status {
        case "Alive":
            view.backgroundColor = .green
        case "Dead":
            view.backgroundColor = .red
        default:
            view.backgroundColor = .gray
        }
        
    }
    
    
}

extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, animated: Bool = false) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                
                if animated {
                    
                    UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                        
                        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                                
                    }) { (success) in
                        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {
                            
                            self.image = image
                            self.transform = .identity
                            
                        }, completion: nil)
                    }
                    
                }else{
                    
                    self.image = image
                    
                }
                
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, animated: Bool = false) {
        
        guard let url = URL(string: link) else { return }
        
        downloadedFrom(url: url, contentMode: mode, animated: animated)
    }
    
}
