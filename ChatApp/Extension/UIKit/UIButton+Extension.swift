//
//  UIButton+Extension.swift
//  ChatApp
//
//  Created by user on 14/05/24.
//

import UIKit

extension UIButton {
    
    convenience init(title: String,
                     titleColor: UIColor,
                     backgroundColor: UIColor,
                     font: UIFont? = .avenir20(),
                     isShadow: Bool = false,
                     cornerRadius: CGFloat = 5) {
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
        
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.2
            self.layer.shadowRadius = 5
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }
}
