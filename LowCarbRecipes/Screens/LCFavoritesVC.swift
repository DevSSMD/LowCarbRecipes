//
//  LCFavoritesVC.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/22/24.
//

import UIKit

class LCFavoritesVC: UIViewController {
    
    let tableView = UITableView()
    public var favorites: [FavoriteRecipe] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        updateEmptyStateView()
    }
    
    func updateEmptyStateView(){
        if favorites.isEmpty {
            showEmptyStateView()
        } else {
            hideEmptyStateView()
        }
    }
    
    func showEmptyStateView() {
        let emptyStateView = LCEmptyStateView("No favorites yet", "heart")
        tableView.isHidden = true
        view.addSubview(emptyStateView)
        view.bringSubviewToFront(emptyStateView)
        
        NSLayoutConstraint.activate([
            emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 2)
        ])
    }
    
    
    func hideEmptyStateView() {
        tableView.isHidden = false
        view.subviews.filter { $0 is LCEmptyStateView }.forEach { $0.removeFromSuperview() }
    }
    
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.bounds
        tableView.register(LCFavoritesCell.self, forCellReuseIdentifier: "favoriteCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    
}

//MARK: - tableview methods
extension LCFavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! LCFavoritesCell
        let favoriteRecipe = favorites[indexPath.row]
        cell.recipeNameLabel.text = favoriteRecipe.name
        cell.recipeImageView.image = favoriteRecipe.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
