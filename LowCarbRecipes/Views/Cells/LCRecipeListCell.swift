//
//  LCRecipeListCell.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/22/24.
//

import UIKit

final class LCRecipeListCell: UITableViewCell {
    var recipeNameLabel = LCLabel(textColor: .black, alignment: .natural , textStyle: .title3)
    var recipeImageView = UIImageView()
    let titleLabelView = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Constants.reuseIDTableView)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(recipeImageView)
        recipeImageView.addSubview(titleLabelView)
        titleLabelView.addSubview(recipeNameLabel)
        titleLabelView.translatesAutoresizingMaskIntoConstraints = false
        
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true

        titleLabelView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
    
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            recipeImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabelView.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabelView.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabelView.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabelView.heightAnchor.constraint(equalToConstant: 90),
        
            recipeNameLabel.leftAnchor.constraint(equalTo: titleLabelView.leftAnchor, constant: 15),
            recipeNameLabel.rightAnchor.constraint(equalTo: titleLabelView.rightAnchor),
            recipeNameLabel.bottomAnchor.constraint(equalTo: titleLabelView.bottomAnchor),
            recipeNameLabel.heightAnchor.constraint(equalTo: titleLabelView.heightAnchor)
        ])
    }
}
