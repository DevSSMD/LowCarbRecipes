//
//  LCRecipeCardVC.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/22/24.
//

import UIKit


class LCRecipeCardVC: UIViewController {
       
    private let tableview = UITableView()
    var selectedImageURL: URL?
    var recipeName: String = ""
    var selectedRecipeImage = UIImageView()
    var recipeDescription: String = ""
    var ingredients: [String] = []
    var ingredientsWithoutAmounts: [String] = []
    var directions: [String] = []
    var dataSource: [[String]] = [[]]
    let favoriteButton = UIButton()
    var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configureTableView()
        setupDataSource()
        configureFavoriteButton()
    }
    
    private func configureTableView(){
        view.addSubview(tableview)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "buttonCell")
        tableview.register(LCDirectionsCell.self.self, forCellReuseIdentifier: "directionsCell")
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.frame = view.bounds
//        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.backgroundColor = .systemBackground
        
        if let imageURL = selectedImageURL {
            selectedRecipeImage.downloadImage(from: imageURL)
            selectedRecipeImage.contentMode = .scaleAspectFill
            selectedRecipeImage.clipsToBounds = true
        }
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.alpha = 0.3
        
        
        let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300))
        tableHeaderView.addSubview(selectedRecipeImage)
        tableHeaderView.addSubview(blurEffectView)
        
        
        selectedRecipeImage.translatesAutoresizingMaskIntoConstraints = false
        tableview.rowHeight = UITableView.automaticDimension
        tableview.separatorStyle = .none
        
         
        
        NSLayoutConstraint.activate([
            selectedRecipeImage.topAnchor.constraint(equalTo: tableHeaderView.topAnchor),
            selectedRecipeImage.leftAnchor.constraint(equalTo: tableHeaderView.leftAnchor),
            selectedRecipeImage.rightAnchor.constraint(equalTo: tableHeaderView.rightAnchor),
            selectedRecipeImage.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor),
        
            blurEffectView.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor),
            blurEffectView.leftAnchor.constraint(equalTo: tableHeaderView.leftAnchor),
            blurEffectView.rightAnchor.constraint(equalTo: tableHeaderView.rightAnchor),
            blurEffectView.heightAnchor.constraint(equalToConstant: 40)
        
        ])
        
        tableview.tableHeaderView = tableHeaderView
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        tableview.tableFooterView = footerView
    }
    
    private func setupDataSource() {
        dataSource.removeAll()
        dataSource.append([recipeDescription])
        dataSource.append(ingredients)
        dataSource.append(directions)
    }
    
    private func configureFavoriteButton() {
        view.addSubview(favoriteButton)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        let heartImage = UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal)
        favoriteButton.setImage(heartImage, for: .normal)
        favoriteButton.tintColor = .systemRed
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        
        favoriteButton.contentVerticalAlignment = .fill
        favoriteButton.contentHorizontalAlignment = .fill
        
        
        NSLayoutConstraint.activate([
            favoriteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            favoriteButton.widthAnchor.constraint(equalToConstant: 70),
            favoriteButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        updateFavoriteButtonAppearance()
    }
    
    private func updateFavoriteButtonAppearance() {
        let heartImageName = isFavorite ? "heart.fill" : "heart"
        let heartImage = UIImage(systemName: heartImageName)?.withRenderingMode(.alwaysOriginal)
        favoriteButton.setImage(heartImage, for: .normal)
        favoriteButton.imageView?.contentMode = .scaleAspectFit
    }
    
    @objc private func favoriteTapped() {
        isFavorite.toggle()
        print("tapped")
        updateFavoriteButtonAppearance()
    }
}

//MARK: - tableview emthods
extension LCRecipeCardVC: UITableViewDelegate, UITableViewDataSource {
  
    // Did Select at indexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//HEADER METHODS
    // Height for header in seciton
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == dataSource.count ? 0.0 : 40.0
    }
    
    // View for Header in seciton
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == dataSource.count  {
            return nil
        } else {
            let headerView = UIView()
            headerView.backgroundColor = .systemBackground
            switch section {
            case 0:
                let title = LCLabel(textColor: .label, alignment: .center, textStyle: .headline)
                title.text = recipeName
                headerView.addSubview(title)
                NSLayoutConstraint.activate([
                    title.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                    title.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -10),
                ])
            case 1:
                let title = LCLabel(textColor: .label, alignment: .center, textStyle: .headline)
                title.text = "Ingredients"
                headerView.addSubview(title)
                NSLayoutConstraint.activate([
                    title.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                    title.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -10),
                ])
            case 2:
                let title = LCLabel(textColor: .label, alignment: .center, textStyle: .headline)
                title.text = "Directions"
                headerView.addSubview(title)
                NSLayoutConstraint.activate([
                    title.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                    title.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -10),
                ])
            default:
                return headerView
            }
            return headerView
        }
    }

// Section Methods
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count + 1
    }

    // Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == dataSource.count {
                return 1
        } else {
                return dataSource[section].count
        }
    }
    
    
// Cell for row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == dataSource.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath)
            let button = LCButton(backgroundColor: .systemRed, text: "Add to grocery list! 📋")
            cell.contentView.addSubview(button)
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10),
                button.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                button.widthAnchor.constraint(equalToConstant: tableview.frame.size.width - 70),
                button.heightAnchor.constraint(equalToConstant: 50)
             ])
            button.addTarget(self, action: #selector(addToGroceryList), for: .touchUpInside)
            button.isUserInteractionEnabled = true
            
            return cell
            
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "directionsCell", for: indexPath) as! LCDirectionsCell
            cell.configure(with: dataSource[indexPath.section][indexPath.row])
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = dataSource[indexPath.section][indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
            cell.textLabel?.minimumScaleFactor = 0.5
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.backgroundColor = .systemBackground
         
            
            if indexPath.section == 1 || indexPath.section == 2 {
                let separator = UIView()
                separator.backgroundColor = .gray
                cell.addSubview(separator)
                separator.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    separator.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
                    separator.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
                    separator.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
                    separator.heightAnchor.constraint(equalToConstant: 1.0)
                ])
            } else {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: .greatestFiniteMagnitude, right: .greatestFiniteMagnitude)
            }
            return cell
            
        }
    }
    
    @objc func addToGroceryList(){
        if let tabBarController = self.tabBarController as? LCTabBarVC {
            if let navigationController = tabBarController.viewControllers?[2] as? UINavigationController {
                if let groceryListVC = navigationController.topViewController as? LCGroceryListVC {
                    let uniqueIngredients = ingredientsWithoutAmounts.filter {!groceryListVC.groceryList.contains($0) }
                    groceryListVC.groceryList.append(contentsOf: uniqueIngredients)
                    groceryListVC.tableView.reloadData()
                
                    if uniqueIngredients != ingredientsWithoutAmounts {
                        let ac = UIAlertController(title: "Oops!", message: "Already in grocery list!", preferredStyle: .alert)
                        ac.view.layer.borderColor = UIColor.systemRed.cgColor
                        ac.view.layer.cornerRadius = 20
                        ac.view.backgroundColor = .secondarySystemBackground
                        ac.view.backgroundColor?.withAlphaComponent(0.75)
                        let alertAction = UIAlertAction(title: "Ok", style: .default)
                        ac.addAction(alertAction)
                        present(ac, animated: true)
                    } else {
                        let ac = UIAlertController(title: "Success", message: "Added to grocery list!", preferredStyle: .alert)
                        ac.view.layer.borderColor = UIColor.systemRed.cgColor
                        ac.view.layer.cornerRadius = 20
                        ac.view.backgroundColor = .secondarySystemBackground
                        ac.view.backgroundColor?.withAlphaComponent(0.75)
                        let alertAction = UIAlertAction(title: "Ok", style: .default)
                        ac.addAction(alertAction)
                        present(ac, animated: true)
                    }
                    print("Items added to the grocery list: \(ingredientsWithoutAmounts)")
                } else {
                    print("LCGroceryListVC not found as the top view controller in the navigation stack")
                }
            } else {
                print("Navigation controller not found at index 2")
            }
        } else {
            print("Tab bar controller is not of type LCTabBarVC")
        }
    }
}
    
    
    
    
    
    
    
    
    
    
    
    
    
