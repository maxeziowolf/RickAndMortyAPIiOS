//
//  HomeViewController.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 14/01/23.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    //prueba
    
    private let welcomeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "image.rickandmorty.logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Bienvenido a la aplicacion de Rick and Morty API"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let charactersImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "image.characters")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Characters"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        [welcomeImageView, welcomeLabel, charactersImageView, titleLabel].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            welcomeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            welcomeImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4.0/5.0),
            
            welcomeLabel.topAnchor.constraint(equalTo: welcomeImageView.bottomAnchor, constant: 30),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            charactersImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            charactersImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            charactersImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3.0/5.0),
            charactersImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3.0/5.0),
            
            titleLabel.topAnchor.constraint(equalTo: charactersImageView.bottomAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
        
        charactersImageView.layer.masksToBounds = false
        charactersImageView.layer.cornerRadius = (view.frame.width * 3/5)/2
        charactersImageView.clipsToBounds = true
        
        charactersImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openCollection)))
        
    }
    
    @objc func openCollection(){
//        self.navigationController?.pushViewController(CharactersViewController(nibName: nil, bundle: nil), animated: true)
    }

}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View{
        ViewControllerPreview{
            HomeViewController()
        }
    }
}

