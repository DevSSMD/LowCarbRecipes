//
//  LCFavoritesCell.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/30/24.
//

import UIKit

class LCFavoritesCell: UITableViewCell {
    var recipeNameLabel = LCLabel(textColor: .label, alignment: .left , textStyle: .subheadline)
    var recipeImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Constants.reuseIDTableView)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(recipeImageView)
        addSubview(recipeNameLabel)
        
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.borderColor = UIColor.red.withAlphaComponent(0.25).cgColor
        recipeImageView.layer.borderWidth = 3
        recipeImageView.layer.cornerRadius = 10
        
        let padding: CGFloat = 35
        
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            recipeImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            recipeImageView.heightAnchor.constraint(equalToConstant: 80),
            recipeImageView.widthAnchor.constraint(equalToConstant: 80),
            
            recipeNameLabel.leftAnchor.constraint(equalTo: recipeImageView.rightAnchor, constant: 20),
            recipeNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            recipeNameLabel.centerYAnchor.constraint(equalTo: recipeImageView.centerYAnchor, constant: -10),
            recipeNameLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

}
