//
//  LCDirectionsCell.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/28/24.
//

import UIKit

final class LCDirectionsCell: UITableViewCell {
    let directionsLabel = LCLabel(textColor: .label, alignment: .left, textStyle: .caption1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ directionsText: String) {
        self.init(frame: .zero)
        self.directionsLabel.text = directionsText
    }
    
    private func configure() {
        contentView.addSubview(directionsLabel)
    
        let padding: CGFloat = 10
        
        
        directionsLabel.setContentHuggingPriority(.required, for: .vertical)
        directionsLabel.setContentCompressionResistancePriority(.required, for: .vertical)
           
        
        NSLayoutConstraint.activate([
            directionsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            directionsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            directionsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            directionsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            directionsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),

        ])
    }
    
    public func configure(with directions: String) {
        directionsLabel.text = directions
    }
}
