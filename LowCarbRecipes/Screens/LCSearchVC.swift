//
//  LCSearchVC.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/28/24.
//

import UIKit

class LCSearchVC: UIViewController {

    let tableView = UITableView()
    var originalList: [String] = []
    var recipeList: [String] = []
    var filteredList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchBar()
        configureTableView()
        getRecipeList()
    }

    private func configureSearchBar(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a recipe"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
     }
    

    private func getRecipeList(){
        if let cachedRecipes = CacheManager.shared.retrieveRecipes() {
            for recipe in cachedRecipes {
                recipeList.append(recipe.name)
                originalList = recipeList
            }
        } else {
                NetworkManager.shared.getRecipes { [weak self] result in
                    guard let self = self else {return}
                    switch result {
                    case .success(let recipes):
                        for recipe in recipes {
                            self.recipeList.append(recipe.name)
                            self.originalList = recipeList
                            CacheManager.shared.saveRecipes(recipes)
                            print("cahced")
                        }
                        
                        DispatchQueue.main.async { self.tableView.reloadData() }
                        
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 20
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
        ])
    }
}

//MARK: - tableView Methods
extension LCSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = recipeList[indexPath.row]
        return cell
    }
}

//MARK: - Search Methods
extension LCSearchVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.isEmpty else { return }
        
        filteredList = recipeList.filter { $0.localizedStandardContains(query) }
        recipeList = filteredList
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        recipeList = originalList
        tableView.reloadData()
    }
}
