//
//  SectionHeader.swift
//  ChatApp
//
//  Created by user on 18/05/24.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let reuseId = "SectionHeader"
    
    private let headerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerLabel)
    
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leftAnchor.constraint(equalTo: leftAnchor),
            headerLabel.rightAnchor.constraint(equalTo: rightAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(text: String, font: UIFont?, textColor: UIColor) {
        headerLabel.text = text
        headerLabel.textColor = textColor
        headerLabel.font = font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
