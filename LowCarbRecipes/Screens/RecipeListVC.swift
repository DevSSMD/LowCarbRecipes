//
//  RecipeListVC.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/22/24.
//

import UIKit

class RecipeListVC: LCDataLoadingVC {
    let tableView = UITableView()
    var recipes: [Recipe] = []
    let placeholderImage = UIImage(named: "emptyImage")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingView()
        configureViewController()
        configureTableView()
        getRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
    }
    

    
    private func getRecipes(){
        if let cachedRecipes = CacheManager.shared.retrieveRecipes() {
            self.recipes = cachedRecipes
            tableView.reloadData()
            dismissLoadingView()
        } else {
            NetworkManager.shared.getRecipes { [weak self] result in
                guard let self = self else { return }
                dismissLoadingView()
                switch result {
                case .success(let recipes):
                    self.recipes = recipes
                    CacheManager.shared.saveRecipes(recipes)
                    DispatchQueue.main.async { self.tableView.reloadData() }
                    
                case .failure(let error):
                    print(error.rawValue)
                }
            }
        }
    }
    
    
    private func configureViewController(){
        title = "Browse"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
    }
    
   @objc private func searchTapped() {
       let searchVC = LCSearchVC()
       navigationController?.pushViewController(searchVC, animated: true)
    }
    
    private func configureTableView()  {
        view.addSubview(tableView)
        tableView.register(LCRecipeListCell.self, forCellReuseIdentifier: Constants.reuseIDTableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
}

//MARK: - TableView Methods
extension RecipeListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIDTableView, for: indexPath) as! LCRecipeListCell
        let recipe = recipes[indexPath.row]
        cell.recipeNameLabel.text = "\(recipe.name)"
        cell.recipeNameLabel.numberOfLines = 0
        
        cell.recipeImageView.image = placeholderImage
        print(recipe.image)
        
        if let cachedImage = CacheManager.shared.retrieveImage(forURL: recipe.image) {
            DispatchQueue.main.async {
                cell.recipeImageView.image = cachedImage
                print("cache hit for URL: \(recipe.image) ")
            }
        } else {
            NetworkManager.shared.downloadImage(from: recipe.image) { [weak self] image in
                guard let self = self else { return }
                print("cache missed for URL \(recipe.image)")
                DispatchQueue.main.async {
                    if let downloadedImage = image {
                        CacheManager.shared.saveImage(downloadedImage, forURL: recipe.image)
                        UIView.transition(with: cell.recipeImageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                            cell.recipeImageView.image = downloadedImage
                            }, completion: nil)
                    } else {
                        cell.recipeImageView.image = self.placeholderImage
                    }
                }
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeCardVC = LCRecipeCardVC()
        let selectedRecipe = recipes[indexPath.row]
        recipeCardVC.selectedImageURL = selectedRecipe.image
        recipeCardVC.recipeDescription = selectedRecipe.description.replacingOccurrences(of: "###", with: "||")
        recipeCardVC.directions = selectedRecipe.steps
        recipeCardVC.recipeName = selectedRecipe.name
        for ingredient in selectedRecipe.ingredients {
            recipeCardVC.ingredientsWithoutAmounts.append(ingredient.name)
        }
        
        var ingredientNamesWithAmounts: [String] = []
        for ingredient in selectedRecipe.ingredients {
            if let desc = ingredient.servingSize.desc {
                ingredientNamesWithAmounts.append(" - \(desc) \(ingredient.name)")
            } else {
                ingredientNamesWithAmounts.append(" - \(ingredient.name)")
            }
        }
        recipeCardVC.ingredients = ingredientNamesWithAmounts
        navigationController?.pushViewController(recipeCardVC, animated: true)
    }
}
