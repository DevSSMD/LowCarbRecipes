//
//  LCWelcomeVC.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/29/24.
//

import UIKit

class LCWelcomeVC: UIViewController {
    private let welcomeImageView = UIImageView()
    private let actionButton = LCButton(backgroundColor: .systemRed, text: "GET STARTED!")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
        
    }
    
    private func configure() {
        UserDefaults.standard.setValue(true, forKey: "WelcomeScreenSeen")
        view.addSubview(welcomeImageView)
        view.addSubview(actionButton)
        
        welcomeImageView.translatesAutoresizingMaskIntoConstraints = false
        welcomeImageView.image = UIImage(named: "WelcomeImage")
        welcomeImageView.layer.cornerRadius = 15
        welcomeImageView.contentMode = .scaleAspectFill
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            welcomeImageView.topAnchor.constraint(equalTo: view.topAnchor),
            welcomeImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            welcomeImageView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 1.5),
            
            actionButton.topAnchor.constraint(equalTo: welcomeImageView.bottomAnchor, constant: 50),
            actionButton.widthAnchor.constraint(equalToConstant: 250),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            actionButton.centerXAnchor.constraint(equalTo: welcomeImageView.centerXAnchor)
        ])
    }
    
    @objc private func actionButtonTapped() {
        if let tabBarController = tabBarController as? LCTabBarVC,
             let navController = tabBarController.selectedViewController as? UINavigationController {
             
             let recipeListVC = RecipeListVC()
            let tabBarIcon = UIImage(systemName: "fork.knife")
            recipeListVC.tabBarItem = UITabBarItem(title: "Recipes", image: tabBarIcon, tag: 0)
             // Replace the root view controller with RecipeListVC
             navController.setViewControllers([recipeListVC], animated: true)
         }
     }
}
