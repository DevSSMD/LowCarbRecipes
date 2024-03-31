//
//  LCButton.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/27/24.
//

import UIKit

class LCButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, text: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(text, for: .normal)
    }
    
    private func  configure() {
        layer.cornerRadius = 15
        setTitleColor(.label, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
