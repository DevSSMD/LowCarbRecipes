//
//  LCTabBarVC.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/22/24.
//

import UIKit

class LCTabBarVC: UITabBarController {
    let welcomeScreenSeen = UserDefaults.standard.bool(forKey: "WelcomeScreenSeen")

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        UITabBar.appearance().tintColor = .systemRed
        UITabBar.appearance().isTranslucent = true 
        viewControllers = [
                           createRecipeListNavController(),
                           createFavoritesNavController(),
                           createGroceryListNavController(),
                           createSettingsNavController()]
        
        customizeNavigationBar()
    }

    
    
    private func createRecipeListNavController() -> UINavigationController {
        let welcomeVC = LCWelcomeVC()
        let recipeListVC = RecipeListVC()
        recipeListVC.title = "Browse"
        let tabBarIcon = UIImage(systemName: "fork.knife")
        welcomeVC.tabBarItem = UITabBarItem(title: "Recipes", image: tabBarIcon, tag: 0)

        recipeListVC.tabBarItem = UITabBarItem(title: "Recipes", image: tabBarIcon, tag: 0)
        if !welcomeScreenSeen {
            return UINavigationController(rootViewController: recipeListVC)
        } else {
            return UINavigationController(rootViewController: welcomeVC)
        }
    }

    private func createFavoritesNavController() -> UINavigationController {
        let favoritesVC = LCFavoritesVC()
        favoritesVC.title = "Favorites"
        let tabBarIcon = UIImage(systemName: "heart")
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: tabBarIcon, tag: 0)
        
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    private func createGroceryListNavController() -> UINavigationController {
        let groceryListVC = LCGroceryListVC()
        groceryListVC.title = "Groceries"
        let tabBarIcon = UIImage(systemName: "cart")
        groceryListVC.tabBarItem = UITabBarItem(title: "Grocery", image: tabBarIcon, tag: 2)
        
        return UINavigationController(rootViewController: groceryListVC)
    }
    
    private func createSettingsNavController() -> UINavigationController {
        let settingsVC = LCSettingsVC()
        settingsVC.title = "Settings"
        let tabBarIcon = UIImage(systemName: "gearshape")
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: tabBarIcon, tag: 0)
        
        return UINavigationController(rootViewController: settingsVC)
    }
    
    func customizeNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemRed
    }
}
