//
//  HomeViewController.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 14/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        [welcomeImageView, welcomeLabel].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            welcomeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            
            welcomeLabel.topAnchor.constraint(equalTo: welcomeImageView.bottomAnchor, constant: 30),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}