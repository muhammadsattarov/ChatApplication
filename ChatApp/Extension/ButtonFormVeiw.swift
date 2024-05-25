//
//  ButtonFormVeiw.swift
//  ChatApp
//
//  Created by user on 14/05/24.
//

import UIKit

class ButtonFormVeiw: UIView {
    init(label: UILabel, button: UIButton) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(label)
        self.addSubview(button)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            button.leftAnchor.constraint(equalTo: self.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.rightAnchor),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
        bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
