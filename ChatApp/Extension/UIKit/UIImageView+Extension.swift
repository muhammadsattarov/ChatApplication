//
//  UIImageView+Extension.swift
//  ChatApp
//
//  Created by user on 14/05/24.
//

import UIKit

extension UIImageView {
    
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
}
