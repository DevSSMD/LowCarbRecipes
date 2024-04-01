//
//  LCEmptyStateView.swift
//  LowCarbRecipes
//
//  Created by Sana Siddiqui on 3/31/24.
//

import UIKit

class LCEmptyStateView: UIView {

    let imageView = UIImageView()
    let messageLabel = LCLabel(textColor: .systemRed, alignment: .center, textStyle: .caption1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ messageText: String, _ imageName: String ) {
        self.init(frame: .zero)
        self.messageLabel.text = messageText
        self.imageView.image = UIImage(named: imageName)
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addSubview(messageLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.7
        
        NSLayoutConstraint.activate([
        
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -45),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            messageLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            messageLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
