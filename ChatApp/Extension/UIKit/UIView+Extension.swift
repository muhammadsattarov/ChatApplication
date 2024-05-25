//
//  UIView+Extension.swift
//  ChatApp
//
//  Created by user on 14/05/24.

import UIKit


extension UIView {
    func applyGradients(cornerRadius: CGFloat) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientView = GradientView(from: .topLeading,
                                        to: .bottomTrailing,
                                        startColor: #colorLiteral(red: 0.8309458494, green: 0.7057176232, blue: 0.9536159635, alpha: 1),
                                        endColor: #colorLiteral(red: 0.4784313725, green: 0.6980392157, blue: 0.9215686275, alpha: 1))
        guard let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer else { return }
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = cornerRadius
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
