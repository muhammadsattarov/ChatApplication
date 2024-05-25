//
//  UILabel+Extension.swift
//  ChatApp
//
//  Created by user on 14/05/24.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .avenir20(), color: UIColor? = .black) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = color
    }
}
