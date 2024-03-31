//
//  LCLabel.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/22/24.
//

import UIKit


class LCLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textColor: UIColor, alignment: NSTextAlignment, textStyle: UIFont.TextStyle) {
        self.init(frame: .zero)
        self.textColor = textColor
        self.textAlignment = alignment
        self.font = UIFont.preferredFont(forTextStyle: textStyle)
    }
    
    
    private func configure() {
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
