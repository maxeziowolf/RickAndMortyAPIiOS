//
//  Pruebas NavBar.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 09/03/23.
//

import UIKit
import SwiftUI


class HomeTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeItem = UITabBarItem(title: "Home", image:  UIImage(systemName: "house"), tag: 0)
        
        let charactersItem = UITabBarItem(title: "Characters", image:  UIImage(systemName: "person.2"), tag: 1)
        
        let inicioViewController = HomeViewController()
        inicioViewController.title = "Inicio"
        inicioViewController.tabBarItem = homeItem 
        
        let configuracionViewController = CharactersViewController()
        configuracionViewController.title = "Configuración"
        configuracionViewController.tabBarItem = charactersItem
        
        viewControllers = [inicioViewController, configuracionViewController]
        
        tabBar.backgroundColor = .black
        tabBar.barTintColor = .black
        tabBar.tintColor =  UIColor(named: "GreenRick")
        tabBar.unselectedItemTintColor = .white
        
        //delegate = self
        
        selectedIndex = 0
        
        let btn1 = UIBarButtonItem(title: "Opción 1", style: .plain, target: self, action: #selector(hola))
        let btn2 = UIBarButtonItem(title: "Opción 2", style: .plain, target: self, action: #selector(hola))
        self.toolbarItems = [btn1, btn2]
    }
    
    @objc func hola(){
        print("hola")
    }
    
}

extension HomeTabBarViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        UIView.transition(with: tabBarController.view, duration: 0.5, options: [.transitionFlipFromRight], animations: {
            let _ = tabBarController.selectedViewController
        }, completion: nil)
        return true
    }
}

struct HomeTabBarViewController_Previews: PreviewProvider {
    static var previews: some View{
        ViewControllerPreview{
            HomeTabBarViewController()
        }
    }
}
