//
//  LCGroceryListVC.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/27/24.
//

import UIKit

class LCGroceryListVC: UIViewController {

    var groceryList: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .secondarySystemFill
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

//MARK: - tableview methods

extension LCGroceryListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = groceryList[indexPath.row].replacingOccurrences(of: "-", with: "")
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = .link
        return cell
    }
}
